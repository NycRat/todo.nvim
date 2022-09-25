local M = {}

local data_path = vim.fn.stdpath("data")
local todo_path = data_path.."/todo.nvim/"
local default_todo_file = "todo.txt"

local file = io.open(todo_path..default_todo_file, "a")
if (file == nil) then
  os.execute("mkdir "..todo_path)
  io.open(todo_path..default_todo_file, "w")
else
  io.close(file)
end

local function get_file_extension(file_path)
  local arr = {}
  for word in file_path:gmatch('[^.%s]+') do
    table.insert(arr, word)
  end
  if (#arr == 1) then
    return nil
  else
    return arr[#arr]
  end
end

M.options = {
  default_file_extension = ".txt"
}

M.setup = function(user_opts)
  if user_opts ~= nil then
    if user_opts.default_file_extension ~= nil then
      M.options.default_file_extension = user_opts.default_file_extension
    end
  end
end

M.open = function(todo_file)
  if (todo_file == nil or todo_file == "") then
    todo_file = default_todo_file
  else
    local file_extension = get_file_extension(todo_file)

    if file_extension == nil then
      todo_file = todo_file..M.options.default_file_extension
    end

    todo_file = todo_file
  end
  vim.cmd("e "..todo_path..todo_file)
  print("OPENED TODO FILE: "..todo_file)
end

return M
