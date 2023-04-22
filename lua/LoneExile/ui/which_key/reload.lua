local status_ok, whichkey = pcall(require, 'which-key')
if not status_ok then
  return
end

-- un-map and re-map which_key
local location = 'user.core.which_key.'
local split_mappings = require(location .. 'utils').split_mappings
local deregister = require(location .. 'utils').deregister
local mappings = require(location .. 'key_leader').mappings
-- local m_mappings = require(location .. 'key_m').m_mppings

local opts = require(location .. 'key_leader').opts
local vopts = require(location .. 'key_leader').vopts
-- -- local m_opts = require(location .. 'key_m').m_opts

local group = vim.api.nvim_create_augroup('whichkey', { clear = true })
local events = { 'BufEnter', 'BufWinEnter', 'CursorMoved' }

vim.api.nvim_create_autocmd(events, {
  pattern = { '*' },
  callback = function()
    local fileType = vim.api.nvim_buf_get_option(0, 'filetype')
    if fileType ~= '' then
      local nmappings, vmappings, ignore_nmappings, ignore_vmappings = split_mappings(mappings, fileType)
      deregister(ignore_nmappings, '<leader>', 'n', whichkey)
      deregister(ignore_vmappings, '<leader>', 'v', whichkey)
      whichkey.register(nmappings, opts)
      whichkey.register(vmappings, vopts)
      -- whichkey.register(m_mappings, m_opts)
    end
  end,
  group = group,
})
