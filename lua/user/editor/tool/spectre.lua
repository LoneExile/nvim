local M = {}

M.setup = function()
  return {
    'windwp/nvim-spectre',
    lazy = true,
    config = function()
      local status_ok_code, spectre = pcall(require, 'spectre')
      if not status_ok_code then
        return
      end

      local config = {
        color_devicons = true,
        open_cmd = 'vnew',
        live_update = false, -- auto execute search again when you write any file in vim
        is_insert_mode = false, -- start open panel on is_insert_mode
      }

      spectre.setup(config)
    end,
  }
end

return M
