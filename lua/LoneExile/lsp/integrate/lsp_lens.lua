local M = {}

M.setup = function(_, _)
  return {
    'VidocqH/lsp-lens.nvim',
    config = function()
      local status_ok, lsp_lens = pcall(require, 'lsp-lens')
      if not status_ok then
        return
      end

      lsp_lens.setup({})
    end,
  }
end

return M
