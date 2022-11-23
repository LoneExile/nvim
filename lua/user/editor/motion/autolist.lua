local status, autolist = pcall(require, 'autolist')

if not status then
  return
end

local default_config = {
  enabled = true,
  list_cap = 50,
  colon = {
    indent_raw = true,
    indent = true,
    preferred = '-',
  },
  invert = {
    indent = false,
    toggles_checkbox = true,
    ul_marker = '-',
    ol_incrementable = '1',
    ol_delim = '.',
  },
  lists = {
    preloaded = {
      generic = {
        'unordered',
        'digit',
        'ascii',
      },
      latex = {
        'latex_item',
      },
    },
    filetypes = {
      generic = {
        'markdown',
        'text',
      },
      latex = {
        'tex',
        'plaintex',
      },
    },
  },
  recal_function_hooks = {
    'invert',
    'new',
  },
  checkbox = {
    left = '%[',
    right = '%]',
    fill = 'x',
  },
  insert_mappings = {
    invert = { '<c-r>+[catch]' },
    new = { '<CR>' },
    tab = { '<c-t>' },
    detab = { '<c-d>' },
    recal = { '<c-z>' },
    indent = {
      "<tab>+[catch]('>>')",
      "<s-tab>+[catch]('<<')",
    },
  },
  normal_mappings = {
    new = {
      'o',
      'O+(true)',
    },
    recal = {
      'dd',
      'p',
    },
    tab = { '>>' },
    detab = { '<<' },
  },
}

autolist.setup(default_config)
