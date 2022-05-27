#==================================================================== START {{{
if ($IsWindows -and (Get-ExecutionPolicy) -ne 'RemoteSigned') {
  Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Confirm
}

function DEBUG {
  [CmdletBinding()]
  param ([Parameter(ValueFromRemainingArguments=$true)] [String[]] $param)
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

function Add-To-Path ($dir) {
  # $local:pwd = Split-Path -Path (Get-Item $PSCommandPath).Target

  # Get-ChildItem -Path ($local:pwd + '/' + $dir) | ForEach-Object -Process {
  #   $env:PATH += ';' + $_.FullName
  # }

  Get-ChildItem -Path $dir | ForEach-Object -Process {
    $env:PATH += ';' + $_.FullName
  }
}
#}}}

#========================================================= Additional Paths {{{
Add-To-Path ((Split-Path -Path (Get-Item $PSCommandPath).Target) + '/../bin/*/win')
#}}}

#================================================================= posh-git {{{
Invoke-Module 'posh-git'
# $GitPromptSettings.DefaultPromptPrefix.Text = '`n╭─[I] '
# $GitPromptSettings.DefaultPromptBeforeSuffix.Text = '`n╰─'
#}}}

#=============================================================== PSReadLine {{{
Invoke-Module 'PSReadLine'

$script:emoji = @('😀', '😃', '😄', '😁', '😆', '😅', '🤣', '😂', '🙂', '🙃',
  '😉', '😊', '😇', '🥰', '😍', '🤩', '😘', '😗', '😚', '😙', '😋', '😛', '😜',
  '🤪', '😝', '🤑', '🤗', '🤭', '🤫', '🤔', '🤐', '🤨', '😐', '😑', '😶', '😶',
  '😶', '😏', '😒', '🙄', '😬', '😮', '🤥', '😌', '😔', '😪', '🤤', '😴', '😷',
  '🤒', '🤕', '🤢', '🤮', '🤧', '🥵', '🥶', '🥴', '😵', '😵', '🤯', '🤠', '🥳',
  '😎', '🤓', '🧐', '😕', '😟', '🙁', '😮', '😯', '😲', '😳', '🥺', '😦', '😧',
  '😨', '😰', '😥', '😢', '😭', '😱', '😖', '😣', '😞', '😓', '😩', '😫', '🥱',
  '😤', '😡', '😠', '🤬', '😈', '👿', '💀', '💩', '🤡', '👹', '👺', '👻', '👽',
  '👾', '🤖', '😺', '😸', '😹', '😻', '😼', '😽', '🙀', '😿', '😾', '🙈', '🙉',
  '🙊')

$script:index = Get-Random -Maximum $script:emoji.Count
$script:indicator = ''
$script:vimode = $script:emoji[$script:index]
$script:vicolor = [ConsoleColor]::Green

function OnViModeChange {
  $script:index = Get-Random -Maximum $script:emoji.Count

  if ($args[0] -eq 'Command') {
    $script:vicolor = [ConsoleColor]::Red
  } else {
    $script:vicolor = [ConsoleColor]::Green
  }

  $script:vimode = $script:emoji[$script:index]

  [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
  $PSStyle.Reset
}

Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -ExtraPromptLineCount 2
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange

Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Ctrl+Spacebar -Function MenuComplete
Set-PSReadLineKeyHandler -Key Ctrl+z -Function Undo

Set-PSReadLineKeyHandler -Key RightArrow `
                         -BriefDescription ForwardCharAndAcceptNextSuggestionWord `
                         -LongDescription "Move cursor one character to the right in the current editing line and accept the next word in suggestion when it's at the end of current editing line" `
                         -ScriptBlock {
  param($key, $arg)

  $line = $null
  $cursor = $null
  [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

  if ($cursor -lt $line.Length) {
    [Microsoft.PowerShell.PSConsoleReadLine]::ForwardChar($key, $arg)
  } else {
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptNextSuggestionWord($key, $arg)
  }
}
#}}}

#=================================================================== Custom {{{
function Enter-VSDevMode {
  [CmdletBinding()]
  param (
    [Parameter()] [Int] $Arch = 64
  )

  $local:comntools = [System.Environment]::GetEnvironmentVariable(
    $(Get-ChildItem -Name -Path Env: | Select-String -Pattern 'COMNTOOLS'))

  Import-Module $($local:comntools + '/Microsoft.VisualStudio.DevShell.dll')

  Enter-VsDevShell -VsInstanceId 32e62fb6 -DevCmdArguments "-arch=x$Arch -no_logo" -SkipAutomaticLocation

  Write-Host "VSDevMode (x$Arch) entered."
}

function Remove-Submodule {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory = $true)] [String] $Name
  )

  if (-not (Get-Command -Name git)) {
    Write-Error '[Remove-Submodule] Git does not exist, please install it.'
  }

  Move-Item $Name ($Name + '_tmp')
  git submodule deinit -f -- $Name
  Remove-Item -Recurse -Force ('.git/modules/' + $Name)
  git rm --cached $Name
}

function Set-C-Compiler {
  [CmdletBinding()]
  Param (
    [Parameter()] [String] $Compiler = 'clang'
  )

  $local:c = $null
  $local:cxx = $null

  if ($Compiler -eq 'clang') {
    $local:c = 'clang'
    $local:cxx = 'clang++'
  } elseif ($Compiler -eq 'msvc') {
    $local:c = 'cl'
    $local:cxx = 'cl'
    Enter-VSDevMode
  } else {
    Write-Error $("Invalid compiler specified: {0}." -f $Compiler)
    return
  }

  [System.Environment]::SetEnvironmentVariable('CC', $local:c)
  [System.Environment]::SetEnvironmentVariable('CXX', $local:cxx)

  Write-Host 'Compilers specified as:'
  Write-Host 'CC:  ' $local:c
  Write-Host 'CXX: ' $local:cxx
}

function Start-CMake {
  [CmdletBinding()]
  Param (
    [Parameter()] [Int] $Arch = 64,
    [Parameter()] [Bool] $Export = $true,
    [Parameter(ValueFromRemainingArguments=$true)] [String[]] $Remaining
  )

  $local:command = $null
  if ($Export -eq $false) {
    $local:command = 'cmake .. -G Ninja ' + $Remaining
  } else {
    $local:command = 'cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 .. -G Ninja ' + $Remaining
  }

  $local:msg = "Running command ($Arch bit): $local:command"
  $local:line = '-' * 80
  Write-Host $local:line
  Write-Host $local:msg
  Write-Host $local:line

  Invoke-Expression $local:command
  if (($Export -eq $true) -and (Test-Path compile_commands.json)) {
    Copy-Item -Force compile_commands.json -Destination ..
  }
}
#}}}

#=================================================================== Prompt {{{
function Prompt {
  $Prompt = Write-Prompt "`n"
  $Prompt += & $GitPromptScriptBlock
  $Prompt += Write-Prompt "`n $script:vimode" -BackgroundColor $script:vicolor
  $Prompt += Write-Prompt "$script:indicator" -ForegroundColor $script:vicolor
  if ($Prompt) { "$Prompt " } else { " " }
}
#}}}

#==================================================================== z.lua {{{
Invoke-Expression (&{(luajit $PSScriptRoot'/z.lua' --init powershell) -join "`n"})
#}}}
