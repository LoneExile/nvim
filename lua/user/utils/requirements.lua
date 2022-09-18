if vim.fn.has("nvim-0.7") ~= 1 then
	-- vim.notify("Please upgrade your Neovim base installation.requires v0.8+", vim.log.levels.WARN)
	print("Please upgrade your Neovim base installation.requires v0.8+")
	vim.wait(5000, function()
		return false
	end)
	vim.cmd("cquit")
end
