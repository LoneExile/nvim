local status_ok, wk = pcall(require, "which-key")
if not status_ok then
	vim.notify("which-key" .. " not found!")
	return
end

local group = vim.api.nvim_create_augroup("neoTree", { clear = true })
local events = { "BufEnter", "BufWinEnter" }
vim.api.nvim_create_autocmd(events, {
	pattern = { "*" },
	callback = function()
		local fileType = vim.api.nvim_buf_get_option(0, "filetype")
		local opts = { prefix = "<localleader>", buffer = 0 }
		if fileType == "neo-tree" then
			wk.register({
				["F"] = { "<cmd>Neotree action=focus source=filesystem position=right<CR>", "files" },
				["G"] = { "<cmd>Neotree action=focus source=git_status position=right<CR>", "git" },
				["B"] = { "<cmd>Neotree action=focus source=buffers position=right<CR>", "buff" },
			}, opts)
		end
	end,
	group = group,
})
