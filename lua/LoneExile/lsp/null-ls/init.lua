local M = {}

M.setup = function(s, location)
  return {
    'nvimtools/none-ls.nvim',
    event = { 'BufReadPre', 'InsertEnter' },
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

      local formattingTable = require(location .. '.formatting').setup(null_ls, s)
      local diagnosticsTable = require(location .. '.diagnostics').setup(null_ls, s)
      local code_actionsTable = require(location .. '.codeAction').setup(null_ls, s)
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
