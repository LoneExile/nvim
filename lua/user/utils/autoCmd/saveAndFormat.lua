-- local group = vim.api.nvim_create_augroup("SaveNFormat", { clear = true })
vim.api.nvim_create_user_command("SaveNFormat", function()
	vim.cmd("lua 	require('user.utils.format').format()")
	-- vim.cmd("LspZeroFormat")
	vim.cmd("w!")
end, {})