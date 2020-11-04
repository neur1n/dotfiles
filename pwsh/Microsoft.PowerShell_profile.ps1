#==================================================================== START {{{
if ($IsWindows -and (Get-ExecutionPolicy) -ne 'RemoteSigned') {
  Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Confirm
}

function DEBUG {
  [CmdletBinding()]
  param ([Parameter(Mandatory=$false)] $param)
  Write-Host '[DEBUG]' $param
}

function Invoke-Module ($name) {
  if (Get-Module -ListAvailable -Name $name) {
    Import-Module $name
  } else {
    Write-Host 'Installing missinged module ' $name '...'
    Install-Module $name -Scope CurrentUser -AllowPrerelease -Force
  }
}
#}}}

#================================================================= posh-git {{{
Invoke-Module 'posh-git'
# $GitPromptSettings.DefaultPromptPrefix.Text = '`n╭─[I] '
# $GitPromptSettings.DefaultPromptBeforeSuffix.Text = '`n╰─'
#}}}

#=============================================================== PSReadLine {{{
Invoke-Module 'PSReadLine'

$script:vimode = '[I] '
$script:vicolor = [ConsoleColor]::Green

function OnViModeChange {
  if ($args[0] -eq 'Command') {
    $script:vimode = '[N] '
    $script:vicolor = [ConsoleColor]::Red
  } else {
    $script:vimode = '[I] '
    $script:vicolor = [ConsoleColor]::Green
  }
  [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
}

Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -ExtraPromptLineCount 2
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange

# Custom ==================================================================={{{
function Set-MSVC-Envs($export = 1, $arch = $null) {
  if ($export -ne 0) {
    $export = 1
  }

  $cmdlet = $null
  if ($arch -eq 32) {
    $cmdlet = "vcvars32.bat & set"
  } elseif ($arch -eq 64) {
    $cmdlet = "vcvars64.bat & set"
  } elseif ($null -ne $arch) {
    Write-Host "[Set-Build-Envs] Please provide arch as 32 or 64."
    return
  }

  Write-Host "--------------------------------------------------"
  Write-Host "Configuring for arch:"$arch
  Write-Host "Exporting compile commands:"$export
  Write-Host "--------------------------------------------------"

  if ($null -ne $cmdlet) {
    # $path = [System.Environment]::GetEnvironmentVariable('PATH', 'User')
    # $path = ($path.Split(';') | Where-Object { $_ -NotMatch ".*MinGW.*" }) -join ';'
    # [System.Environment]::SetEnvironmentVariable('PATH', $path, 'User')

    cmd /c $cmdlet |
    Select-String '^([^=]*)=(.*)$' | ForEach-Object {
      $key = $_.Matches[0].Groups[1].Value
      $value = $_.Matches[0].Groups[2].Value
      Set-Item Env:$key $value
    }
  }

  if ($export -eq 0) {
    cmake .. -G Ninja
  } else {
    cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 .. -G Ninja
    if (Test-Path compile_commands.json) {
      Copy-Item -Force compile_commands.json -Destination ..
    }
  }
}

function New-CMake-Config() {
  $content =
@'
@echo off

if "%1" == "" (set export=1)
if "%1" == "0" (set export=0) else (set export=1)

if "%2" == "" (
  set arch=NULL
) else (
  if "%2" == "32" (set arch=32) else (set arch=64)
)

echo -----------------------------
echo Configuring for: %arch%
echo Exporting compile commands: %export%
echo -----------------------------

if %arch% == 32 (call vcvars32.bat)
if %arch% == 64 (call vcvars64.bat)

set CC=cl
set CXX=cl

if %export% == 0 (cmake .. -G Ninja)
if %export% == 1 (
  cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 .. -G Ninja
  xcopy /y compile_commands.json ..\compile_commands.json
)
'@

  if (-Not (Test-Path config.bat)) {
    New-Item config.bat
  }
  Set-Content config.bat $content
}
#}}}

# Prompt ==================================================================={{{
function Prompt {
  $Prompt = Write-Prompt "`n┌$script:vimode" -ForegroundColor $script:vicolor
  $Prompt += & $GitPromptScriptBlock
  $Prompt += Write-Prompt "`n└>" -ForegroundColor $script:vicolor
  if ($Prompt) { "$Prompt " } else { " " }
}
#}}}
