local M = {}

M.setup = function()
  return {
    'windwp/nvim-ts-autotag',
    event = 'BufRead',
    config = function()
      local status_ok, autotag = pcall(require, 'nvim-ts-autotag')
      if not status_ok then
        return
      end

      -- Before        Input         After
      -- ------------------------------------
      -- <div           >              <div></div>
      -- <div></div>    ciwspan<esc>   <span></span>
      -- ------------------------------------
      --
      -- 2024 rewrite removed nvim-treesitter dependency and the top-level
      -- `filetypes` / `skip_tags` keys. Supported filetypes are now derived
      -- from the available TS parser, and void-element handling is built-in.
      -- See: github.com/windwp/nvim-ts-autotag (post-rewrite README).

      autotag.setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false,
        },
      })
    end,
  }
end

return M
