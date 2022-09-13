local group = vim.api.nvim_create_augroup("colorAttach", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
	pattern = { "*" },
	command = ":ColorizerAttachToBuffer",
	group = group,
})
