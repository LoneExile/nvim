local M = {
  config_location = vim.fn.stdpath('config') .. '/lua/user',
  tranparent = true,
  theme = 'tokyonight-storm',
  env_file = function()
    local env = vim.fn.stdpath('config') .. '/.env.lua'

    -- if you don't export the env in your shell, it will generate file .env.lua in your config folder
    if vim.fn.filereadable(env) == 0 and vim.env.OPENAI_API_KEY == nil then
      local value =
        '-- https://beta.openai.com/account/api-keys\n vim.cmd(\'let $OPENAI_API_KEY="<PUT-YOUR-KEY-HERE>"\')'
      io.open(env, 'w'):write(value)
      io.open(env, 'w'):close()
    end

    if vim.fn.filereadable(env) == 1 then
      dofile(env)
    end
  end,
  colors = {
    -- fg = '#bbc2cf',
    -- red = '#e95678',
    -- orange = '#FF8700',
    -- yellow = '#f7bb3b',
    -- green = '#afd700',
    -- cyan = '#36d0e0',
    -- blue = '#61afef',
    -- violet = '#CBA6F7',
    teal = '#1abc9c',
    nobg = nil,
    darkgray = '#16161d',
    gray = '#727169',
    outerbg = '#16161D',
    normal = '#7e9cd8',
    insert = '#98bb6c',
    visual = '#ffa066',
    replace = '#e46876',
    command = '#e6c384',
    red = '#ca1243',
    grey = '#a0a1a7',
    black = '#383a42',
    white = '#f3f3f3',
    light_green = '#83a598',
    orange = '#fe8019',
    green = '#8ec07c',
    bg = '#202328',
    fg = '#bbc2cf',
    yellow = '#ECBE7B',
    cyan = '#008080',
    darkblue = '#081633',
    violet = '#a9a1e1',
    magenta = '#c678dd',
    blue = '#87b0f9',
    mauve = '#cba6f7',
    peach = '#fab387',
    purple = '#c678dd',
    buleish = '#265270',
  },
  kindIcon = function(self)
    return {
      [1] = { 'File', ' ', self.colors.fg },
      [2] = { 'Module', ' ', self.colors.blue },
      [3] = { 'Namespace', ' ', self.colors.orange },
      [4] = { 'Package', ' ', self.colors.violet },
      [5] = { 'Class', ' ', self.colors.violet },
      [6] = { 'Method', ' ', self.colors.violet },
      [7] = { 'Property', ' ', self.colors.cyan },
      [8] = { 'Field', ' ', self.colors.teal },
      [9] = { 'Constructor', ' ', self.colors.blue },
      [10] = { 'Enum', '了', self.colors.green },
      [11] = { 'Interface', ' ', self.colors.orange },
      [12] = { 'Function', ' ', self.colors.violet },
      [13] = { 'Variable', ' ', self.colors.blue },
      [14] = { 'Constant', ' ', self.colors.cyan },
      [15] = { 'String', ' ', self.colors.green },
      [16] = { 'Number', ' ', self.colors.green },
      [17] = { 'Boolean', ' ', self.colors.orange },
      [18] = { 'Array', ' ', self.colors.blue },
      [19] = { 'Object', ' ', self.colors.orange },
      [20] = { 'Key', ' ', self.colors.red },
      [21] = { 'Null', ' ', self.colors.red },
      [22] = { 'EnumMember', ' ', self.colors.green },
      [23] = { 'Struct', ' ', self.colors.violet },
      [24] = { 'Event', ' ', self.colors.violet },
      [25] = { 'Operator', ' ', self.colors.green },
      [26] = { 'TypeParameter', ' ', self.colors.green },
      -- ccls
      [252] = { 'TypeAlias', ' ', self.colors.green },
      [253] = { 'Parameter', ' ', self.colors.blue },
      [254] = { 'StaticMethod', 'ﴂ ', self.colors.orange },
      [255] = { 'Macro', ' ', self.colors.red },
    }
  end,
  kind_icons = {
    ['cmp-tw2css'] = '',
    Copilot = ' ',
    Class = ' ',
    Color = ' ',
    Constant = 'ﲀ ',
    Constructor = ' ',
    Enum = '練',
    EnumMember = ' ',
    Event = ' ',
    Field = ' ',
    File = '',
    Folder = ' ',
    Function = ' ',
    Interface = 'ﰮ ',
    Keyword = ' ',
    Method = ' ',
    Module = ' ',
    Operator = '',
    Property = ' ',
    Reference = ' ',
    Snippet = ' ',
    Struct = ' ',
    Text = ' ',
    TypeParameter = ' ',
    Unit = '塞',
    Value = ' ',
    Variable = ' ',
  },
  wh_mappings = {
    mappings = {
      ['e'] = {
        '<cmd>Neotree action=focus source=filesystem position=right toggle=true<CR>',
        'Explorer',
        mode = { 'n' },
      },
      [';'] = {
        '<cmd>Alpha<CR>',
        'Dashboard',
        mode = { 'n' },
      },
      ['w'] = {
        '<cmd>SaveNFormat<CR>',
        'Save',
        mode = { 'n' },
        ft = { only = {}, exclude = { 'alpha', 'neo-tree' } },
      },
      ['q'] = {
        "<cmd>lua require('user.utils.quit').smart_quit()<CR>",
        'Quit',
        mode = { 'n' },
      },
      ['/'] = {
        cmd = {
          n = "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>",
          v = '<Plug>(comment_toggle_linewise_visual)',
        },
        'Comment',
        mode = { 'n', 'v' },
        ft = { only = {}, exclude = { 'alpha', 'neo-tree' } },
      },

      ['c'] = {
        "<cmd>lua require('user.utils.bufKill').buf_kill()<CR>",
        'Close Buffer',
        mode = { 'n' },
      },
      ['H'] = {
        '<cmd>nohlsearch<CR>',
        'No Highlight',
        mode = { 'n' },
      },
    },
    m_mappings = {},
  },
}

return M
