local M = {}

M.setup = function(_, location)
  return {
    'jose-elias-alvarez/null-ls.nvim',
    -- enabled = false,
    config = function()
      local status_ok, null_ls = pcall(require, 'null-ls')
      if not status_ok then
        return
      end

      local hover = null_ls.builtins.hover

      local sources = {

        -- hover
        hover.dictionary.with({
          -- filetypes = { "text", "markdown" },
        }),
        hover.printenv.with({
          filetypes = { 'bash', 'csh', 'ksh', 'sh', 'zsh' },
        }),
      }

      local formattingTable = require(location .. '.formatting')
      local diagnosticsTable = require(location .. '.diagnostics')
      local code_actionsTable = require(location .. '.codeAction')
      local all = { formattingTable, diagnosticsTable, code_actionsTable }

      for _, value in ipairs(all) do
        for _, v in ipairs(value) do
          table.insert(sources, v)
        end
      end

      -- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts

      null_ls.setup({
        -- on_attach = on_attach,
        sources = sources,
      })
    end,
  }
end

return M
