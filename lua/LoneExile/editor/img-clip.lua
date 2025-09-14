local M = {}

M.setup = function()
  return {
    'HakonHarnes/img-clip.nvim',
    cmd = { 'PasteImage' },
    opts = {
      filetypes = {
        codecompanion = {
          prompt_for_file_name = false,
          template = '[Image]($FILE_PATH)',
          use_absolute_path = true,
        },
      },
    },
  }
end

return M
