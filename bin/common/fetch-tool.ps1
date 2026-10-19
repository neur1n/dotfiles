<#
Download the latest prebuilt archives for a small CLI toolset.

Supported host:
  Windows x86_64 / ARM64

Usage:
  .\fetch-tool.ps1 <target> [destination]
  .\fetch-tool.ps1 --help

Targets: bottom, deja-vu, fd, fzf, neovim, nushell, opencode,
  ripgrep, tree-sitter, zellij, zoxide

The script only downloads archives; it does not extract or install them.
Downloader preference: wget.exe, then curl.exe.

OpenCode uses the official V2 download endpoint; other targets use GitHub's
latest stable release API. Optional GITHUB_TOKEN authenticates API queries
only, never archive downloads. API redirects are not followed.
#>

param(
  [Parameter(Position = 0)]
  [string]$Target = "",

  [Parameter(Position = 1)]
  [string]$Destination = $PWD.Path
)

$ErrorActionPreference = "Stop"

function Show-Usage {
  Write-Host "Usage: fetch-tool.ps1 <target> [destination]"
  Write-Host "Targets: bottom deja-vu fd fzf neovim nushell opencode ripgrep tree-sitter zellij zoxide"
  Write-Host "Optional environment: GITHUB_TOKEN (GitHub API queries only)."
}

$ValidTargets = @(
  "bottom", "deja-vu", "fd", "fzf", "neovim", "nushell",
  "opencode", "ripgrep", "tree-sitter", "zellij", "zoxide"
)

if ($Target -eq "-h" -or $Target -eq "--help") {
  Show-Usage
  exit 0
}

if ([string]::IsNullOrWhiteSpace($Target)) {
  Show-Usage
  exit 2
}

if ($ValidTargets -notcontains $Target) {
  [Console]::Error.WriteLine("Unsupported target: $Target")
  Show-Usage
  exit 2
}

$Wget = Get-Command wget.exe -ErrorAction SilentlyContinue
$Curl = Get-Command curl.exe -ErrorAction SilentlyContinue

if ($Wget) {
  $Downloader = "wget"
} elseif ($Curl) {
  $Downloader = "curl"
} else {
  throw "Neither wget.exe nor curl.exe is available."
}

$RawArch = if ($env:PROCESSOR_ARCHITEW6432) {
  $env:PROCESSOR_ARCHITEW6432
} else {
  $env:PROCESSOR_ARCHITECTURE
}

switch -Regex ($RawArch) {
  "^(AMD64|x86_64)$" { $Arch = "x86_64"; break }
  "^(ARM64|aarch64)$" { $Arch = "aarch64"; break }
  default { throw "Unsupported Windows architecture: $RawArch" }
}

New-Item -ItemType Directory -Force -Path $Destination | Out-Null

$script:Ok = 0
$script:Skip = 0
$script:Fail = 0

function Write-Diagnostic {
  param([string]$Message)

  if (-not [string]::IsNullOrEmpty($env:GITHUB_TOKEN)) {
    $Message = $Message.Replace($env:GITHUB_TOKEN, '[REDACTED]')
  }
  if ($Message.Length -gt 500) {
    $Message = $Message.Substring(0, 500)
  }
  [Console]::Error.WriteLine("       $Message")
}

