local M = {}

-- FluxMarkdown: macOS Finder QuickLook / standalone Markdown viewer app.
-- https://github.com/xykong/flux-markdown  (brew install --cask xykong/tap/flux-markdown)
-- Not a Neovim plugin -> no lazy spec. setup() runs at config build time, so
-- register the keymap directly and return nil (nothing added to lazy.nvim).
M.setup = function()
  vim.keymap.set('n', '<leader>ums', function()
    local file = vim.fn.expand('%:p')
    if file == '' then
      vim.notify('FluxMarkdown: current buffer has no file', vim.log.levels.WARN)
      return
    end

    if vim.bo.modified then
      vim.cmd('write')
    end

    -- macOS has no `FluxMarkdown` on PATH; `open -a` launches the app with the file.
    vim.system({ 'open', '-a', 'FluxMarkdown', file }, { text = true }, function(out)
      if out.code ~= 0 then
        vim.schedule(function()
          vim.notify('FluxMarkdown failed: ' .. (out.stderr or ('exit ' .. out.code)), vim.log.levels.ERROR)
        end)
      end
    end)
  end, { desc = 'Markdown Preview (FluxMarkdown)' })

  return nil
end

return M
