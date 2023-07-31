scriptencoding utf-8

lua << EOF
require("flash").setup({
  search = {multi_window = false},
  modes = {
    search = {enabled = false},
    char = {jump_labels = true},
  },
})
EOF
