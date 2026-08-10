Set-StrictMode -Version 2.0
$ErrorActionPreference = 'Stop'

function Fail {
    param([string]$Message)
    [Console]::Error.WriteLine($Message)
    exit 1
}

function Test-PathEntry {
    param([string]$Path)
    $leaf = [System.IO.Path]::GetFileName($Path)
    $parent = [System.IO.Path]::GetDirectoryName($Path)
    if (-not (Test-Path -LiteralPath $parent -PathType Container)) {
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

function Require-Env {
    param([string]$Name)
    if ([string]::IsNullOrWhiteSpace([Environment]::GetEnvironmentVariable($Name))) {
        Fail "Required environment variable $Name is not set."
    }
}

$profile = $null
$open = $false
foreach ($arg in $args) {
    if ($arg -ieq '--open' -or $arg -ieq '-open') {
        if ($open) {
            Fail 'Duplicate --open argument.'
        }
        $open = $true
    } elseif ($null -eq $profile) {
        $profile = $arg
    } else {
        Fail "Unexpected argument: $arg"
    }
}

if ($null -eq $profile) {
    Fail 'Usage: deploy.ps1 <neovim|nushell|opencode|wezterm|zellij|komorebi> [--open]'
}

$repoRoot = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot '..\..')).Path

$entries = @()
$openTarget = $null

switch ($profile) {
    'neovim' {
        Require-Env 'LOCALAPPDATA'
        $src = Join-Path $repoRoot 'neovim'
        $dst = Join-Path $env:LOCALAPPDATA 'nvim'
        $entries = @(@{ Src = $src; Dst = $dst; Kind = 'Junction' })
        $openTarget = $dst
    }
    'nushell' {
        Require-Env 'APPDATA'
        $src = Join-Path $repoRoot 'nushell'
        $dst = Join-Path $env:APPDATA 'nushell'
        $entries = @(@{ Src = $src; Dst = $dst; Kind = 'Junction' })
        $openTarget = $dst
    }
    'opencode' {
        Require-Env 'USERPROFILE'
        $src = Join-Path $repoRoot 'opencode'
        $dst = Join-Path $env:USERPROFILE '.config\opencode'
        $entries = @(@{ Src = $src; Dst = $dst; Kind = 'Junction' })
        $openTarget = $dst
    }
    'zellij' {
        Require-Env 'APPDATA'
        $src = Join-Path $repoRoot 'zellij'
        $dst = Join-Path $env:APPDATA 'Zellij\config'
        $entries = @(@{ Src = $src; Dst = $dst; Kind = 'Junction' })
        $openTarget = $dst
    }
    'wezterm' {
        Require-Env 'USERPROFILE'
        $src = Join-Path $repoRoot 'wezterm'
        $entries = @(
            @{ Src = Join-Path $src '.wezterm.lua'; Dst = Join-Path $env:USERPROFILE '.wezterm.lua'; Kind = 'Symlink' },
            @{ Src = Join-Path $src '.wezterm'; Dst = Join-Path $env:USERPROFILE '.wezterm'; Kind = 'Junction' }
        )
        $openTarget = Join-Path $env:USERPROFILE '.wezterm'
    }
    'komorebi' {
        Require-Env 'USERPROFILE'
        $src = Join-Path $repoRoot 'komorebi'
        $entries = @(
            @{ Src = Join-Path $src 'komorebi.json'; Dst = Join-Path $env:USERPROFILE 'komorebi.json'; Kind = 'Symlink' },
            @{ Src = Join-Path $src 'komorebi.app.json'; Dst = Join-Path $env:USERPROFILE 'komorebi.app.json'; Kind = 'Symlink' },
            @{ Src = Join-Path $src 'komorebi.bar.json'; Dst = Join-Path $env:USERPROFILE 'komorebi.bar.json'; Kind = 'Symlink' },
            @{ Src = Join-Path $src 'whkdrc'; Dst = Join-Path $env:USERPROFILE '.config\whkdrc'; Kind = 'Symlink' }
        )
        $openTarget = $env:USERPROFILE
    }
    default {
        Fail "Unknown profile: $profile"
    }
}

foreach ($e in $entries) {
    if ($e.Kind -eq 'Junction') {
        if (-not (Test-Path -LiteralPath $e.Src -PathType Container)) {
            Fail "Source directory does not exist: $($e.Src)"
        }
    } else {
        if (-not (Test-Path -LiteralPath $e.Src -PathType Leaf)) {
            Fail "Source file does not exist: $($e.Src)"
        }
    }
    $parent = Split-Path -Parent $e.Dst
    if (-not (Test-Path -LiteralPath $parent -PathType Container)) {
        Fail "Destination parent does not exist: $parent"
    }
    if (Test-PathEntry $e.Dst) {
        Fail "Destination already exists: $($e.Dst)"
    }
}

foreach ($e in $entries) {
    if ($e.Kind -eq 'Junction') {
        try {
            New-Item -ItemType Junction -Path $e.Dst -Target $e.Src | Out-Null
        } catch {
            Fail "Failed to create junction ""$($e.Dst)"": $($_.Exception.Message)"
        }
    } else {
        try {
            New-Item -ItemType SymbolicLink -Path $e.Dst -Target $e.Src | Out-Null
        } catch {
            Fail "Failed to create symbolic link ""$($e.Dst)"". File symbolic links require Developer Mode or an elevated shell: $($_.Exception.Message)"
        }
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
