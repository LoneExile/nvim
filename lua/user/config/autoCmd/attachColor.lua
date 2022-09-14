local group = vim.api.nvim_create_augroup("colorAttach", { clear = true })

local events = { "BufEnter", "BufWinEnter", "CursorMoved" }
vim.api.nvim_create_autocmd(events, {
	pattern = { "*" },
	command = ":ColorizerAttachToBuffer",
	group = group,
})
