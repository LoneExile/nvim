local M = {}
M.setup = function(root)
  return {
    mappings = {
      ['w'] = {
        '<cmd>SaveNFormat<CR>',
        'Save',
        mode = { 'n' },
        ft = { only = {}, exclude = { 'alpha', 'neo-tree' } },
      },
      ['q'] = {
        "<cmd>lua require('" .. root .. ".utils.quit').smart_quit()<CR>",
        'Quit',
        mode = { 'n' },
      },
      ['k'] = {
        "<cmd>lua require('" .. root .. ".utils.bufKill').buf_kill()<CR>",
        'Kill Buffer',
        mode = { 'n' },
      },
      ['H'] = {
        -- '<cmd>nohlsearch<CR>',
        function()
          vim.cmd('nohlsearch')
          local status, hl_search = pcall(require, root .. '.utils.hl_search')
          if status then
            hl_search.clear_search_count()
          end
        end,
        'No Highlight',
        mode = { 'n' },
      },
      p = {
        name = 'Plugin',
        c = { '<cmd>Lazy clean<cr>', 'Clean', mode = { 'n' } },
        s = { '<cmd>Lazy sync<cr>', 'Sync', mode = { 'n' } },
        u = { '<cmd>Lazy update<cr>', 'Update', mode = { 'n' } },
        l = { '<cmd>Lazy<cr>', 'Lazy', mode = { 'n' } },
        L = { '<cmd>Lazy log<cr>', 'Log', mode = { 'n' } },
        r = { '<cmd>Lazy restore<cr>', 'Restore', mode = { 'n' } },
      },
      N = {
        name = 'Neovim',
        h = { '<cmd>checkhealth<cr>', 'Check Health', mode = { 'n' } },
      },
      u = {
        name = '+Utility',
        d = {
          name = 'Diff Buf',
          a = { '<cmd>windo diffthis<cr>', 'Diff All', mode = { 'n' } },
          c = { '<cmd>diffoff!<cr>', 'Diff Off', mode = { 'n' } },
          t = { '<cmd>diffthis<cr>', 'Diff This', mode = { 'n' } },
        },
      },
    },
    m_mappings = {},
    g_mappings = {},
  }
end
return M
