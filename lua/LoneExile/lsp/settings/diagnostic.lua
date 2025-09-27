---
-- Diagnostic customization
---
local M = {}

function M.set_diagnostic(opts)
  opts = opts or {
    error = '✘',
    warn = '▲',
    hint = '⚑',
    info = '',
  }

  if vim.diagnostic.count then
    local ds = vim.diagnostic.severity
    local levels = {
      [ds.ERROR] = 'error',
      [ds.WARN] = 'warn',
      [ds.INFO] = 'info',
      [ds.HINT] = 'hint',
    }

    local text = {}

    for i, l in pairs(levels) do
      if type(opts[l]) == 'string' then
        text[i] = opts[l]
      end
    end

    vim.diagnostic.config({ signs = { text = text } })
    return
  end

  local sign = function(args)
    if opts[args.name] == nil then
      return
    end

    vim.fn.sign_define(args.hl, {
      texthl = args.hl,
      text = opts[args.name],
      numhl = '',
    })
  end

  sign({ name = 'error', hl = 'DiagnosticSignError' })
  sign({ name = 'warn', hl = 'DiagnosticSignWarn' })
  sign({ name = 'hint', hl = 'DiagnosticSignHint' })
  sign({ name = 'info', hl = 'DiagnosticSignInfo' })
end

-- See :help vim.diagnostic.config()
vim.diagnostic.config({
  virtual_text = false,
  -- virtual_lines = { only_current_line = true },
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = true,
    header = '',
    prefix = '',
  },
})

-- LSP handlers are now configured globally in init.lua

return M
