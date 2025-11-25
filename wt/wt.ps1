[CmdletBinding()]
param(
  [switch]$Reload
)

$dstPath = "$env:LOCALAPPDATA/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"
$srcPath = "$PSScriptRoot/base.json"

$actionPath = "$PSScriptRoot/action.json"
$fontPath = "$PSScriptRoot/font.json"
$schemePath = "$PSScriptRoot/scheme.json"
$themePath = "$PSScriptRoot/theme.json"

################################################################### Function{{{
function Get-Base {
  param(
    [string]$Path
  )

  try {
    $srcJson = Get-Content -Path $Path -Raw -ErrorAction Stop
    $base = $srcJson | ConvertFrom-Json
  } catch {
    Write-Error "Failed to read or parse base.json at '$Path'. $_"
    exit 1
  }

  return $base
}

function Set-Action {
  param(
    [Parameter(Mandatory=$true)][psobject]$Base,
    [string]$Path
  )

  if (-not (Test-Path $Path)) {
    Write-Host "No action.json found at '$Path'. Skipping."
    return
  }

  try {
    $actionRoot = Get-Content -Path $Path -Raw -ErrorAction Stop | ConvertFrom-Json
  } catch {
    Write-Warning "Failed to parse action.json at '$Path'. Skipping. $_"
    return
  }

  if (-not $actionRoot.action -or $actionRoot.action.Count -eq 0) {
    Write-Host "No actions defined in '$Path'. Skipping."
    return
  }

  if (-not $Base.actions) {
    $Base | Add-Member -MemberType NoteProperty -Name actions -Value @() -Force
  }

  foreach ($a in $actionRoot.action) {
    $Base.actions += $a
  }
}

function Set-Font {
  param(
    [Parameter(Mandatory=$true)][psobject]$Base,
    [string]$Path
  )

  if (-not (Test-Path $Path)) {
    Write-Host "No font.json found at '$Path'. Skipping."
    return
  }

  try {
    $fontRoot = Get-Content -Path $Path -Raw -ErrorAction Stop | ConvertFrom-Json
  } catch {
    Write-Warning "Failed to parse font.json at '$Path'. Skipping. $_"
    return
  }

  if (-not $fontRoot.font -or $fontRoot.font.Count -eq 0) {
    Write-Host "No fonts found in font.json. Skipping."
    return
  }

  $fontEntry = Get-Random -InputObject $fontRoot.font
  $fontFace  = $fontEntry.face
  $fontSize  = $fontEntry.size

  if ($Base.profiles -and $Base.profiles.defaults) {
    if (-not $Base.profiles.defaults.font) {
      $Base.profiles.defaults |
        Add-Member -MemberType NoteProperty -Name font -Value ([PSCustomObject]@{}) -Force
    }

    $Base.profiles.defaults.font.face = $fontFace
    $Base.profiles.defaults.font.size = $fontSize
  }
}

function Set-Scheme {
  param(
    [Parameter(Mandatory=$true)][psobject]$Base,
    [string]$Path
  )

  if (-not (Test-Path $Path)) {
    Write-Host "No scheme.json found at '$Path'. Skipping."
    return
  }

  try {
    $schemeRoot = Get-Content -Path $Path -Raw -ErrorAction Stop | ConvertFrom-Json
  } catch {
    Write-Warning "Failed to read or parse scheme.json at '$Path'. Skipping. $_"
    return
  }

  if (-not $schemeRoot.scheme -or $schemeRoot.scheme.Count -eq 0) {
    Write-Host "No schemes found in scheme.json. Skipping."
    return
  }

  $scheme = Get-Random -InputObject $schemeRoot.scheme
  $Base | Add-Member -NotePropertyName schemes -NotePropertyValue @($scheme) -Force

  if ($Base.profiles -and $Base.profiles.defaults) {
    $Base.profiles.defaults |
      Add-Member -NotePropertyName colorScheme -NotePropertyValue $scheme.name -Force
  }
}

function Set-Theme {
  param(
    [Parameter(Mandatory=$true)][psobject]$Base,
    [string]$Path
  )

  if (-not (Test-Path $Path)) {
    Write-Host "No theme.json found at '$Path'. Skipping themes."
    return
  }

  try {
    $themeRoot = Get-Content -Path $Path -Raw -ErrorAction Stop | ConvertFrom-Json
  } catch {
    Write-Warning "Failed to read or parse theme.json at '$Path'. Skipping. $_"
    return
  }

  if (-not $themeRoot.theme -or $themeRoot.theme.Count -eq 0) {
    Write-Host "No themes found in theme.json. Skipping."
    return
  }

  $theme = Get-Random -InputObject $themeRoot.theme
  $Base | Add-Member -NotePropertyName themes -NotePropertyValue @($theme) -Force
  $Base | Add-Member -NotePropertyName theme  -NotePropertyValue $theme.name -Force

  if ($theme.tab -and $theme.tab.background) {
    $bgArray = $theme.tab.background

    if ($bgArray -is [System.Array] -and $bgArray.Count -gt 0) {
      $theme.tab.background = Get-Random -InputObject $bgArray
    }
  }
}

function Save-Settings {
  param(
    [Parameter(Mandatory=$true)][psobject]$Base,
    [Parameter(Mandatory=$true)][string]$Path
  )

  try {
    $Base | ConvertTo-Json -Depth 20 | Set-Content -Path $Path -Encoding utf8
  } catch {
    Write-Error "Failed to write updated settings.json to '$Path'. $_"
    exit 1
  }
}
# Function}}}

####################################################################### Main{{{
$base = Get-Base -Path $srcPath

Set-Action -Base $base -Path $actionPath
Set-Font   -Base $base -Path $fontPath
Set-Scheme -Base $base -Path $schemePath
Set-Theme  -Base $base -Path $themePath

Save-Settings -Base $base -Path $dstPath

if (-not $Reload) {
  Start-Process wt.exe
}
# Main}}}
