local M = {}

-- rustaceanvim is the maintained successor to simrat39/rust-tools.nvim.
-- It manages rust-analyzer itself via vim.lsp.start, so we EXCLUDE
-- `rust_analyzer` from mason-lspconfig's automatic_enable in lsp/init.lua
-- to prevent a double LSP attach.

M.setup = function()
  return {
    'mrcjkb/rustaceanvim',
    version = '^7', -- pin major; rustaceanvim follows semver
    ft = { 'rust' },
    dependencies = {
      {
        'saecki/crates.nvim',
        event = { 'BufRead Cargo.toml' },
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
          require('crates').setup({})
        end,
      },
    },
    config = function()
      vim.g.rustaceanvim = {
        tools = {
          hover_actions = {
            replace_builtin_hover = true,
          },
          float_win_config = {
            border = 'rounded',
          },
        },
        server = {
          on_attach = function(_, bufnr)
            -- Inlay hints (replaces rust-tools' tools.inlay_hints)
            if vim.lsp.inlay_hint then
              vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            end
            -- Codelens auto-refresh (was rust-tools' on_initialized)
            vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufEnter', 'CursorHold', 'InsertLeave' }, {
              buffer = bufnr,
              callback = function()
                pcall(vim.lsp.codelens.refresh)
              end,
            })
          end,
          default_settings = {
            ['rust-analyzer'] = {
              lens = { enable = true },
              checkOnSave = {
                enable = true,
                command = 'clippy',
              },
              inlayHints = {
                bindingModeHints = { enable = false },
                chainingHints = { enable = true },
                closingBraceHints = { enable = true, minLines = 25 },
                closureReturnTypeHints = { enable = 'never' },
                lifetimeElisionHints = { enable = 'never', useParameterNames = false },
                maxLength = 25,
                parameterHints = { enable = true },
                reborrowHints = { enable = 'never' },
                renderColons = true,
                typeHints = { enable = true, hideClosureInitialization = false, hideNamedConstructor = false },
              },
            },
          },
        },
      }
    end,
  }
end

return M