function Invoke-Request {
  param(
    [Parameter(Mandatory)][string]$Url,
    [Parameter(Mandatory)][string]$Path,
    [switch]$GitHubApi
  )

  $headersPath = [System.IO.Path]::GetTempFileName()
  $errorsPath = [System.IO.Path]::GetTempFileName()
  try {
    $requestArgs = @('--user-agent', 'dotfiles-fetch-tool')
    if ($GitHubApi) {
      if (-not $Url.StartsWith('https://api.github.com/', [System.StringComparison]::Ordinal)) {
        throw 'Refusing to send GitHub API headers to another host.'
      }
      $requestArgs += @('--header', 'Accept: application/vnd.github+json')
      if (-not [string]::IsNullOrEmpty($env:GITHUB_TOKEN)) {
        $requestArgs += @('--header', "Authorization: Bearer $env:GITHUB_TOKEN")
      }
    }

    Remove-Item -LiteralPath $Path -Force -ErrorAction SilentlyContinue
    # Windows PowerShell wraps native stderr in error records. Capture their
    # message text, not formatted records that would corrupt response headers.
    $savedPreference = $ErrorActionPreference
    try {
      $ErrorActionPreference = 'Continue'
      if ($Downloader -eq 'wget') {
        if ($GitHubApi) {
          $requestArgs += '--max-redirect=0'
        }
        $nativeMessages = @(& $Wget.Source --no-verbose --server-response --content-on-error @requestArgs -O $Path $Url 2>&1)
        $logPath = $headersPath
      } else {
        if ($GitHubApi) {
          $requestArgs += @('--no-location', '--max-redirs', '0')
        } else {
          $requestArgs += '--location'
        }
        # Keep HTTP error bodies so GitHub's message can be reported.
        $nativeMessages = @(& $Curl.Source --silent --show-error @requestArgs --dump-header $headersPath -o $Path $Url 2>&1)
        $logPath = $errorsPath
      }
      $code = $LASTEXITCODE
    } finally {
      $ErrorActionPreference = $savedPreference
    }
    $nativeMessages | ForEach-Object { $_.ToString() } | Set-Content -LiteralPath $logPath

    $headers = @(Get-Content -LiteralPath $headersPath)
    $statusLines = @($headers | Where-Object { $_ -match '^\s*HTTP/\S+\s+\d{3}' })
    $status = if ($statusLines.Count -gt 0) {
      [regex]::Match($statusLines[-1], 'HTTP/\S+\s+(\d{3})').Groups[1].Value
    } else {
      'unavailable'
    }
    if ($code -eq 0 -and $status -match '^2\d{2}$') {
      return $true
    }

    Write-Diagnostic "Request URL: $Url"
    Write-Diagnostic "Downloader: $Downloader; exit code: $code; HTTP status: $status"
    if ($GitHubApi) {
      if (Test-Path -LiteralPath $Path -PathType Leaf) {
        try {
          $errorBody = Get-Content -LiteralPath $Path -Raw -Encoding UTF8 | ConvertFrom-Json
          if ($errorBody.message) {
            Write-Diagnostic "GitHub message: $($errorBody.message)"
          }
        } catch {
          # A proxy may return HTML instead of a GitHub JSON error body.
        }
      }
      $responseHeaders = @{}
      foreach ($line in $headers) {
        if ($line -match '^\s*HTTP/') {
          $responseHeaders.Clear()
        } elseif ($line -match '^\s*([^: ]+):\s*(.*)$') {
          $responseHeaders[$Matches[1]] = $Matches[2].Trim()
        }
      }
      foreach ($key in 'x-ratelimit-remaining', 'x-ratelimit-reset', 'retry-after') {
        if ($responseHeaders.ContainsKey($key)) {
          Write-Diagnostic "$key`: $($responseHeaders[$key])"
        }
      }
      if ($status -match '^3\d{2}$') {
        Write-Diagnostic 'API redirects are disabled to protect GITHUB_TOKEN.'
      }
    }

    # wget mixes headers and transport errors in stderr; omit header lines.
    $details = if ($Downloader -eq 'wget') { $headers } else { @(Get-Content -LiteralPath $errorsPath) }
    $details | Where-Object { $_ -and $_ -notmatch '^\s' } | Select-Object -Last 5 |
      ForEach-Object { Write-Diagnostic $_ }
    return $false
  } finally {
    Remove-Item -LiteralPath $headersPath, $errorsPath -Force -ErrorAction SilentlyContinue
  }
}

function Get-Text {
  param([Parameter(Mandatory)][string]$Url)

  $bodyPath = [System.IO.Path]::GetTempFileName()
  try {
    if (-not (Invoke-Request -Url $Url -Path $bodyPath -GitHubApi)) {
      throw "API request failed: $Url"
    }
    return (Get-Content -LiteralPath $bodyPath -Raw -Encoding UTF8)
  } finally {
    Remove-Item -LiteralPath $bodyPath -Force -ErrorAction SilentlyContinue
  }
}

