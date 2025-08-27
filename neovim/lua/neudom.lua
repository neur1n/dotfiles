local Palette = require("palette")

local M = {}

local function create_group(palette)
  local basic = {
    NeuBgH = {bg = palette.bgh.g, bold = false, italic = false, ctermbg = palette.bgh.c, cterm = {}},
    NeuBgM = {bg = palette.bgm.g, bold = false, italic = false, ctermbg = palette.bgm.c, cterm = {}},
    NeuBgS = {bg = palette.bgs.g, bold = false, italic = false, ctermbg = palette.bgs.c, cterm = {}},

    NeuFgH = {fg = palette.fgh.g, bold = false, italic = false, ctermfg = palette.fgh.c, cterm = {}},
    NeuFgM = {fg = palette.fgm.g, bold = false, italic = false, ctermfg = palette.fgm.c, cterm = {}},
    NeuFgS = {fg = palette.fgs.g, bold = false, italic = false, ctermfg = palette.fgs.c, cterm = {}},

    NeuGrayH = {fg = palette.grayh.g, bold = false, italic = false, ctermfg = palette.grayh.c, cterm = {}},
    NeuGrayM = {fg = palette.graym.g, bold = false, italic = false, ctermfg = palette.graym.c, cterm = {}},
    NeuGrayS = {fg = palette.grays.g, bold = false, italic = false, ctermfg = palette.grays.c, cterm = {}},

    NeuError = {fg = palette.red.g, bold = false, italic = false, ctermfg = palette.red.c, cterm = {}},
    NeuWarning = {fg = palette.orange.g, bold = false, italic = false, ctermfg = palette.orange.c, cterm = {}},
    NeuInfo = {fg = palette.blue.g, bold = false, italic = false, ctermfg = palette.blue.c, cterm = {}},
    NeuHint = {fg = palette.green.g, bold = false, italic = false, ctermfg = palette.green.c, cterm = {}},
  }

  local rainbow = {
    {NeuRed = {fg = palette.red.g, bold = false, italic = false, ctermfg = palette.red.c, cterm = {}}},
    {NeuOrange = {fg = palette.orange.g, bold = false, italic = false, ctermfg = palette.orange.c, cterm = {}}},
    {NeuYellow = {fg = palette.yellow.g, bold = false, italic = false, ctermfg = palette.yellow.c, cterm = {}}},
    {NeuGreen = {fg = palette.green.g, bold = false, italic = false, ctermfg = palette.green.c, cterm = {}}},
    {NeuCyan = {fg = palette.cyan.g, bold = false, italic = false, ctermfg = palette.cyan.c, cterm = {}}},
    {NeuBlue = {fg = palette.blue.g, bold = false, italic = false, ctermfg = palette.blue.c, cterm = {}}},
    {NeuPurple = {fg = palette.purple.g, bold = false, italic = false, ctermfg = palette.purple.c, cterm = {}}},
    {NeuSpecial = {fg = palette.special.g, bold = false, italic = false, ctermfg = palette.special.c, cterm = {}}},
  }

  return {basic = basic, rainbow = rainbow}
end

