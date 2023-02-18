local M = {}

M.setup = function()
  return {
    'giusgad/pets.nvim',
    dependencies = { 'MunifTanjim/nui.nvim', 'edluffy/hologram.nvim' },
    config = function()
      local status_ok, pets = pcall(require, 'pets')
      if not status_ok then
        return
      end
      pets.setup({})
    end,
  }
end

return M
