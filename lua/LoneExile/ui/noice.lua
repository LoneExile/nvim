local M = {}

M.setup = function()
  return {
    'folke/noice.nvim',
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      -- 'rcarriga/nvim-notify',
    },
    config = function()
      local status_ok, noice = pcall(require, 'noice')
      if not status_ok then
        return
      end

      vim.opt.cmdheight = 0 -- make sure we don't have a cmdline

      noice.setup({
        lsp = {
          progress = {
            -- NOTE: use fidget instead
            enabled = false,
          },

          -- use LSPsaga for hover and signature help
          signature = { enabled = false },
          hover = { enabled = false },

          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },

        mini = {
          win_options = {
            winblend = 0,
          },
        },
        notify = {
          enabled = false,
        },
      })
    end,
  }
end

return M