local function rainbow_group(rainbow)
  math.randomseed(os.time())
  for group, _ in pairs(rainbow[math.random(#rainbow)]) do
    return group
  end
end

local function rainbow_option(rainbow)
  math.randomseed(os.time())
  for _, option in pairs(rainbow[math.random(#rainbow)]) do
    return option
  end
end

local function rainbow_shuffle()
  local rainbow = {
    "NeuRed",
    "NeuOrange",
    "NeuYellow",
    "NeuGreen",
    "NeuCyan",
    "NeuBlue",
    "NeuPurple"
  }

  math.randomseed(os.time())
  for i = #rainbow, 2, -1 do
    local j = math.random(i)
    rainbow[i], rainbow[j] = rainbow[j], rainbow[i]
  end

  return rainbow
end

local function hl_native(rainbow)
  local palette = Palette.get(Palette.current())
  local option = {}

  vim.api.nvim_set_hl(0, "Comment", {fg = palette.graym.g, italic = true, ctermfg = palette.graym.c, cterm = {italic = true}})
  vim.api.nvim_set_hl(0, "Normal", {fg = palette.fgm.g, bg = palette.bgm.g, ctermfg = palette.fgm.c, ctermbg = palette.bgm.c})
  vim.api.nvim_set_hl(0, "NormalNC", {fg = palette.fgm.g, bg = palette.bgs.g, ctermfg = palette.fgm.c, ctermbg = palette.bgs.c})

  -- Order mostly following `:h highlight-groups`.
  vim.api.nvim_set_hl(0, "ColorColumn", {bg = palette.bgs.g, ctermbg = palette.bgs.c})
  vim.api.nvim_set_hl(0, "Cursor", {reverse = true, cterm = {reverse = true}})
  vim.api.nvim_set_hl(0, "lCursor", {link = "Cursor"})
  vim.api.nvim_set_hl(0, "CursorIM", {link = "Cursor"})
  vim.api.nvim_set_hl(0, "CursorColumn", {link = "ColorColumn"})
  vim.api.nvim_set_hl(0, "CursorLine", {link = "ColorColumn"})
  vim.api.nvim_set_hl(0, "Directory", {link = "NeuBlueBold"})
  vim.api.nvim_set_hl(0, "DiffAdd", {fg = palette.bgm.g, bg = palette.green.g, ctermfg = palette.bgm.c, ctermbg = palette.green.c})
  vim.api.nvim_set_hl(0, "DiffChange", {fg = palette.bgm.g, bg = palette.orange.g, ctermfg = palette.bgm.c, ctermbg = palette.orange.c})
  vim.api.nvim_set_hl(0, "DiffDelete", {fg = palette.bgm.g, bg = palette.red.g, ctermfg = palette.bgm.c, ctermbg = palette.red.c})
  vim.api.nvim_set_hl(0, "DiffText", {fg = palette.bgm.g, bg = palette.yellow.g, ctermfg = palette.bgm.c, ctermbg = palette.yellow.c})
  vim.api.nvim_set_hl(0, "EndOfBuffer", {link = "NeuGrayM"})
  vim.api.nvim_set_hl(0, "TermCursor", {link = "NeuSpecialBold"})
  vim.api.nvim_set_hl(0, "ErrorMsg", {fg = palette.bgm.g, bg = palette.red.g, bold = true, ctermfg = palette.bgm.c, ctermbg = palette.red.c, cterm = {bold = true}})
  vim.api.nvim_set_hl(0, "Folded", {link = "Comment"})
  vim.api.nvim_set_hl(0, "FoldColumn", {link = "Comment"})
  vim.api.nvim_set_hl(0, "IncSearch", {fg = palette.bgh.g, bg = palette.special.g, bold = true, ctermfg = palette.bgh.c, ctermbg = palette.special.c, cterm = {bold = true}})
  vim.api.nvim_set_hl(0, "Substitute", {link = "IncSearch"})
  vim.api.nvim_set_hl(0, "LineNr", {link = "NeuGrayM"})
  vim.api.nvim_set_hl(0, "CursorLineNr", {link = rainbow_group(rainbow)})
  vim.api.nvim_set_hl(0, "LineNrAbove", {link = "LineNr"})
  vim.api.nvim_set_hl(0, "LineNrBelow", {link = "LineNr"})
  vim.api.nvim_set_hl(0, "CursorLineFold", {link = "FoldColumn"})
  vim.api.nvim_set_hl(0, "CursorLineSign", {link = "SignColumn"})
  vim.api.nvim_set_hl(0, "MatchParen", {bg = palette.grays.g, underline = true, ctermbg = palette.grays.c, cterm = {underline = true}})
  vim.api.nvim_set_hl(0, "ModeMsg", {link = "Normal"})
  vim.api.nvim_set_hl(0, "MsgArea", {link = "Normal"})
  vim.api.nvim_set_hl(0, "MsgSeparator", {link = "Normal"})
  vim.api.nvim_set_hl(0, "MoreMsg", {link = rainbow_group(rainbow)})
  vim.api.nvim_set_hl(0, "NonText", {link = "Comment"})
  vim.api.nvim_set_hl(0, "NormalFloat", {link = "Comment"})
  vim.api.nvim_set_hl(0, "FloatBorder", {link = rainbow_group(rainbow)})
  vim.api.nvim_set_hl(0, "FloatTitle", {link = "FloatBorder"})
  option = rainbow_option(rainbow)
  vim.api.nvim_set_hl(0, "Pmenu", {})
  vim.api.nvim_set_hl(0, "PmenuSel", {fg = palette.bgm.g, bg = option.fg, bold = true, ctermfg = palette.bgm.c, ctermbg = option.ctermfg, cterm = {bold = true}})
  vim.api.nvim_set_hl(0, "PmenuKind", {link = "Pmenu"})
  vim.api.nvim_set_hl(0, "PmenuKindSel", {link = "PmenuSel"})
  vim.api.nvim_set_hl(0, "PmenuExtra", {link = "Pmenu"})
  vim.api.nvim_set_hl(0, "PmenuExtraSel", {link = "PmenuSel"})
  vim.api.nvim_set_hl(0, "PmenuBar", {bg = palette.bgm.g, ctermbg = palette.bgm.c})
  option = rainbow_option(rainbow)
  vim.api.nvim_set_hl(0, "PmenuThumb", {bg = option.fg, ctermbg = option.ctermfg})
  option = rainbow_option(rainbow)
  vim.api.nvim_set_hl(0, "Question", {fg = option.fg, bg = palette.bgm.g, ctermfg = option.ctermfg, ctermbg = palette.bgm.c})
  vim.api.nvim_set_hl(0, "QuickFixLine", {link = "CursorLine"})
  vim.api.nvim_set_hl(0, "Search", {link = "IncSearch"})
  vim.api.nvim_set_hl(0, "SpecialKey", {link = "Comment"})
  vim.api.nvim_set_hl(0, "SpellBad", {fg = palette.red.g, undercurl = true, ctermfg = palette.red.c, cterm = {undercurl = true}})
  vim.api.nvim_set_hl(0, "SpellCap", {fg = palette.orange.g, undercurl = true, ctermfg = palette.orange.c, cterm = {undercurl = true}})
  vim.api.nvim_set_hl(0, "SpellLocal", {fg = palette.blue.g, undercurl = true, ctermfg = palette.blue.c, cterm = {undercurl = true}})
  vim.api.nvim_set_hl(0, "SpellRare", {fg = palette.green.g, undercurl = true, ctermfg = palette.green.c, cterm = {undercurl = true}})
  vim.api.nvim_set_hl(0, "Statusline", {link = "Normal"})
  vim.api.nvim_set_hl(0, "StatuslineNC", {link = "NormalNC"})
  vim.api.nvim_set_hl(0, "TabLine", {link = "Normal"})
  vim.api.nvim_set_hl(0, "TabLineFill", {link = "Normal"})
  vim.api.nvim_set_hl(0, "TabLineSel", {link = rainbow_group(rainbow)})
  vim.api.nvim_set_hl(0, "Title", {link = rainbow_group(rainbow)})
  vim.api.nvim_set_hl(0, "Visual", {bg = palette.grays.g, ctermbg = palette.grays.c})
  vim.api.nvim_set_hl(0, "VisualNOS", {link = "Visual"})
  vim.api.nvim_set_hl(0, "WarningMsg", {fg = palette.bgm.g, bg = palette.yellow.g, bold = true, ctermfg = palette.bgm.c, ctermbg = palette.yellow.c, cterm = {bold = true}})
  vim.api.nvim_set_hl(0, "WhiteSpace", {link = "Visual"})
  vim.api.nvim_set_hl(0, "WildMenu", {link = "PmenuSel"})
  vim.api.nvim_set_hl(0, "WinBar", {link = "Statusline"})
  vim.api.nvim_set_hl(0, "WinBarNC", {link = "StatuslineNC"})
  vim.api.nvim_set_hl(0, "WinSeparator", {link = "NormalNC"})
  vim.api.nvim_set_hl(0, "Menu", {link = "Pmenu"})
  vim.api.nvim_set_hl(0, "Scrollbar", {link = "PmenuSbar"})
  vim.api.nvim_set_hl(0, "Tooltip", {link = "Title"})
end

local function hl_syntax()
  local rainbow = rainbow_shuffle()

  vim.api.nvim_set_hl(0, "Boolean", {link = rainbow[1]})

  vim.api.nvim_set_hl(0, "Character", {link = rainbow[2]})
  vim.api.nvim_set_hl(0, "String", {link = "Character"})

  vim.api.nvim_set_hl(0, "Constant", {link = rainbow[3]})
  vim.api.nvim_set_hl(0, "Float", {link = "Constant"})
  vim.api.nvim_set_hl(0, "Number", {link = "Constant"})

  vim.api.nvim_set_hl(0, "Keyword", {link = rainbow[4]})
  vim.api.nvim_set_hl(0, "Conditional", {link = "Keyword", italic = true, cterm = {italic = true}})
  vim.api.nvim_set_hl(0, "Exception", {link = "Conditional"})
  vim.api.nvim_set_hl(0, "Label", {link = "Conditional"})
  vim.api.nvim_set_hl(0, "Operator", {link = "Keyword"})
  vim.api.nvim_set_hl(0, "Repeat", {link = "Conditional"})
  vim.api.nvim_set_hl(0, "Statement", {link = "Conditional"})

  vim.api.nvim_set_hl(0, "Define", {link = rainbow[5]})
  vim.api.nvim_set_hl(0, "Include", {link = "Define", bold = true, cterm = {bold = true}})
  vim.api.nvim_set_hl(0, "Macro", {link = "Define"})
  vim.api.nvim_set_hl(0, "PreCondit", {link = "Define"})
  vim.api.nvim_set_hl(0, "PreProc", {link = "Define"})

  vim.api.nvim_set_hl(0, "Identifier", {link = rainbow[6]})
  vim.api.nvim_set_hl(0, "Function", {link = "Identifier", bold = true, cterm = {bold = true}})
  vim.api.nvim_set_hl(0, "Variable", {link = "Identifier"})

  vim.api.nvim_set_hl(0, "Type", {link = rainbow[7]})
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

local function hl_terminal()
  local palette = Palette.get(Palette.current())

  vim.g.terminal_color_0 = palette.bgs.g
  vim.g.terminal_color_8 = palette.bgm.g

  vim.g.terminal_color_1 = palette.red.g
  vim.g.terminal_color_9 = palette.red.g

  vim.g.terminal_color_2 = palette.green.g
  vim.g.terminal_color_10 = palette.green.g

  vim.g.terminal_color_3 = palette.yellow.g
  vim.g.terminal_color_11 = palette.yellow.g

  vim.g.terminal_color_4 = palette.blue.g
  vim.g.terminal_color_12 = palette.blue.g

  vim.g.terminal_color_5 = palette.purple.g
  vim.g.terminal_color_13 = palette.purple.g

  vim.g.terminal_color_6 = palette.cyan.g
  vim.g.terminal_color_14 = palette.cyan.g

  vim.g.terminal_color_7 = palette.fgs.g
  vim.g.terminal_color_15 = palette.fgm.g
end

function M.setup()
  vim.cmd("highlight clear")

  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  vim.o.termguicolors = true
  vim.o.bg = "dark"
  vim.g["colors_name"] = "neudom"

  local palette = Palette.get()
  local hlgrp = create_group(palette)

  local boption = {}
  local ioption = {}

  for group, option in pairs(hlgrp.basic) do
    vim.api.nvim_set_hl(0, group, option)

    boption = vim.deepcopy(option)
    boption.bold = true
    boption.cterm = {bold = true}
    vim.api.nvim_set_hl(0, group .. "Bold", boption)

    ioption = vim.deepcopy(option)
    ioption.italic = true
    ioption.cterm = {italic = true}
    vim.api.nvim_set_hl(0, group .. "Italic", ioption)
  end

  for _, table in ipairs(hlgrp.rainbow) do
    for group, option in pairs(table) do
      vim.api.nvim_set_hl(0, group, option)

      boption = vim.deepcopy(option)
      boption.bold = true
      boption.cterm = {bold = true}
      vim.api.nvim_set_hl(0, group .. "Bold", boption)

      ioption = vim.deepcopy(option)
      ioption.italic = true
      ioption.cterm = {italic = true}
      vim.api.nvim_set_hl(0, group .. "Italic", ioption)
    end
  end

  hl_native(hlgrp.rainbow)
  hl_syntax()
  hl_terminal()
end

return M
