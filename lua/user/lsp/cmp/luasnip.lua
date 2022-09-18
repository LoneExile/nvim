local luasnip_ok, luasnip = pcall(require, "luasnip")
if not luasnip_ok then
	vim.notify("luasnip" .. " not found!")
	return
end

local types = require("luasnip.util.types")

luasnip.config.set_config({
	-- This tells LuaSnip to remember to keep around the last snippet.
	-- You can jump back into it even if you move outside of the selection
	history = true,
	updateevents = "TextChanged,TextChangedI",
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { " « ", "NonTest" } },
			},
		},
	},
})
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({
	paths = { "./snippets/" },
})

-- <c-j> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
vim.keymap.set({ "i", "s" }, "<c-j>", function()
	if luasnip.expand_or_jumpable() then
		luasnip.expand_or_jump()
	end
end, { silent = true })

-- -- <c-k> is my jump backwards key.
-- -- this always moves to the previous item within the snippet
-- vim.keymap.set({ "i", "s" }, "<c-k>", function()
-- 	if luasnip.jumpable(-1) then
-- 		luasnip.jump(-1)
-- 	end
-- end, { silent = true })

-- <c-l> is selecting within a list of options.
-- This is useful for choice nodes
vim.keymap.set("i", "<c-l>", function()
	if luasnip.choice_active() then
		luasnip.change_choice(1)
	end
end, {})

-- vim.keymap.set("i", "<c-u>", require("luasnip.extras.select_choice"))