function Test-ZipArchive {
  param([Parameter(Mandatory)][string]$Path)

  if (-not $Path.EndsWith(".zip", [System.StringComparison]::OrdinalIgnoreCase)) {
    return $true
  }

  try {
    Add-Type -AssemblyName System.IO.Compression.FileSystem -ErrorAction SilentlyContinue
    $zip = [System.IO.Compression.ZipFile]::OpenRead($Path)
    $zip.Dispose()
    return $true
  } catch {
    return $false
  }
}

function Download-ReleaseAsset {
  param(
    [Parameter(Mandatory)][string]$Name,
    [Parameter(Mandatory)][string]$Repo,
    [Parameter(Mandatory)][string[]]$Patterns
  )

  if ($Name -ne $Target) {
    return
  }

  $releaseUrl = "https://api.github.com/repos/$Repo/releases/latest"
  try {
    $json = Get-Text $releaseUrl
    try {
      $release = $json | ConvertFrom-Json
      if ($null -eq $release -or -not ($release.assets -is [array])) {
        throw 'Expected an assets array.'
      }
      foreach ($asset in $release.assets) {
        if (-not ($asset.name -is [string]) -or -not ($asset.browser_download_url -is [string])) {
          throw 'Expected asset names and download URLs.'
        }
      }
    } catch {
      Write-Diagnostic "Could not parse release metadata (expected assets with names and download URLs). URL: $releaseUrl"
      throw
    }
  } catch {
    Write-Host "[FAIL] $Name`: could not query latest release for $Repo" -ForegroundColor Red
    $candidateUrls = @(
      foreach ($pattern in $Patterns) {
        if ($pattern.Contains("*") -or $pattern.Contains("[")) {
          continue
        }

        $candidateName = $pattern.TrimStart("^").TrimEnd("$").Replace("\.", ".")
        "https://github.com/$Repo/releases/latest/download/$candidateName"
      }
    )

    if ($candidateUrls.Count -eq 0) {
      Write-Host "       Candidate URL: $releaseUrl" -ForegroundColor Red
    } else {
      foreach ($candidateUrl in $candidateUrls) {
        Write-Host "       Candidate URL: $candidateUrl" -ForegroundColor Red
      }
    }
    $script:Fail++
    return
  }

  $selectedUrls = @()
  foreach ($pattern in $Patterns) {
    $asset = @($release.assets) |
      Where-Object { $_.name -match $pattern } |
      Select-Object -First 1

    if (-not $asset) {
      continue
    }

    $selectedUrls += $asset.browser_download_url
  }

  if ($selectedUrls.Count -eq 0) {
    Write-Host "[SKIP] $Name`: no native release asset for windows/$Arch" -ForegroundColor Yellow
    Write-Host "       Candidate URL: $releaseUrl" -ForegroundColor Yellow
    $script:Skip++
    return
  }

  Download-Assets -Name $Name -Urls $selectedUrls
}

function Download-Assets {
  param(
    [Parameter(Mandatory)][string]$Name,
    [Parameter(Mandatory)][string[]]$Urls
  )

  foreach ($url in $Urls) {
    $filename = ($url -split '/')[-1]
    $path = Join-Path $Destination $filename

    Write-Host ""
    Write-Host "[$Name] $filename"

    if (-not (Invoke-Request -Url $url -Path $path)) {
      Write-Warning "$Name`: download failed for $filename; trying fallback if available."
      Write-Warning "Candidate URL: $url"
      Remove-Item -LiteralPath $path -Force -ErrorAction SilentlyContinue
      continue
    }

    if (-not (Test-ZipArchive -Path $path)) {
      Write-Warning "$Name`: archive validation failed for $filename; trying fallback if available."
      Write-Warning "Candidate URL: $url"
      Remove-Item -LiteralPath $path -Force -ErrorAction SilentlyContinue
      continue
    }

    Write-Host "[OK]   $Name -> $path" -ForegroundColor Green
    $script:Ok++
    return
  }

  Write-Host "[FAIL] $Name`: all matching assets failed to download/validate" -ForegroundColor Red
  $script:Fail++
}

function Download-OpenCode {
  param([Parameter(Mandatory)][string]$Filename)

  if ($Target -ne 'opencode') {
    return
  }
  Download-Assets -Name 'opencode' -Urls @("https://opencode.ai/update/api/latest/cli/opencode/$Filename")
}

