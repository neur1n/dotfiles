local M = {}

function M.get()
  return vim.call('neutil#plt#Get', 'current')
end

return M
