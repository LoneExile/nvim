local M = {}

-- TODO: checkout this plugin: 'pmizio/typescript-tools.nvim',

M.setup = function()
  return {
    'jose-elias-alvarez/typescript.nvim',
    enabled = M.enabled,
    -- dependencies = { 'SmiteshP/nvim-navic' },
    -- lazy = true,
    ft = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },

    -- config = function()
    --   local status, typescript = pcall(require, 'typescript')
    --   if not status then
    --     return
    --   end
    --   typescript.setup({
    --     disable_commands = false, -- prevent the plugin from creating Vim commands
    --     debug = false, -- enable debug logging for commands
    --     go_to_source_definition = {
    --       fallback = true, -- fall back to standard LSP definition on failure
    --     },
    --     server = { -- pass options to lspconfig's setup method
    --       on_attach = function(client, bufnr)
    --         local status_ok, navic = pcall(require, 'nvim-navic')
    --         if not status_ok then
    --           return
    --         end
    --         navic.attach(client, bufnr)
    --         vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
    --       end,
    --     },
    --   })
    -- end,
  }
end

return M
