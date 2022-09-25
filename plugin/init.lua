require("todo")

vim.cmd[[
  command! TodoOpen lua require("todo").open()
]]
