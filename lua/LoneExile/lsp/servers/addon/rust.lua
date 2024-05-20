local M = {}

M.setup = function()
  return {
    'simrat39/rust-tools.nvim',
    ft = { 'rust' },
    dependencies = {
      {
        'saecki/crates.nvim',
        event = { 'BufRead Cargo.toml' },
        -- tag = 'v0.3.0',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
          require('crates').setup({})
        end,
      },
    },
    config = function()
      local status, rt = pcall(require, 'rust-tools')
      if not status then
        return
      end

      local _, rt_e = pcall(require, 'rust-tools/executors')

      rt.setup({
        tools = {
          executor = rt_e.termopen,
          reload_workspace_from_cargo_toml = true,
          runnables = {
            use_telescope = true,
          },
          inlay_hints = {
            auto = true,
            only_current_line = false,
            show_parameter_hints = true,
            parameter_hints_prefix = '<-',
            other_hints_prefix = '=>',
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = 'Comment',
          },
          hover_actions = {
            border = 'rounded',
          },
          on_initialized = function()
            vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufEnter', 'CursorHold', 'InsertLeave' }, {
              pattern = { '*.rs' },
              callback = function()
                local _, _ = pcall(vim.lsp.codelens.refresh)
              end,
            })
          end,
        },
      })
    end,
  }
end

return M
