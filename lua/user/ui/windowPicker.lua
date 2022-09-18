local status_ok, windowPicker = pcall(require, "window-picker")
if not status_ok then
	vim.notify("windowPicker" .. " not found!")
	return
end
windowPicker.setup({
	autoselect_one = true,
	include_current = false,
	filter_rules = {
		-- filter using buffer options
		bo = {
			-- if the file type is one of following, the window will be ignored
			filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },

			-- if the buffer type is one of following, the window will be ignored
			buftype = { "terminal" },
		},
	},
	other_win_hl_color = "#e35e4f",
})
