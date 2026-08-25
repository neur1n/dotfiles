<#
Download the latest stable prebuilt archives for a small CLI toolset.

Supported host:
  Windows x86_64 / ARM64

Usage:
  .\fetch-tool.ps1 <target> [destination]
  .\fetch-tool.ps1 --help

Targets: bottom, fd, fzf, ripgrep, tree-sitter, zoxide, neovim,
         nushell, opencode, deja-vu, zellij

The script only downloads archives; it does not extract or install them.
Downloader preference: wget.exe, then curl.exe.
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
    Write-Host "Targets: bottom fd fzf ripgrep tree-sitter zoxide neovim nushell opencode deja-vu zellij"
}

$ValidTargets = @(
    "bottom", "fd", "fzf", "ripgrep", "tree-sitter", "zoxide",
    "neovim", "nushell", "opencode", "deja-vu", "zellij"
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

function Get-Text {
    param([Parameter(Mandatory)][string]$Url)

    if ($Downloader -eq "wget") {
        $out = & $Wget.Source -qO- $Url
    } else {
        $out = & $Curl.Source -fsSL $Url
    }

    if ($LASTEXITCODE -ne 0) {
        throw "Failed to fetch $Url"
    }

    return ($out -join "`n")
}

function Invoke-Download {
    param(
        [Parameter(Mandatory)][string]$Url,
        [Parameter(Mandatory)][string]$Path
    )

    Remove-Item -Force -ErrorAction SilentlyContinue $Path

    if ($Downloader -eq "wget") {
        & $Wget.Source -O $Path $Url
    } else {
        & $Curl.Source -fL --progress-bar -o $Path $Url
    }

    return ($LASTEXITCODE -eq 0)
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
        $release = $json | ConvertFrom-Json
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

    $found = $false

    foreach ($pattern in $Patterns) {
        $asset = @($release.assets) |
            Where-Object { $_.name -match $pattern } |
            Select-Object -First 1

        if (-not $asset) {
            continue
        }

        $found = $true
        $path = Join-Path $Destination $asset.name

        Write-Host ""
        Write-Host "[$Name] $($asset.name)"

        if (-not (Invoke-Download -Url $asset.browser_download_url -Path $path)) {
            Write-Warning "$Name`: download failed for $($asset.name); trying fallback if available."
            Write-Warning "Candidate URL: $($asset.browser_download_url)"
            Remove-Item -Force -ErrorAction SilentlyContinue $path
            continue
        }

        if (-not (Test-ZipArchive -Path $path)) {
            Write-Warning "$Name`: archive validation failed for $($asset.name); trying fallback if available."
            Write-Warning "Candidate URL: $($asset.browser_download_url)"
            Remove-Item -Force -ErrorAction SilentlyContinue $path
            continue
        }

        Write-Host "[OK]   $Name -> $path" -ForegroundColor Green
        $script:Ok++
        return
    }

    if (-not $found) {
        Write-Host "[SKIP] $Name`: no native release asset for windows/$Arch" -ForegroundColor Yellow
        Write-Host "       Candidate URL: $releaseUrl" -ForegroundColor Yellow
        $script:Skip++
    } else {
        Write-Host "[FAIL] $Name`: all matching assets failed to download/validate" -ForegroundColor Red
        $script:Fail++
    }
}

Write-Host "Detected: windows/$Arch"
Write-Host "Downloader: $Downloader"
Write-Host "Destination: $Destination"
Write-Host "Target: $Target"

if ($Arch -eq "x86_64") {
    Download-ReleaseAsset "bottom" "ClementTsang/bottom" @(
        '^bottom_x86_64-pc-windows-msvc\.zip$'
    )

    Download-ReleaseAsset "fd" "sharkdp/fd" @(
        '^fd-v.*-x86_64-pc-windows-msvc\.zip$'
    )

    Download-ReleaseAsset "fzf" "junegunn/fzf" @(
        '^fzf-.*-windows_amd64\.zip$'
    )

    Download-ReleaseAsset "ripgrep" "BurntSushi/ripgrep" @(
        '^ripgrep-.*-x86_64-pc-windows-msvc\.zip$'
    )

    Download-ReleaseAsset "tree-sitter" "tree-sitter/tree-sitter" @(
        '^tree-sitter-cli-windows-x64\.zip$',
        '^tree-sitter-windows-x64\.gz$'
    )

    Download-ReleaseAsset "zoxide" "ajeetdsouza/zoxide" @(
        '^zoxide-.*-x86_64-pc-windows-msvc\.zip$'
    )

    Download-ReleaseAsset "neovim" "neovim/neovim" @(
        '^nvim-win64\.zip$'
    )

    Download-ReleaseAsset "nushell" "nushell/nushell" @(
        '^nu-.*-x86_64-pc-windows-msvc\.zip$'
    )

    # Explicitly choose the normal x64 build, never *baseline*.
    Download-ReleaseAsset "opencode" "anomalyco/opencode" @(
        '^opencode-windows-x64\.zip$'
    )

    Download-ReleaseAsset "deja-vu" "vshulcz/deja-vu" @(
        '^deja-vu_.*_windows_amd64\.zip$'
    )

    Download-ReleaseAsset "zellij" "zellij-org/zellij" @(
        '^zellij-x86_64-pc-windows-msvc\.zip$'
    )
}
elseif ($Arch -eq "aarch64") {
    Download-ReleaseAsset "bottom" "ClementTsang/bottom" @(
        '^bottom_aarch64-pc-windows-msvc\.zip$'
    )

    Download-ReleaseAsset "fd" "sharkdp/fd" @(
        '^fd-v.*-aarch64-pc-windows-msvc\.zip$'
    )

    # No native Windows ARM64 fzf asset at present. Keeping the pattern means
    # the script will start downloading it automatically if upstream adds one.
    Download-ReleaseAsset "fzf" "junegunn/fzf" @(
        '^fzf-.*-windows_arm64\.zip$'
    )

    Download-ReleaseAsset "ripgrep" "BurntSushi/ripgrep" @(
        '^ripgrep-.*-aarch64-pc-windows-msvc\.zip$'
    )

    Download-ReleaseAsset "tree-sitter" "tree-sitter/tree-sitter" @(
        '^tree-sitter-cli-windows-arm64\.zip$',
        '^tree-sitter-windows-arm64\.gz$'
    )

    Download-ReleaseAsset "zoxide" "ajeetdsouza/zoxide" @(
        '^zoxide-.*-aarch64-pc-windows-msvc\.zip$'
    )

    Download-ReleaseAsset "neovim" "neovim/neovim" @(
        '^nvim-win-arm64\.zip$'
    )

    Download-ReleaseAsset "nushell" "nushell/nushell" @(
        '^nu-.*-aarch64-pc-windows-msvc\.zip$'
    )

    Download-ReleaseAsset "opencode" "anomalyco/opencode" @(
        '^opencode-windows-arm64\.zip$'
    )

    Download-ReleaseAsset "deja-vu" "vshulcz/deja-vu" @(
        '^deja-vu_.*_windows_arm64\.zip$'
    )

    # Zellij currently has no native Windows ARM64 release asset.
    Download-ReleaseAsset "zellij" "zellij-org/zellij" @(
        '^zellij-aarch64-pc-windows-msvc\.zip$'
    )
}

Write-Host ""
Write-Host "Summary: OK=$($script:Ok), SKIP=$($script:Skip), FAIL=$($script:Fail)"

if ($script:Fail -gt 0) {
    exit 1
}
