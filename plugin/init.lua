require("todo")
-- require("todo").setup({
--   default_file_extension = ".txt"
-- })

vim.api.nvim_create_user_command("TodoOpen", function (cmd)
  require("todo").open(cmd.args)
end, { nargs = "?" })

-- vim.cmd[[
--   command! TodoOpen lua require("todo").open()
-- ]]
