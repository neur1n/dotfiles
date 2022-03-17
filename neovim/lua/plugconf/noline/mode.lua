local api = vim.api
local opt = vim.o

local M = {}

local Edit = require("noline.source.edit")
local Component = require("noline.utility.component")
local Highlight = require("noline.utility.highlight")

local link_map = {
  ["n"]    = "N",
  ["no"]   = "N",
  ["nov"]  = "N",
  ["noV"]  = "N",
  ["no"] = "N",
  ["niI"]  = "N",
  ["niR"]  = "N",
  ["niV"]  = "N",
  ["nt"]   = "N",
  ["v"]    = "V",
  ["vs"]   = "V",
  ["V"]   =  "V",
  ["Vs"]  =  "V",
  [""]  =  "V",
  ["s"] =  "V",
  ["s"]   =  "V",
  ["S"]   =  "V",
  [""]  =  "V",
  ["i"]   =  "I",
  ["ic"]  =  "I",
  ["ix"]  =  "I",
  ["R"]   =  "R",
  ["Rc"]  =  "R",
  ["Rx"]  =  "R",
  ["Rv"]  =  "R",
  ["Rvc"] =  "R",
  ["Rvx"] =  "R",
  ["c"]   =  "C",
  ["cv"]  =  "C",
  ["r"]   =  "C",
  ["rm"]  =  "C",
  ["r?"]  =  "C",
  ["!"]   =  "C",
  ["t"]   =  "C",
}

local prev_mode = ""

local curr_mode = ""

function M.highlight()
  for i = 1, api.nvim_win_get_number("$") do
    if i == api.nvim_win_get_number(0) then
      curr_mode = link_map[api.nvim_get_mode().mode]

      if curr_mode ~= prev_mode then
        prev_mode = curr_mode
        Highlight.link("NMode", "NMode" .. curr_mode)
      end
    end
  end
end

local shrink_threshold = 100

local special_fts = {
  ["help"]     = "HELP",
  ["startify"] = "STARTIFY",
  ["vim-plug"] = "VIM-PLUG",
}

function M.get(l_decor, r_decor)
  local expr = ""
  local type = special_fts[opt.filetype]

  if type ~= nil then
    expr = Component.decorate(type, l_decor, r_decor)
  else
    if api.nvim_win_get_width(0) < shrink_threshold then
      expr = Edit.mode(Edit.default_mode_map.abbr, l_decor, r_decor)
    else
      expr = Edit.mode(Edit.default_mode_map.full, l_decor, r_decor)
    end
  end

  return expr
end

return M
