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
function New-CMake-Config ($opt) {
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
