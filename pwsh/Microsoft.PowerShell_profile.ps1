#==================================================================== START {{{
if ($IsWindows -and (Get-ExecutionPolicy) -ne 'RemoteSigned') {
  Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Confirm
}

function DEBUG {
  [CmdletBinding()]
  param ([Parameter(Mandatory=$false)] $param)
  Write-Host '[DEBUG]' $param
}

function Load-Module ($name) {
  if (Get-Module -ListAvailable -Name $name) {
    Import-Module $name
  } else {
    Write-Host 'Installing missinged module ' $name '...'
    Install-Module $name -Scope CurrentUser -AllowPrerelease -Force
  }
}
#}}}

#================================================================= posh-git {{{
Load-Module 'posh-git'
# $GitPromptSettings.DefaultPromptPrefix.Text = '`n╭─[I] '
# $GitPromptSettings.DefaultPromptBeforeSuffix.Text = '`n╰─'
#}}}

#=============================================================== PSReadLine {{{
Load-Module 'PSReadLine'

$script:ViMode = '[I] '
$script:ViColor = [ConsoleColor]::Green

function OnViModeChange {
  if ($args[0] -eq 'Command') {
    $script:ViMode = '[N] '
    $script:ViColor = [ConsoleColor]::Red
  } else {
    $script:ViMode = '[I] '
    $script:ViColor = [ConsoleColor]::Green
  }
  [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
}

Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -ExtraPromptLineCount 2
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange

# Prompt ==================================================================={{{
function Prompt {
  $Prompt = Write-Prompt "`n┌$script:ViMode" -ForegroundColor $script:ViColor
  $Prompt += & $GitPromptScriptBlock
  $Prompt += Write-Prompt "`n└>" -ForegroundColor $script:ViColor
  if ($Prompt) { "$Prompt " } else { " " }
}
#}}}
