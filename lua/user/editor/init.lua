-- git
require("user.editor.git.gitsigns")
require("user.editor.git.gitConflict")
require("user.editor.git.diffView")

-- coding
require("user.editor.coding.refactoring")
require("user.editor.coding.sniprun")
require("user.editor.coding.codi")
require("user.editor.coding.toggleterm").setup()

-- tool
require("user.editor.tool.telescope").setup()
require("user.editor.tool.sessionManager")
require("user.editor.tool.spectre")
require("user.editor.tool.indentOmatic")

-- motion
require("user.editor.motion.mini")
require("user.editor.motion.numb")
require("user.editor.motion.smoothScroll")
require("user.editor.motion.harpoon")
require("user.editor.motion.betterEscape")
require("user.editor.motion.mark")

-- color
require("user.editor.color.colorizer")
require("user.editor.color.colortils")

-- treesitter
require("user.editor.treesitter.ts")
require("user.editor.treesitter.tsContext")
require("user.editor.treesitter.tsIndent")
require("user.editor.treesitter.comment")
require("user.editor.treesitter.autoTag")
require("user.editor.treesitter.autoPair").setup()
