Import-Module posh-git

Import-Module PSReadLine  #================================================={{{
Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -HistorySearchCursorMovesToEnd

Set-PSReadLineKeyHandler -Chord 'Ctrl+w,s' -ViMode Command -ScriptBlock {
  Add-Type -AssemblyName System.Windows.Forms
  [System.Windows.Forms.SendKeys]::SendWait('%+{-}')
}

Set-PSReadLineKeyHandler -Chord 'Ctrl+w,v' -ViMode Command -ScriptBlock {
  Add-Type -AssemblyName System.Windows.Forms
  [System.Windows.Forms.SendKeys]::SendWait('%+{=}')
}
#}}}
