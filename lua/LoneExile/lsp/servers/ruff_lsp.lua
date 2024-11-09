local M = {}

M.setup = function(lspconfig)
  lspconfig.ruff.setup({
    cmd = { 'ruff' },
    filetypes = { 'python' },
    hostInfo = 'neovim',
    single_file_support = true,
    init_options = {
      settings = {
        -- Any extra CLI arguments for `ruff` go here.
        args = {},
      },
    },
  })
end

return M
