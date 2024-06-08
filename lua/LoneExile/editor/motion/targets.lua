local M = {}

M.setup = function()
  return {
    'echasnovski/mini.ai',
    event = 'BufRead',
    config = function()
      local status_ok_code, mini = pcall(require, 'mini.ai')
      if not status_ok_code then
        return
      end
      local spec_treesitter = require('mini.ai').gen_spec.treesitter
      local gen_spec = require('mini.ai').gen_spec

      mini.setup({
        custom_textobjects = {
          o = spec_treesitter({
            a = { '@conditional.outer', '@loop.outer' },
            i = { '@conditional.inner', '@loop.inner' },
          }),

          -- Tweak function call to not detect dot in function name
          F = gen_spec.function_call({ name_pattern = '[%w_]' }),

          -- Function definition (needs treesitter queries with these captures)
          f = gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),

          -- Make `|` select both edges in non-balanced way
          ['|'] = gen_spec.pair('|', '|', { type = 'non-balanced' }),
        },
      })
    end,
  }
end

return M
