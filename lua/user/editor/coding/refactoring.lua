local status_ok_ui, telescope = pcall(require, "telescope")
if not status_ok_ui then
	return
end

telescope.load_extension("refactoring")
