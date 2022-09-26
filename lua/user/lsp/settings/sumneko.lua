-- local _, lsp = pcall(require, 'lsp-zero')
local _, lua_dev = pcall(require, 'lua-dev')

local M = {}

M.setup = function(lsp)
  local luadev = lua_dev.setup({
    library = {
      enabled = true,
      runtime = true,
      types = true,
      plugins = true,
    },
    setup_jsonls = true,
    override = function(root_dir, library)
      if require('lua-dev.util').has_file(root_dir, '/etc/nixos') then
        library.enabled = true
        library.plugins = true
      end
    end,
  })
  lsp.configure('sumneko_lua', luadev)
end

return M
