scriptencoding utf-8

lua << EOF
vim.filetype.add({
  extension = {
    cmd = "dosbatch",
  },
})
EOF
