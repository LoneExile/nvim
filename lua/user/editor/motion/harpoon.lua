local status_ok, harpoon = pcall(require, "harpoon")
if not status_ok then
	return
end

local configs = {
	global_settings = {
		-- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
		save_on_toggle = false,

		-- saves the harpoon file upon every change. disabling is unrecommended.
		save_on_change = true,

		-- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
		enter_on_sendcmd = false,

		-- closes any tmux windows harpoon that harpoon creates when you close Neovim.
		tmux_autoclose_windows = false,

		-- filetypes that you want to prevent from adding to the harpoon list menu.
		excluded_filetypes = { "harpoon" },

		-- set marks specific to each git branch inside git repository
		mark_branch = false,
	},
}

harpoon.setup(configs)

local opts = { noremap = true, silent = true }

-- vim.keymap.set("n", "<C-1>", "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", opts)
vim.keymap.set("n", "<C-1>", "<cmd>OpenHarpoonNav<CR>", opts)
vim.keymap.set("n", "<C-2>", "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", opts)
vim.keymap.set("n", "<C-3>", "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", opts)
vim.keymap.set("n", "<C-4>", "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", opts)
vim.keymap.set("n", "<C-5>", "<cmd>lua require('harpoon.ui').nav_file(5)<CR>", opts)

vim.api.nvim_create_user_command("OpenHarpoonNav", function()
	require("harpoon.ui").nav_file(1)
end, {})

vim.api.nvim_create_user_command("OpenHarpoonAll", function()
	require("harpoon.ui").nav_file(1)
	require("harpoon.ui").nav_file(2)
	require("harpoon.ui").nav_file(3)
	require("harpoon.ui").nav_file(4)
	require("harpoon.ui").nav_file(5)
	require("harpoon.ui").nav_file(6)
	require("harpoon.ui").nav_file(7)
	require("harpoon.ui").nav_file(8)
	require("harpoon.ui").nav_file(9)
	-- vim.cmd("NvimTreeClose")
end, {})
