#==================================================================== START {{{
if ((Get-ExecutionPolicy) -ne 'RemoteSigned') {
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
#}}}

#=============================================================== PSReadLine {{{
Load-Module 'PSReadLine'
Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -ViModeIndicator Prompt

# function Bind-Key ($binding, $keys) {
#   Set-PSReadLineKeyHandler -Chord $binding -ViMode Command -ScriptBlock {
#     Add-Type -AssemblyName System.Windows.Forms
#     # [System.Windows.Forms.SendKeys]::SendWait($keys)
#     Write-Host "[System.Windows.Forms.SendKeys]::SendWait($keys)"
#   }
# }

# Bind-Key 'Ctrl+b,s' '%+{-}'
# Bind-Key 'Ctrl+w,v' '%+{=}'
# Bind-Key 'Ctrl+w,h' '%{LEFT}'
# Bind-Key 'Ctrl+w,j' '%{DOWN}'
# Bind-Key 'Ctrl+w,k' '%{UP}'
# Bind-Key 'Ctrl+w,l' '%{RIGHT}'

Set-PSReadLineKeyHandler -Chord 'Ctrl+w,s' -ViMode Command -ScriptBlock {
  Add-Type -AssemblyName System.Windows.Forms
  [System.Windows.Forms.SendKeys]::SendWait('%+{-}')
}

Set-PSReadLineKeyHandler -Chord 'Ctrl+w,v' -ViMode Command -ScriptBlock {
  Add-Type -AssemblyName System.Windows.Forms
  [System.Windows.Forms.SendKeys]::SendWait('%+{=}')
}

Set-PSReadLineKeyHandler -Chord 'Ctrl+w,h' -ViMode Command -ScriptBlock {
  Add-Type -AssemblyName System.Windows.Forms
  [System.Windows.Forms.SendKeys]::SendWait('%{LEFT}')
}

Set-PSReadLineKeyHandler -Chord 'Ctrl+w,j' -ViMode Command -ScriptBlock {
  Add-Type -AssemblyName System.Windows.Forms
  [System.Windows.Forms.SendKeys]::SendWait('%{DOWN}')
}

Set-PSReadLineKeyHandler -Chord 'Ctrl+w,k' -ViMode Command -ScriptBlock {
  Add-Type -AssemblyName System.Windows.Forms
  [System.Windows.Forms.SendKeys]::SendWait('%{UP}')
}

Set-PSReadLineKeyHandler -Chord 'Ctrl+w,l' -ViMode Command -ScriptBlock {
  Add-Type -AssemblyName System.Windows.Forms
  [System.Windows.Forms.SendKeys]::SendWait('%{RIGHT}')
}
#}}}

# Prompt ==================================================================={{{
#}}}
