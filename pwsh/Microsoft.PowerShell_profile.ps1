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
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange

#=================================================================== Custom {{{
function Start-CMake {
  [CmdletBinding()]
  Param (
    [Parameter()] [Int] $BuildArchitecture = 0,
    [Parameter()] [Bool] $ExportCompileCommands = $true,
    [Parameter(ValueFromRemainingArguments=$true)] [String[]] $Remaining
  )

  $local:cmdlet = $null
  if ($BuildArchitecture -eq 32) {
    $local:cmdlet = "vcvars32.bat & set"
  } elseif ($BuildArchitecture -eq 64) {
    $local:cmdlet = "vcvars64.bat & set"
  } elseif ($null -ne $local:cmdlet) {
    Write-Host "[Start-CMake] Please specify build architecture as 32 or 64."
    return
  }

  $local:command = $null
  if ($ExportCompileCommands -eq $false) {
    $local:command = "cmake .. -G Ninja " + $Remaining
  } else {
    $local:command = "cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 .. -G Ninja " + $Remaining
  }

  $local:msg = "Running command ($BuildArchitecture-bit): $local:command"
  $local:line = "-" * 80
  Write-Host $local:line
  Write-Host $local:msg
  Write-Host $local:line

  if ($null -ne $local:cmdlet) {
    # $path = [System.Environment]::GetEnvironmentVariable('PATH', 'User')
    # $path = ($path.Split(';') | Where-Object { $_ -NotMatch ".*MinGW.*" }) -join ';'
    # [System.Environment]::SetEnvironmentVariable('PATH', $path, 'User')

    cmd /c $local:cmdlet |
    Select-String '^([^=]*)=(.*)$' | ForEach-Object {
      $local:key = $_.Matches[0].Groups[1].Value
      $local:value = $_.Matches[0].Groups[2].Value
      Set-Item Env:$local:key $local:value
    }
  }

  Invoke-Expression $local:command
  if (($ExportCompileCommands -eq $true) -and (Test-Path compile_commands.json)) {
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
