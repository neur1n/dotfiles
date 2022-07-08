use n_util.nu


#======================================================================= let{{{
let-env Path = (n_util append-path (ls $"($env.NUCONF)/../bin/*/*").name)
# let}}}

#==================================================================== source{{{
source n_prompt.nu
# source}}}

#==================================================================== zoxide{{{
zoxide init nushell --hook prompt | save ~/.zoxide.nu
source ~/.zoxide.nu
# zoxide}}}
