local M = {}

local data_path = vim.fn.stdpath("data").."/"
local todo_path = data_path.."todo.nvim/"
local default_todo_file_path = "todo.txt"
local todo_file_list_file_path = "todo_list_list.txt";

local file = io.open(todo_path..default_todo_file_path, "a")
if (file == nil) then
  os.execute("mkdir "..todo_path)
  io.open(todo_path..default_todo_file_path, "w")
else
  io.close(file)
end

file = io.open(todo_path..todo_file_list_file_path, "a")
if (file == nil) then
  os.execute("mkdir "..todo_path)
  io.open(todo_path..todo_file_list_file_path, "w")
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

local is_in_todo_path = function(path)
  local data_path_dirs = data_path:gmatch('[^/%s]+')
  local current_file_dirs = path:gmatch('[^/%s]+')
  while true do
    local data_dir = data_path_dirs()
    local prev_dir = current_file_dirs()
    if (data_dir == nil) then
      break
    end
    if (prev_dir == nil) then
      break
    end

    if (prev_dir ~= data_dir) then
      return false
    end
  end
  return true
end

M.previous_file = ".";

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

M.push_previous_file = function(current_path)
  if (is_in_todo_path(current_path)) then
    return
  end
  M.previous_file = current_path
end

M.openTodoFileList = function()
  vim.cmd("e "..data_path..todo_file_list_file_path)
end

M.open = function(todo_file)
  if (todo_file == nil or todo_file == "") then
    todo_file = default_todo_file_path
  else
    local file_extension = get_file_extension(todo_file)

    if file_extension == nil then
      todo_file = todo_file..M.options.default_file_extension
    end

    todo_file = todo_file
  end

  vim.cmd("e "..todo_path..todo_file)
  print("Opened Todo File: "..todo_file)
end

M.openIndex = function(file_index)
  file_index = tonumber(file_index)
  if (file_index > 10000 or file_index < 1) then
    -- no way you have this many todo files
    return
  end

  local todo_file_list_file = io.open(data_path..todo_file_list_file_path, "r")
  io.input(todo_file_list_file)

  local i = 1
  local line = ""
  while true do
    line = io.read("l")
    if (line == nil) then
      break
    end
    if (i == file_index) then
      vim.cmd("e "..todo_path..line)
      print("Opened Todo File: "..line)
      break
    end
    i = i + 1
  end
end

M.close = function(current_path)
  if (is_in_todo_path(current_path)) then
    if (M.previous_file == "") then
      M.previous_file = ".";
    end
    vim.cmd("e "..M.previous_file)
    print("Closed Todo File")
  end
end

return M
