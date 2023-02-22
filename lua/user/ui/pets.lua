local M = {}
M.enabled = true

M.wh_key = {
  enabled = M.enabled,
  wh_mappings = {
    ['u'] = {
      name = '+Utility',
      p = {
        name = 'PETS',
        p = {
          '<cmd>PetsNewCustom cat black per<cr>',
          'Per',
          mode = { 'n', 'v' },
        },
        n = {
          '<cmd>PetsNewCustom cat red noom<cr>',
          'Noom',
          mode = { 'n', 'v' },
        },
        k = {
          '<cmd>PetsKillAll<cr>',
          'Kill All',
          mode = { 'n', 'v' },
        },
      },
    },
  },
}

M.setup = function()
  return {
    'giusgad/pets.nvim',
    enabled = M.enabled,
    dependencies = { 'MunifTanjim/nui.nvim', 'edluffy/hologram.nvim' },
    config = function()
      local status_ok, pets = pcall(require, 'pets')
      if not status_ok then
        return
      end
      pets.setup()
      vim.cmd([[ PetsNewCustom cat black per ]])
      vim.cmd([[ PetsNewCustom cat red noom ]])
    end,
  }
end

return M