Write-Host "Detected: windows/$Arch"
Write-Host "Downloader: $Downloader"
Write-Host "Destination: $Destination"
Write-Host "Target: $Target"

if ($Arch -eq "x86_64") {
  Download-ReleaseAsset "bottom" "ClementTsang/bottom" @(
    '^bottom_x86_64-pc-windows-msvc\.zip$'
  )

  Download-ReleaseAsset "deja-vu" "vshulcz/deja-vu" @(
    '^deja-vu_.*_windows_amd64\.zip$'
  )

  Download-ReleaseAsset "fd" "sharkdp/fd" @(
    '^fd-v.*-x86_64-pc-windows-msvc\.zip$'
  )

  Download-ReleaseAsset "fzf" "junegunn/fzf" @(
    '^fzf-.*-windows_amd64\.zip$'
  )

  Download-ReleaseAsset "neovim" "neovim/neovim" @(
    '^nvim-win64\.zip$'
  )

  Download-ReleaseAsset "nushell" "nushell/nushell" @(
    '^nu-.*-x86_64-pc-windows-msvc\.zip$'
  )

  # Explicitly choose the normal x64 build, never *baseline*.
  Download-OpenCode 'opencode-windows-x64.zip'

  Download-ReleaseAsset "ripgrep" "BurntSushi/ripgrep" @(
    '^ripgrep-.*-x86_64-pc-windows-msvc\.zip$'
  )

  Download-ReleaseAsset "tree-sitter" "tree-sitter/tree-sitter" @(
    '^tree-sitter-cli-windows-x64\.zip$',
    '^tree-sitter-windows-x64\.gz$'
  )

  Download-ReleaseAsset "zellij" "zellij-org/zellij" @(
    '^zellij-x86_64-pc-windows-msvc\.zip$'
  )

  Download-ReleaseAsset "zoxide" "ajeetdsouza/zoxide" @(
    '^zoxide-.*-x86_64-pc-windows-msvc\.zip$'
  )
}
elseif ($Arch -eq "aarch64") {
  Download-ReleaseAsset "bottom" "ClementTsang/bottom" @(
    '^bottom_aarch64-pc-windows-msvc\.zip$'
  )

  Download-ReleaseAsset "deja-vu" "vshulcz/deja-vu" @(
    '^deja-vu_.*_windows_arm64\.zip$'
  )

  Download-ReleaseAsset "fd" "sharkdp/fd" @(
    '^fd-v.*-aarch64-pc-windows-msvc\.zip$'
  )

  # No native Windows ARM64 fzf asset at present. Keeping the pattern means
  # the script will start downloading it automatically if upstream adds one.
  Download-ReleaseAsset "fzf" "junegunn/fzf" @(
    '^fzf-.*-windows_arm64\.zip$'
  )

  Download-ReleaseAsset "neovim" "neovim/neovim" @(
    '^nvim-win-arm64\.zip$'
  )

  Download-ReleaseAsset "nushell" "nushell/nushell" @(
    '^nu-.*-aarch64-pc-windows-msvc\.zip$'
  )

  Download-OpenCode 'opencode-windows-arm64.zip'

  Download-ReleaseAsset "ripgrep" "BurntSushi/ripgrep" @(
    '^ripgrep-.*-aarch64-pc-windows-msvc\.zip$'
  )

  Download-ReleaseAsset "tree-sitter" "tree-sitter/tree-sitter" @(
    '^tree-sitter-cli-windows-arm64\.zip$',
    '^tree-sitter-windows-arm64\.gz$'
  )

  # Zellij currently has no native Windows ARM64 release asset.
  Download-ReleaseAsset "zellij" "zellij-org/zellij" @(
    '^zellij-aarch64-pc-windows-msvc\.zip$'
  )

  Download-ReleaseAsset "zoxide" "ajeetdsouza/zoxide" @(
    '^zoxide-.*-aarch64-pc-windows-msvc\.zip$'
  )
}

Write-Host ""
Write-Host "Summary: OK=$($script:Ok), SKIP=$($script:Skip), FAIL=$($script:Fail)"

if ($script:Fail -gt 0) {
    exit 1
}
