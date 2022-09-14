local status_ok, autotag = pcall(require, "nvim-ts-autotag")
if not status_ok then
	vim.notify("nvim-ts-autotag" .. " not found!")
	return
end

-- Before        Input         After
-- ------------------------------------
-- <div           >              <div></div>
-- <div></div>    ciwspan<esc>   <span></span>
-- ------------------------------------

autotag.setup({
	filetypes = {
		"html",
		"javascript",
		"typescript",
		"javascriptreact",
		"typescriptreact",
		"svelte",
		"vue",
		"tsx",
		"jsx",
		"rescript",
		"xml",
		"php",
		"markdown",
		"glimmer",
		"handlebars",
		"hbs",
	},
	skip_tags = {
		"area",
		"base",
		"br",
		"col",
		"command",
		"embed",
		"hr",
		"img",
		"slot",
		"input",
		"keygen",
		"link",
		"meta",
		"param",
		"source",
		"track",
		"wbr",
		"menuitem",
	},
})
