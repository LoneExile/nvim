local status_ok, notify = pcall(require, "notify")
if not status_ok then
	vim.notify("notify" .. " not found!")
	return
end

notify.setup({
	background_colour = "#000000",
})

-- require("notify")("My super important message")
-- vim.notify("This is an error message", "error")
