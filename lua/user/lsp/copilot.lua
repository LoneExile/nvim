vim.g.copilot_filetypes = { xml = false }
vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-a>", "copilot#Accept('<CR>')", { expr = true, silent = true })

vim.api.nvim_set_keymap("i", "<C-.>", "<Plug>(copilot-next)", { noremap = false })
vim.api.nvim_set_keymap("i", "<C-,>", "<Plug>(copilot-previous)", { noremap = false })

vim.cmd([[highlight CopilotSuggestion guifg=#555555 ctermfg=8]])

-----------------------

local status_ok, copilot = pcall(require, "copilot")
if not status_ok then
	vim.notify("copilot" .. " not found!")
	return
end

local config = {
	cmp = {
		enabled = true,
		method = "getCompletionsCycling",
	},
	panel = {
		enabled = true,
	},
	ft_disable = { "alpha" },
	plugin_manager_path = vim.fn.expand("$HOME") .. "/.local/share/nvim/site/pack/packer",
}
copilot.setup(config)
-- ----------------------------------------------------------------------------

-- local status_ok, copilot = pcall(require, "copilot")
-- if not status_ok then
--   vim.notify("copilot" .. " not found!")
--   return
-- end
--
-- copilot.setup({
--   panel = {
--     enabled = false,
--   },
--   ft_disable = { "alpha" },
--   plugin_manager_path = vim.fn.expand("$HOME") .. "/.local/share/nvim/site/pack/packer",
-- })
--
-- require("copilot_cmp").setup({
--   method = "getCompletionsCycling",
--   -- formatters = {
--   --   insert_text = require("copilot_cmp.format").remove_existing,
--   -- },
-- })
