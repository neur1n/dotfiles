Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'

function Fail {
  param([string]$Message)
  [Console]::Error.WriteLine($Message)
  exit 1
}

function Show-Usage {
  [Console]::Error.WriteLine('Usage: deploy.ps1 <claude|codex|komorebi|neovim|nushell|opencode|wezterm|zellij> [--dry-run] [--open]')
}

function Require-Env {
  param([string]$Name)
  if ([string]::IsNullOrWhiteSpace([Environment]::GetEnvironmentVariable($Name))) {
    Fail "Required environment variable $Name is not set."
  }
}

function Test-PathEntry {
  param([string]$Path)
  if (Test-Path -LiteralPath $Path) {
    return $true
  }

  $leaf = [System.IO.Path]::GetFileName($Path)
  $parent = [System.IO.Path]::GetDirectoryName($Path)

  if ([string]::IsNullOrEmpty($parent) -or -not (Test-Path -LiteralPath $parent -PathType Container)) {
    return $false
  }

  try {
    foreach ($entry in [System.IO.Directory]::GetFileSystemEntries($parent)) {
      if ([System.IO.Path]::GetFileName($entry) -ieq $leaf) {
        return $true
      }
    }
  } catch {
    Fail "Cannot enumerate destination parent: $parent"
  }

  return $false
}

function Add-Entry {
  param(
    [string]$Source,
    [ValidateSet('File', 'Directory')][string]$SourceKind,
    [string]$Destination,
    [ValidateSet('SymbolicLink', 'Junction')][string]$LinkKind,
    [ValidateSet('Create', 'Existing')][string]$ParentPolicy
  )

  [void]$entries.Add([PSCustomObject]@{
    Source = $Source
    SourceKind = $SourceKind
    Destination = $Destination
    LinkKind = $LinkKind
    ParentPolicy = $ParentPolicy
    Status = $null
  })
}

function Add-PlannedParent {
  param([string]$Path)

  foreach ($existing in $plannedParents) {
    if ($existing -ieq $Path) {
      return
    }
  }

  [void]$plannedParents.Add($Path)
}

function Get-MissingDirectories {
  param([string]$Path)

  $missing = New-Object System.Collections.ArrayList
  $current = $Path

  while (-not (Test-PathEntry $current)) {
    [void]$missing.Add($current)
    $next = [System.IO.Path]::GetDirectoryName($current)

    if ([string]::IsNullOrEmpty($next) -or $next -eq $current) {
      Fail "Destination parent cannot be created: $Path"
    }

    $current = $next
  }

  if (-not (Test-Path -LiteralPath $current -PathType Container)) {
    Fail "Destination parent cannot be created: $Path"
  }

  return ,$missing
}

