local M = {}

M.setup = function(s, loc)
  local conditions = require(loc .. '.conditions')
  local colors = s.colors

  local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
      return {
        added = gitsigns.added,
        modified = gitsigns.changed,
        removed = gitsigns.removed,
      }
    end
  end

  local function env_cleanup(venv)
    if string.find(venv, '/') then
      local final_venv = venv
      for w in venv:gmatch('([^/]+)') do
        final_venv = w
      end
      venv = final_venv
    end
    return venv
  end

  ----------------------------------------------------------------------------

  -- for lsp component add null-ls
  -- WARN: this may be slow

  local list_registered = function(filetype, buf_client_names)
    if s.utils.is_plugin_loaded(s.data_loc, 'null-ls.nvim') then
      local status_ok, null_ls = pcall(require, 'null-ls')
      if not status_ok then
        return
      end
      local registered_formatters = {}
      local sources = require('null-ls.sources')
      local available_sources = sources.get_available(filetype)
      local registered_providers = {}
      for _, source in ipairs(available_sources) do
        for method in pairs(source.methods) do
          registered_providers[method] = registered_providers[method] or {}
          table.insert(registered_providers[method], source.name)
        end
      end

      local method_formatting = null_ls.methods.FORMATTING
      local method_diagnostics = null_ls.methods.DIAGNOSTICS
      registered_formatters[method_formatting] = registered_providers[method_formatting] or {}
      registered_formatters[method_diagnostics] = registered_providers[method_diagnostics] or {}

      for _, provider in pairs(registered_formatters[method_formatting]) do
        table.insert(buf_client_names, provider)
      end
      for _, provider in pairs(registered_formatters[method_diagnostics]) do
        table.insert(buf_client_names, provider)
      end
    end
    return buf_client_names
  end

  -----------------------------------------------------------------------------------------

  return {
    mode = {
      function()
        return ' '
      end,
      padding = { left = 0, right = 0 },
      color = {},
      cond = nil,
    },
    branch = {
      'b:gitsigns_head',
      icon = ' ',
      color = { fg = colors.violet, gui = 'bold' },
      cond = conditions.hide_in_width,
    },
    filename = {
      'filename',
      file_status = true, -- Displays file status (readonly status, modified status)
      newfile_status = false, -- Display new file status (new file means no write after created)
      path = 1, -- 0: Just the filename
      --                          -- 1: Relative path
      --                          -- 2: Absolute path
      --                          -- 3: Absolute path, with tilde as the home directory
      --
      shorting_target = 40, -- Shortens path to leave 40 spaces in the window
      --                          -- for other components. (terrible name, any suggestions?)
      symbols = {
        modified = '[+]', -- Text to show when the file is modified.
        readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
        unnamed = '[No Name]', -- Text to show for unnamed buffers.
        newfile = '[New]', -- Text to show for new created file before first writting
      },
    },
    diff = {
      'diff',
      source = diff_source,
      symbols = { added = '  ', modified = ' ', removed = ' ' },
      diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.yellow },
        removed = { fg = colors.red },
      },
      cond = nil,
    },
    lsp = {
      function(msg)
        msg = msg or 'LS Inactive'
        local buf_clients = vim.lsp.get_active_clients()
        if next(buf_clients) == nil then
          if type(msg) == 'boolean' or #msg == 0 then
            return 'LS Inactive'
          end
          return msg
        end
        local buf_ft = vim.bo.filetype
        local buf_client_names = {}

        for _, client in pairs(buf_clients) do
          if client.name ~= 'null-ls' then
            table.insert(buf_client_names, client.name)
          end
        end

        -- buf_client_names = list_registered(buf_ft, buf_client_names) or {}
        -- for i, name in ipairs(buf_client_names) do
        --   if name == 'copilot' then
        --     table.remove(buf_client_names, i)
        --     break
        --   end
        -- end

        local unique_client_names = vim.fn.uniq(buf_client_names)
        local copilot_icon = ' ' --s.utils.convert_kind_icons(s.kindIcon).Copilot
        msg = copilot_icon .. '[' .. table.concat(unique_client_names, ', ') .. ']'
        return msg
      end,
      color = { fg = colors.teal, gui = 'bold' },
      cond = conditions.hide_in_width,
    },
    python_env = {
      function()
        local utils = env_cleanup
        if vim.bo.filetype == 'python' then
          local venv = os.getenv('CONDA_DEFAULT_ENV') or os.getenv('VIRTUAL_ENV')
          if venv then
            return string.format('  (%s)', utils.env_cleanup(venv))
          end
        end
        return ''
      end,
      color = { fg = colors.green },
      cond = conditions.hide_in_width,
    },
    diagnostics = {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      -- symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
      symbols = { error = '✘ ', warn = '▲ ', info = '⚑ ', hint = ' ' },
      cond = conditions.hide_in_width,
    },
    treesitter = {
      function()
        return ''
      end,
      color = function()
        local buf = vim.api.nvim_get_current_buf()
        local ts = vim.treesitter.highlighter.active[buf]
        return { fg = ts and not vim.tbl_isempty(ts) and colors.green or colors.red }
      end,
      cond = conditions.hide_in_width,
    },
    location = { 'location', cond = conditions.hide_in_width, color = {} },
    progress = { 'progress', cond = conditions.hide_in_width, color = {} },
    spaces = {
      function()
        if not vim.api.nvim_buf_get_option(0, 'expandtab') then
          return 'Tab size: ' .. vim.api.nvim_buf_get_option(0, 'tabstop') .. ' '
        end
        local size = vim.api.nvim_buf_get_option(0, 'shiftwidth')
        if size == 0 then
          size = vim.api.nvim_buf_get_option(0, 'tabstop')
        end
        return 'Spaces: ' .. size .. ' '
      end,
      cond = conditions.hide_in_width,
      color = {},
    },
    encoding = {
      'o:encoding',
      fmt = string.upper,
      color = {},
      cond = conditions.hide_in_width,
    },
    filetype = { 'filetype', cond = conditions.hide_in_width },
    scrollbar = {
      function()
        local current_line = vim.fn.line('.')
        local total_lines = vim.fn.line('$')
        local chars = { '__', '▁▁', '▂▂', '▃▃', '▄▄', '▅▅', '▆▆', '▇▇', '██' }
        local line_ratio = current_line / total_lines
        local index = math.ceil(line_ratio * #chars)
        return chars[index]
      end,
      padding = { left = 0, right = 0 },
      color = { fg = colors.yellow, bg = colors.bg },
      cond = nil,
    },
  }
end

return M
