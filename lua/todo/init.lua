local M = {}

local data_path = vim.fn.stdpath("data")
local todo_path = data_path.."/todo.nvim/"
local default_todo_file = todo_path.."todo.txt"

local file = io.open(default_todo_file, "a")
if (file == nil) then
  os.execute("mkdir "..todo_path)
  io.open(default_todo_file, "w")
else
  io.close(file)
end

M.open = function (todo_file)
  if (todo_file == nil) then
    vim.cmd("e "..default_todo_file)
  else
    vim.cmd("e "..todo_path..default_todo_file)
  end
end

return M