function Get-NormalizedPath {
  param([string]$Path, [string]$BasePath)

  if (-not [System.IO.Path]::IsPathRooted($Path)) {
    $Path = Join-Path $BasePath $Path
  }

  return [System.IO.Path]::GetFullPath($Path).TrimEnd('\', '/')
}

function Test-ExpectedLink {
  param($Entry)

  if (-not (Test-Path -LiteralPath $Entry.Destination)) {
    return $false
  }

  try {
    $item = Get-Item -LiteralPath $Entry.Destination -Force
  } catch {
    return $false
  }

  if ($item.PSObject.Properties.Name -notcontains 'LinkType' -or $item.LinkType -ne $Entry.LinkKind) {
    return $false
  }

  $target = @($item.Target)[0]

  if ([string]::IsNullOrEmpty($target)) {
    return $false
  }

  $parent = [System.IO.Path]::GetDirectoryName($Entry.Destination)
  $actualPath = Get-NormalizedPath $target $parent
  $expectedPath = Get-NormalizedPath $Entry.Source $parent

  return $actualPath -ieq $expectedPath
}

function Undo-CreatedItems {
  for ($index = $createdLinks.Count - 1; $index -ge 0; $index--) {
    $entry = $createdLinks[$index]

    if (Test-ExpectedLink $entry) {
      try {
        Remove-Item -LiteralPath $entry.Destination -Force
      } catch {
        [Console]::Error.WriteLine("Failed to roll back link: $($entry.Destination)")
      }
    }
  }

  for ($index = $createdParents.Count - 1; $index -ge 0; $index--) {
    $path = $createdParents[$index]
    try {
      if (@(Get-ChildItem -LiteralPath $path -Force).Count -eq 0) {
        Remove-Item -LiteralPath $path -Force
      }
    } catch {
      # Leave non-empty or concurrently modified directories intact.
    }
  }
}

$profile = $null
$open = $false
$dryRun = $false

foreach ($arg in $args) {
  if ($arg -ieq '--open' -or $arg -ieq '-open') {
    if ($open) {
      Fail 'Duplicate --open argument.'
    }
    $open = $true
  } elseif ($arg -ieq '--dry-run') {
    if ($dryRun) {
      Fail 'Duplicate --dry-run argument.'
    }
    $dryRun = $true
  } elseif ($arg -ieq '--help' -or $arg -ieq '-h') {
    Show-Usage
    exit 0
  } elseif ($arg.StartsWith('-')) {
    Fail "Unknown option: $arg"
  } elseif ($null -eq $profile) {
    $profile = $arg
  } else {
    Fail "Unexpected argument: $arg"
  }
}

if ($null -eq $profile) {
  Show-Usage
  exit 1
}

$repoRoot = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..')).Path
$entries = New-Object System.Collections.ArrayList
$plannedParents = New-Object System.Collections.ArrayList
$createdLinks = New-Object System.Collections.ArrayList
$createdParents = New-Object System.Collections.ArrayList
$openTarget = $null

switch ($profile) {
  'claude' {
    Require-Env 'USERPROFILE'
    $src = Join-Path $repoRoot 'opencode\AGENTS.md'
    $claudeDir = Join-Path $env:USERPROFILE '.claude'
    $tclaudeDir = Join-Path $env:USERPROFILE '.tclaude'
    foreach ($parent in $claudeDir, $tclaudeDir) {
      if (Test-Path -LiteralPath $parent -PathType Container) {
        Add-Entry $src File (Join-Path $parent 'CLAUDE.md') SymbolicLink Existing
      } elseif (Test-PathEntry $parent) {
        Fail "Claude configuration path is not a directory: $parent"
      }
    }
    if ($entries.Count -eq 0) {
      Fail "No Claude configuration directory exists: $claudeDir or $tclaudeDir"
    }
    $openTarget = $entries[0].Destination
  }
  'codex' {
    Require-Env 'USERPROFILE'
    $src = Join-Path $repoRoot 'opencode\AGENTS.md'
    $codexDir = Join-Path $env:USERPROFILE '.codex'
    $tcodexDir = Join-Path $env:USERPROFILE '.tcodex'
    foreach ($parent in $codexDir, $tcodexDir) {
      if (Test-Path -LiteralPath $parent -PathType Container) {
        Add-Entry $src File (Join-Path $parent 'AGENTS.md') SymbolicLink Existing
      } elseif (Test-PathEntry $parent) {
        Fail "Codex configuration path is not a directory: $parent"
      }
    }
    if ($entries.Count -eq 0) {
      Fail "No Codex configuration directory exists: $codexDir or $tcodexDir"
    }
    $openTarget = $entries[0].Destination
  }
  'komorebi' {
    Require-Env 'USERPROFILE'
    $src = Join-Path $repoRoot 'komorebi'
    Add-Entry (Join-Path $src 'komorebi.json') File (Join-Path $env:USERPROFILE 'komorebi.json') SymbolicLink Create
    Add-Entry (Join-Path $src 'komorebi.app.json') File (Join-Path $env:USERPROFILE 'komorebi.app.json') SymbolicLink Create
    Add-Entry (Join-Path $src 'komorebi.bar.json') File (Join-Path $env:USERPROFILE 'komorebi.bar.json') SymbolicLink Create
    Add-Entry (Join-Path $src 'whkdrc') File (Join-Path $env:USERPROFILE '.config\whkdrc') SymbolicLink Create
    $openTarget = $env:USERPROFILE
  }
  'neovim' {
    Require-Env 'LOCALAPPDATA'
    $dst = Join-Path $env:LOCALAPPDATA 'nvim'
    Add-Entry (Join-Path $repoRoot 'neovim') Directory $dst Junction Create
    $openTarget = $dst
  }
  'nushell' {
    Require-Env 'APPDATA'
    $dst = Join-Path $env:APPDATA 'nushell'
    Add-Entry (Join-Path $repoRoot 'nushell') Directory $dst Junction Create
    $openTarget = $dst
  }
  'opencode' {
    Require-Env 'USERPROFILE'
    $dst = Join-Path $env:USERPROFILE '.config\opencode'
    Add-Entry (Join-Path $repoRoot 'opencode') Directory $dst Junction Create
    $openTarget = $dst
  }
  'wezterm' {
    Require-Env 'USERPROFILE'
    $src = Join-Path $repoRoot 'wezterm'
    Add-Entry (Join-Path $src '.wezterm.lua') File (Join-Path $env:USERPROFILE '.wezterm.lua') SymbolicLink Create
    Add-Entry (Join-Path $src '.wezterm') Directory (Join-Path $env:USERPROFILE '.wezterm') Junction Create
    $openTarget = Join-Path $env:USERPROFILE '.wezterm'
  }
  'zellij' {
    Require-Env 'APPDATA'
    $dst = Join-Path $env:APPDATA 'Zellij\config'
    Add-Entry (Join-Path $repoRoot 'zellij') Directory $dst Junction Create
    $openTarget = $dst
  }
  default {
    Fail "Unknown profile: $profile"
  }
}

foreach ($entry in $entries) {
  if ($entry.SourceKind -eq 'Directory') {
    if (-not (Test-Path -LiteralPath $entry.Source -PathType Container)) {
      Fail "Source directory does not exist: $($entry.Source)"
    }
  } elseif (-not (Test-Path -LiteralPath $entry.Source -PathType Leaf)) {
    Fail "Source file does not exist: $($entry.Source)"
  }

  $parent = [System.IO.Path]::GetDirectoryName($entry.Destination)

  if ($entry.ParentPolicy -eq 'Existing') {
    if (-not (Test-Path -LiteralPath $parent -PathType Container)) {
      Fail "Destination parent does not exist: $parent"
    }
  } else {
    $missing = Get-MissingDirectories $parent
    for ($index = $missing.Count - 1; $index -ge 0; $index--) {
      Add-PlannedParent $missing[$index]
    }
  }

  if (Test-PathEntry $entry.Destination) {
    if (Test-ExpectedLink $entry) {
      $entry.Status = 'Existing'
    } else {
      Fail "Destination conflict: $($entry.Destination)"
    }
  } else {
    $entry.Status = 'Create'
  }
}

if ($dryRun) {
  foreach ($parent in $plannedParents) {
    Write-Output "Would create directory: $parent"
  }

  foreach ($entry in $entries) {
    if ($entry.Status -eq 'Existing') {
      Write-Output "Already deployed: $($entry.Destination)"
    } else {
      Write-Output "Would link: $($entry.Destination) -> $($entry.Source)"
    }
  }
  if ($open) {
      Write-Output "Would open: $openTarget"
  }

  exit 0
}

foreach ($parent in $plannedParents) {
  if (Test-Path -LiteralPath $parent -PathType Container) {
    continue
  }

  if (Test-PathEntry $parent) {
    Undo-CreatedItems
    Fail "Destination parent became unavailable: $parent"
  }

  try {
    New-Item -ItemType Directory -Path $parent | Out-Null
    [void]$createdParents.Add($parent)
    Write-Output "Created directory: $parent"
  } catch {
    Undo-CreatedItems
    Fail "Failed to create destination parent ${parent}: $($_.Exception.Message)"
  }
}

foreach ($entry in $entries) {
  if ($entry.Status -eq 'Existing') {
    if (Test-ExpectedLink $entry) {
      Write-Output "Already deployed: $($entry.Destination)"
      continue
    } elseif (Test-PathEntry $entry.Destination) {
      Undo-CreatedItems
      Fail "Destination became unavailable: $($entry.Destination)"
    }
  }

  if (Test-PathEntry $entry.Destination) {
    Undo-CreatedItems
    Fail "Destination became unavailable: $($entry.Destination)"
  }

  try {
    New-Item -ItemType $entry.LinkKind -Path $entry.Destination -Target $entry.Source | Out-Null
    [void]$createdLinks.Add($entry)
    Write-Output "Created link: $($entry.Destination) -> $($entry.Source)"
  } catch {
    Undo-CreatedItems
    if ($entry.LinkKind -eq 'SymbolicLink') {
      Fail "Failed to create symbolic link. File symbolic links require Developer Mode or an elevated shell: $($_.Exception.Message)"
    }
    Fail "Failed to create junction: $($_.Exception.Message)"
  }
}

if ($open) {
  $remote = $false

  foreach ($name in 'SSH_CONNECTION', 'SSH_CLIENT', 'SSH_TTY', 'MOSH_IP') {
    if (-not [string]::IsNullOrEmpty([Environment]::GetEnvironmentVariable($name))) {
      $remote = $true
    }
  }

  if ($remote) {
    [Console]::Error.WriteLine('Skipping open: remote session.')
  } else {
    $sessionId = (Get-Process -Id $PID).SessionId
    $hasExplorer = $null -ne (Get-Process explorer -ErrorAction SilentlyContinue |
        Where-Object { $_.SessionId -eq $sessionId } | Select-Object -First 1)

    if ($sessionId -eq 0 -or -not $hasExplorer) {
      [Console]::Error.WriteLine('Skipping open: no GUI session.')
    } else {
      try {
        Invoke-Item -LiteralPath $openTarget
      } catch {
        [Console]::Error.WriteLine("Failed to open $openTarget : $($_.Exception.Message)")
      }
    }
  }
}
