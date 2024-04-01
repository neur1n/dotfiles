local M = {}

local plt = require("palette").get()

local basic = {
  NeuBgH = {bg = plt.bgh.g, bold = false, italic = false, ctermbg = plt.bgh.c, cterm = {}},
  NeuBgM = {bg = plt.bgm.g, bold = false, italic = false, ctermbg = plt.bgm.c, cterm = {}},
  NeuBgS = {bg = plt.bgs.g, bold = false, italic = false, ctermbg = plt.bgs.c, cterm = {}},

  NeuFgH = {fg = plt.fgh.g, bold = false, italic = false, ctermfg = plt.fgh.c, cterm = {}},
  NeuFgM = {fg = plt.fgm.g, bold = false, italic = false, ctermfg = plt.fgm.c, cterm = {}},
  NeuFgS = {fg = plt.fgs.g, bold = false, italic = false, ctermfg = plt.fgs.c, cterm = {}},

  NeuGrayH = {fg = plt.grayh.g, bold = false, italic = false, ctermfg = plt.grayh.c, cterm = {}},
  NeuGrayM = {fg = plt.graym.g, bold = false, italic = false, ctermfg = plt.graym.c, cterm = {}},
  NeuGrayS = {fg = plt.grays.g, bold = false, italic = false, ctermfg = plt.grays.c, cterm = {}},

  NeuError = {fg = plt.red.g, bold = false, italic = false, ctermfg = plt.red.c, cterm = {}},
  NeuWarning = {fg = plt.orange.g, bold = false, italic = false, ctermfg = plt.orange.c, cterm = {}},
  NeuInfo = {fg = plt.blue.g, bold = false, italic = false, ctermfg = plt.blue.c, cterm = {}},
  NeuHint = {fg = plt.green.g, bold = false, italic = false, ctermfg = plt.green.c, cterm = {}},
}

local rainbow = {
  {NeuRed = {fg = plt.red.g, bold = false, italic = false, ctermfg = plt.red.c, cterm = {}}},
  {NeuOrange = {fg = plt.orange.g, bold = false, italic = false, ctermfg = plt.orange.c, cterm = {}}},
  {NeuYellow = {fg = plt.yellow.g, bold = false, italic = false, ctermfg = plt.yellow.c, cterm = {}}},
  {NeuGreen = {fg = plt.green.g, bold = false, italic = false, ctermfg = plt.green.c, cterm = {}}},
  {NeuCyan = {fg = plt.cyan.g, bold = false, italic = false, ctermfg = plt.cyan.c, cterm = {}}},
  {NeuBlue = {fg = plt.blue.g, bold = false, italic = false, ctermfg = plt.blue.c, cterm = {}}},
  {NeuPurple = {fg = plt.purple.g, bold = false, italic = false, ctermfg = plt.purple.c, cterm = {}}},
  {NeuSpecial = {fg = plt.special.g, bold = false, italic = false, ctermfg = plt.special.c, cterm = {}}},
}

