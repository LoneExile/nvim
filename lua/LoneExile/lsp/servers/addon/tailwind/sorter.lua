local M = {}

M.setup = function()
  return {
    'laytan/tailwind-sorter.nvim',
    -- ft = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
    requires = { 'nvim-treesitter/nvim-treesitter', 'nvim-lua/plenary.nvim' },
    config = function()
      require('tailwind-sorter').setup({
        on_save_enabled = true, -- If `true`, automatically enables on save sorting.
        on_save_pattern = {
          '*.html',
          '*.js',
          '*.jsx',
          '*.tsx',
          '*.twig',
          '*.hbs',
          '*.php',
          '*.heex',
          '*.astro',
          '*.templ',
        }, -- The file patterns to watch and sort.
        node_path = 'node',
      })
    end,
    build = 'cd formatter && npm i && npm run build',
  }
end

return M
