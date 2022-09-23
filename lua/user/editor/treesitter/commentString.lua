local M = {}

M.configs = {
	javascript = {
		__default = "// %s",
		jsx_element = "{/* %s */}",
		jsx_fragment = "{/* %s */}",
		jsx_attribute = "// %s",
		comment = "// %s",
	},
	css = "// %s",
	typescript = { __default = "// %s", __multiline = "/* %s */" },
}

require("ts_context_commentstring.internal").update_commentstring({
	key = "__multiline",
})

require("ts_context_commentstring.internal").calculate_commentstring({
	location = require("ts_context_commentstring.utils").get_cursor_location(),
})

return M
