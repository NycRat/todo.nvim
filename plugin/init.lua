require("todo")
require("todo").setup({
  default_file_extension = ".txt"
})
vim.api.nvim_create_user_command("TodoOpen", function (cmd)
  local path = vim.fn.expand("%:F")
  require("todo").push_previous_file(path)
  require("todo").open(cmd.args)
end, { nargs = "?" })

vim.api.nvim_create_user_command("TodoClose", function (cmd)
  local path = vim.fn.expand("%:F")
  require("todo").close(path)
end, {})
