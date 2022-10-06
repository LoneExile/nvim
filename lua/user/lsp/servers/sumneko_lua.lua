local _, lua_dev = pcall(require, 'lua-dev')

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lua_dev.setup({})

local M = {}
M.setup = function(lspconfig)
  lspconfig.sumneko_lua.setup({
    filetypes = { 'lua' },
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using
          version = 'LuaJIT',
          path = runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { 'vim' },
        },
        workspace = {
          library = {
            -- Make the server aware of Neovim runtime files
            vim.fn.expand('$VIMRUNTIME/lua'),
            vim.fn.stdpath('config') .. '/lua',
          },
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
        completion = {
          callSnippet = 'Replace',
        },
      },
    },
  })
end

return M
