local status_ok_ui, masonSet = pcall(require, "mason.settings")
if not status_ok_ui then
	return
end
masonSet.set({
	ui = {
		border = "rounded",
	},
})