local function rainbow_group()
  math.randomseed(os.time())
  for group, _ in pairs(rainbow[math.random(#rainbow)]) do
    return group
  end
end

local function rainbow_option()
  math.randomseed(os.time())
  for _, option in pairs(rainbow[math.random(#rainbow)]) do
    return option
  end
end

local function shuffled_rainbow()
  local groups = {
    "NeuRed",
    "NeuOrange",
    "NeuYellow",
    "NeuGreen",
    "NeuCyan",
    "NeuBlue",
    "NeuPurple"
  }

  math.randomseed(os.time())
  for i = #groups, 2, -1 do
    local j = math.random(i)
    groups[i], groups[j] = groups[j], groups[i]
  end

  return groups
end

local function hl_native()
  local option = {}

  vim.api.nvim_set_hl(0, "Comment", {fg = plt.grays.g, italic = true, ctermfg = plt.grays.c, cterm = {italic = true}})
  vim.api.nvim_set_hl(0, "Normal", {fg = plt.fgm.g, bg = plt.bgm.g, ctermfg = plt.fgm.c, ctermbg = plt.bgm.c})
  vim.api.nvim_set_hl(0, "NormalNC", {fg = plt.fgm.g, bg = plt.bgs.g, ctermfg = plt.fgm.c, ctermbg = plt.bgs.c})

  -- Order mostly following `:h highlight-groups`.
  vim.api.nvim_set_hl(0, "ColorColumn", {bg = plt.bgs.g, ctermbg = plt.bgs.c})
  vim.api.nvim_set_hl(0, "Cursor", {reverse = true, cterm = {reverse = true}})
  vim.api.nvim_set_hl(0, "lCursor", {link = "Cursor"})
  vim.api.nvim_set_hl(0, "CursorIM", {link = "Cursor"})
  vim.api.nvim_set_hl(0, "CursorColumn", {link = "ColorColumn"})
  vim.api.nvim_set_hl(0, "CursorLine", {link = "ColorColumn"})
  vim.api.nvim_set_hl(0, "Directory", {link = "NeuBlueBold"})
  vim.api.nvim_set_hl(0, "DiffAdd", {fg = plt.bgm.g, bg = plt.green.g, ctermfg = plt.bgm.c, ctermbg = plt.green.c})
  vim.api.nvim_set_hl(0, "DiffChange", {fg = plt.bgm.g, bg = plt.orange.g, ctermfg = plt.bgm.c, ctermbg = plt.orange.c})
  vim.api.nvim_set_hl(0, "DiffDelete", {fg = plt.bgm.g, bg = plt.red.c, ctermfg = plt.bgm.c, ctermbg = plt.red.c})
  vim.api.nvim_set_hl(0, "DiffText", {fg = plt.bgm.g, bg = plt.yellow.c, ctermfg = plt.bgm.c, ctermbg = plt.yellow.c})
  vim.api.nvim_set_hl(0, "EndOfBuffer", {link = "NeuGrayM"})
  vim.api.nvim_set_hl(0, "TermCursor", {link = "NeuSpecialBold"})
  vim.api.nvim_set_hl(0, "TermCursorNC", {link = "NeuSpecial"})
  vim.api.nvim_set_hl(0, "ErrorMsg", {fg = plt.bgm.g, bg = plt.red.g, bold = true, ctermfg = plt.bgm.c, ctermbg = plt.red.c, cterm = {bold = true}})
  vim.api.nvim_set_hl(0, "Folded", {link = "Comment"})
  vim.api.nvim_set_hl(0, "FoldColumn", {link = "Comment"})
  vim.api.nvim_set_hl(0, "SignColumn", {bg = plt.bgm.g, ctermbg = plt.bgm.c})
  vim.api.nvim_set_hl(0, "IncSearch", {fg = plt.bgh.g, bg = plt.special.g, bold = true, ctermfg = plt.bgh.c, ctermbg = plt.special.c, cterm = {bold = true}})
  vim.api.nvim_set_hl(0, "Substitute", {link = "IncSearch"})
  vim.api.nvim_set_hl(0, "LineNr", {link = "NeuGrayM"})
  vim.api.nvim_set_hl(0, "CursorLineNr", {link = rainbow_group()})
  vim.api.nvim_set_hl(0, "LineNrAbove", {link = "LineNr"})
  vim.api.nvim_set_hl(0, "LineNrBelow", {link = "LineNr"})
  vim.api.nvim_set_hl(0, "CursorLineFold", {link = "FoldColumn"})
  vim.api.nvim_set_hl(0, "CursorLineSign", {link = "SignColumn"})
  vim.api.nvim_set_hl(0, "MatchParen", {bg = plt.grays.g, underline = true, ctermbg = plt.grays.c, cterm = {underline = true}})
  vim.api.nvim_set_hl(0, "ModeMsg", {link = "Normal"})
  vim.api.nvim_set_hl(0, "MsgArea", {link = "Normal"})
  vim.api.nvim_set_hl(0, "MsgSeparator", {link = "Normal"})
  vim.api.nvim_set_hl(0, "MoreMsg", {link = rainbow_group()})
  vim.api.nvim_set_hl(0, "NonText", {link = "Comment"})
  vim.api.nvim_set_hl(0, "NormalFloat", {link = "Comment"})
  vim.api.nvim_set_hl(0, "FloatBorder", {link = rainbow_group()})
  vim.api.nvim_set_hl(0, "FloatTitle", {link = "FloatBorder"})
  option = rainbow_option()
  vim.api.nvim_set_hl(0, "Pmenu", {})
  vim.api.nvim_set_hl(0, "PmenuSel", {fg = plt.bgm.g, bg = option.fg, bold = true, ctermfg = plt.bgm.c, ctermbg = option.ctermfg, cterm = {bold = true}})
  vim.api.nvim_set_hl(0, "PmenuKind", {link = "Pmenu"})
  vim.api.nvim_set_hl(0, "PmenuKindSel", {link = "PmenuSel"})
  vim.api.nvim_set_hl(0, "PmenuExtra", {link = "Pmenu"})
  vim.api.nvim_set_hl(0, "PmenuExtraSel", {link = "PmenuSel"})
  vim.api.nvim_set_hl(0, "PmenuBar", {bg = plt.bgm.g, ctermbg = plt.bgm.c})
  option = rainbow_option()
  vim.api.nvim_set_hl(0, "PmenuThumb", {bg = option.fg, ctermbg = option.ctermfg})
  option = rainbow_option()
  vim.api.nvim_set_hl(0, "Question", {fg = option.fg, bg = plt.bgm.g, ctermfg = option.ctermfg, ctermbg = plt.bgm.c})
  vim.api.nvim_set_hl(0, "QuickFixLine", {link = "CursorLine"})
  vim.api.nvim_set_hl(0, "Search", {link = "IncSearch"})
  vim.api.nvim_set_hl(0, "SpecialKey", {link = "Comment"})
  vim.api.nvim_set_hl(0, "SpellBad", {fg = plt.red.g, undercurl = true, ctermfg = plt.red.c, cterm = {undercurl = true}})
  vim.api.nvim_set_hl(0, "SpellCap", {fg = plt.orange.g, undercurl = true, ctermfg = plt.orange.c, cterm = {undercurl = true}})
  vim.api.nvim_set_hl(0, "SpellLocal", {fg = plt.blue.g, undercurl = true, ctermfg = plt.blue.c, cterm = {undercurl = true}})
  vim.api.nvim_set_hl(0, "SpellRare", {fg = plt.green.g, undercurl = true, ctermfg = plt.green.c, cterm = {undercurl = true}})
  vim.api.nvim_set_hl(0, "Statusline", {link = "Normal"})
  vim.api.nvim_set_hl(0, "StatuslineNC", {link = "NormalNC"})
  vim.api.nvim_set_hl(0, "TabLine", {link = "Normal"})
  vim.api.nvim_set_hl(0, "TabLineFill", {link = "Normal"})
  vim.api.nvim_set_hl(0, "TabLineSel", {link = rainbow_group()})
  vim.api.nvim_set_hl(0, "Title", {link = rainbow_group()})
  vim.api.nvim_set_hl(0, "Visual", {bg = plt.grays.g, ctermbg = plt.grays.c})
  vim.api.nvim_set_hl(0, "VisualNOS", {link = "Visual"})
  vim.api.nvim_set_hl(0, "WarningMsg", {fg = plt.bgm.g, bg = plt.yellow.g, bold = true, ctermfg = plt.bgm.c, ctermbg = plt.yellow.c, cterm = {bold = true}})
  vim.api.nvim_set_hl(0, "WhiteSpace", {link = "Visual"})
  vim.api.nvim_set_hl(0, "WildMenu", {link = "PmenuSel"})
  vim.api.nvim_set_hl(0, "WinBar", {link = "Statusline"})
  vim.api.nvim_set_hl(0, "WinBarNC", {link = "StatuslineNC"})
  vim.api.nvim_set_hl(0, "Menu", {link = "Pmenu"})
  vim.api.nvim_set_hl(0, "Scrollbar", {link = "PmenuSbar"})
  vim.api.nvim_set_hl(0, "Tooltip", {link = "Title"})
end


local function hl_syntax()
  local groups = shuffled_rainbow()

  vim.api.nvim_set_hl(0, "Boolean", {link = groups[1]})

  vim.api.nvim_set_hl(0, "Character", {link = groups[2]})
  vim.api.nvim_set_hl(0, "String", {link = "Character"})

  vim.api.nvim_set_hl(0, "Constant", {link = groups[3]})
  vim.api.nvim_set_hl(0, "Float", {link = "Constant"})
  vim.api.nvim_set_hl(0, "Number", {link = "Constant"})

  vim.api.nvim_set_hl(0, "Keyword", {link = groups[4]})
  vim.api.nvim_set_hl(0, "Conditional", {link = "Keyword", italic = true, cterm = {italic = true}})
  vim.api.nvim_set_hl(0, "Exception", {link = "Conditional"})
  vim.api.nvim_set_hl(0, "Label", {link = "Conditional"})
  vim.api.nvim_set_hl(0, "Operator", {link = "Keyword"})
  vim.api.nvim_set_hl(0, "Repeat", {link = "Conditional"})
  vim.api.nvim_set_hl(0, "Statement", {link = "Conditional"})

  vim.api.nvim_set_hl(0, "Define", {link = groups[5]})
  vim.api.nvim_set_hl(0, "Include", {link = "Define", bold = true, cterm = {bold = true}})
  vim.api.nvim_set_hl(0, "Macro", {link = "Define"})
  vim.api.nvim_set_hl(0, "PreCondit", {link = "Define"})
  vim.api.nvim_set_hl(0, "PreProc", {link = "Define"})

  vim.api.nvim_set_hl(0, "Identifier", {link = groups[6]})
  vim.api.nvim_set_hl(0, "Function", {link = "Identifier", bold = true, cterm = {bold = true}})
  vim.api.nvim_set_hl(0, "Variable", {link = "Identifier"})

  vim.api.nvim_set_hl(0, "Type", {link = groups[7]})
  vim.api.nvim_set_hl(0, "TypeDef", {link = "Type"})
  vim.api.nvim_set_hl(0, "StorageClass", {link = "Type", bold = true, cterm = {bold = true}})
  vim.api.nvim_set_hl(0, "Structure", {link = "StorageClass"})

  vim.api.nvim_set_hl(0, "Special", {link = "NeuSpecial"})
  vim.api.nvim_set_hl(0, "SpecialChar", {link = "Special", bold = true, cterm = {bold = true}})
  vim.api.nvim_set_hl(0, "Tag", {link = "Special", underline = true, cterm = {underline = true}})
  vim.api.nvim_set_hl(0, "Delimeter", {link = "SpecialChar"})
  vim.api.nvim_set_hl(0, "SpecialComment", {link = "Special", italic = true, cterm = {italic = true}})

  vim.api.nvim_set_hl(0, "Bold", {bold = true, cterm = {bold = true}})
  vim.api.nvim_set_hl(0, "Italic", {italic = true, cterm = {italic = true}})
  vim.api.nvim_set_hl(0, "Underline", {underline = true, cterm = {underline = true}})

  vim.api.nvim_set_hl(0, "Debug", {link = "NeuHint"})
  vim.api.nvim_set_hl(0, "Note", {link = "NeuInfo"})
  vim.api.nvim_set_hl(0, "Todo", {link = "NeuWarning"})
  vim.api.nvim_set_hl(0, "Error", {link = "NeuError"})
end

function M.setup()
  vim.cmd("highlight clear")

  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  vim.o.termguicolors = true
  vim.o.bg = "dark"
  vim.g["colors_name"] = "neudom"

  local boption = {}
  local ioption = {}

  for group, option in pairs(basic) do
    vim.api.nvim_set_hl(0, group, option)

    boption = option
    boption.bold = true
    boption.cterm = {bold = true}
    vim.api.nvim_set_hl(0, group .. "Bold", boption)

    ioption = option
    ioption.italic = true
    ioption.cterm = {italic = true}
    vim.api.nvim_set_hl(0, group .. "Italic", ioption)
  end

  for _, table in ipairs(rainbow) do
    for group, option in pairs(table) do
      vim.api.nvim_set_hl(0, group, option)

      boption = option
      boption.bold = true
      boption.cterm = {bold = true}
      vim.api.nvim_set_hl(0, group .. "Bold", boption)

      ioption = option
      ioption.italic = true
      ioption.cterm = {italic = true}
      vim.api.nvim_set_hl(0, group .. "Italic", ioption)
    end
  end

  hl_native()
  hl_syntax()

  -- NOTE: For hot reloading.
  plt = require("palette").get()
end

return M
