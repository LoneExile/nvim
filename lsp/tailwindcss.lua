return {
  cmd = { 'tailwindcss-language-server', '--stdio' },
  filetypes = {
    -- Web frameworks
    'aspnetcorerazor',
    'astro',
    'astro-markdown',
    'blade',
    'django-html',
    'htmldjango',
    'edge',
    'eelixir',
    'elixir',
    'ejs',
    'erb',
    'eruby',
    'gohtml',
    'haml',
    'handlebars',
    'hbs',
    'html',
    'html-eex',
    'heex',
    'jade',
    'leaf',
    'liquid',
    'mdx',
    'mustache',
    'njk',
    'nunjucks',
    'php',
    'razor',
    'slim',
    'twig',
    -- Styles
    'css',
    'less',
    'postcss',
    'sass',
    'scss',
    'stylus',
    'sugarss',
    -- JavaScript/TypeScript
    'javascript',
    'javascriptreact',
    'reason',
    'rescript',
    'typescript',
    'typescriptreact',
    -- Component frameworks
    'vue',
    'svelte',
    'templ',
  },
  -- NOTE: root_dir function removed for Neovim 0.10+ compatibility
  -- vim.lsp.config() cannot serialize functions
  -- Using default lspconfig root_dir pattern (looks for tailwind.config.*, postcss.config.*, package.json, etc.)
  init_options = {
    userLanguages = {
      eelixir = 'html-eex',
      eruby = 'erb',
    },
  },
  settings = {
    tailwindCSS = {
      classAttributes = { 'class', 'className', 'classList', 'ngClass' },
      lint = {
        cssConflict = 'warning',
        invalidApply = 'error',
        invalidConfigPath = 'error',
        invalidScreen = 'error',
        invalidTailwindDirective = 'error',
        invalidVariant = 'error',
        recommendedVariantOrder = 'warning',
      },
      validate = true,
      experimental = {
        classRegex = {},
      },
    },
  },
}
