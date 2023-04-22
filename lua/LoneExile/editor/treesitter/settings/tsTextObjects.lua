local config = {
  select = {
    enable = true,
    -- Automatically jump forward to textobj, similar to targets.vim
    lookahead = true,
    keymaps = {
      -- You can use the capture groups defined in textobjects.scm
      ['af'] = '@function.outer',
      ['if'] = '@function.inner',
      ['ac'] = '@class.outer',
      ['ic'] = '@class.inner',
      ['aa'] = '@parameter.outer',
      ['ia'] = '@parameter.inner',
      ['ab'] = '@block.outer',
      ['ib'] = '@block.inner',
      ['al'] = '@loop.outer',
      ['il'] = '@loop.inner',
      ['is'] = '@statement.inner',
      ['as'] = '@statement.outer',
      ['ad'] = '@comment.outer',
      ['am'] = '@call.outer',
      ['im'] = '@call.inner',
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = { ['<leader>xp'] = '@parameter.inner' },
      swap_previous = { ['<leader>xP'] = '@parameter.inner' },
    },
  },
}

return config
