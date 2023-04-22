local M = {}
M.enabled = false

M.wh_key = {
  enabled = M.enabled,
  wh_mappings = {
    ['u'] = {
      name = '+Utility',
      p = {
        name = 'PETS',
        p = {
          function()
            vim.cmd([[PetsKillAll]])
            -- gray beige
            vim.cmd([[ PetsNewCustom dog gray per ]])
            vim.cmd([[  PetsNewCustom dog brown noom ]])
          end,
          'Play',
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
    dependencies = {
      'MunifTanjim/nui.nvim',
      'edluffy/hologram.nvim',
    },
    config = function()
      local status_ok, pets = pcall(require, 'pets')
      if not status_ok then
        return
      end
      pets.setup()
      vim.cmd([[PetsKillAll]])
      vim.cmd([[ PetsNewCustom dog gray per ]])
      vim.cmd([[ PetsNewCustom dog brown noom ]])
    end,
  }
end

return M
