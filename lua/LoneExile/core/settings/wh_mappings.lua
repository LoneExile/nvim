local M = {}
M.setup = function(root)
  return {
    {
      '<leader>?',
      function()
        local status, wk = pcall(require, 'which-key')
        if not status then
          return
        end
        wk.show({ global = false })
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
    {
      '<leader>w',
      '<cmd>SaveNFormat<CR>',
      desc = 'Save',
      mode = 'n',
    },
    {
      '<leader>q',
      "<cmd>lua require('" .. root .. ".utils.quit').smart_quit()<CR>",
      desc = 'Quit',
      mode = 'n',
    },
    {
      '<leader>k',
      "<cmd>lua require('" .. root .. ".utils.bufKill').buf_kill()<CR>",
      desc = 'Kill Buffer',
      mode = 'n',
    },
    {
      '<leader>H',
      -- "<cmd>lua require('" .. root .. ".utils.hl_search').clear_search_count()<CR>",
      function()
        vim.cmd('nohlsearch')
        local status, hl_search = pcall(require, root .. '.utils.hl_search')
        if status then
          hl_search.clear_search_count()
        end
      end,
      desc = 'No Highlight',
      mode = 'n',
    },
    {
      '<leader>p',
      function()
        local status, wk = pcall(require, 'which-key')
        if not status then
          return
        end
        wk.show({ global = false })
      end,
      desc = 'Plugin',
      mode = 'n',
    },
    {
      '<leader>pc',
      '<cmd>Lazy clean<cr>',
      desc = 'Clean',
      mode = 'n',
    },
    {
      '<leader>ps',
      '<cmd>Lazy sync<cr>',
      desc = 'Sync',
      mode = 'n',
    },
    {
      '<leader>pu',
      '<cmd>Lazy update<cr>',
      desc = 'Update',
      mode = 'n',
    },
    {
      '<leader>pl',
      '<cmd>Lazy<cr>',
      desc = 'Lazy',
      mode = 'n',
    },
    {
      '<leader>pL',
      '<cmd>Lazy log<cr>',
      desc = 'Log',
      mode = 'n',
    },
    {
      '<leader>pr',
      '<cmd>Lazy restore<cr>',
      desc = 'Restore',
      mode = 'n',
    },
    {
      '<leader>N',
      function()
        local status, wk = pcall(require, 'which-key')
        if not status then
          return
        end
        wk.show({ global = false })
      end,
      desc = 'Neovim',
      mode = 'n',
    },
    {
      '<leader>Nh',
      '<cmd>checkhealth<cr>',
      desc = 'Check Health',
      mode = 'n',
    },
    {
      '<leader>u',
      function()
        local status, wk = pcall(require, 'which-key')
        if not status then
          return
        end
        wk.show({ global = false })
      end,
      desc = '+Utility',
      mode = 'n',
    },
    {
      '<leader>ud',
      desc = 'Diff Buf',
      mode = 'n',
    },
    {
      '<leader>uda',
      '<cmd>windo diffthis<cr>',
      desc = 'Diff All',
      mode = 'n',
    },
    {
      '<leader>udc',
      '<cmd>diffoff!<cr>',
      desc = 'Diff Off',
      mode = 'n',
    },
    {
      '<leader>udt',
      '<cmd>diffthis<cr>',
      desc = 'Diff This',
      mode = 'n',
    },
    {
      '<leader>;',
      '<cmd>Alpha<CR>',
      desc = 'Dashboard',
      mode = 'n',
    },
  }
end
return M
