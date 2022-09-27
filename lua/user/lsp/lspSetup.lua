M = {}

local severs = {
  'sumneko',
  'pyright',
  'jsonls',
  'vuels',
  -- 'volar',
}

M.severs = function(lsp)
  for _, server in ipairs(severs) do
    local status_ok, config = pcall(require, 'user.lsp.settings.' .. server)
    if status_ok then
      config.setup(lsp)
    else
      vim.notify('LSP ' .. server .. ' not found!')
    end
  end
end

return M
