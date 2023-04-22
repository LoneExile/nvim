local M = {}

M.enabled = false

M.setup = function(_, _)
  return {
    'VidocqH/lsp-lens.nvim',
    enabled = M.enabled,
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
