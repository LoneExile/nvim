local M = {}

M.setup = function(lspconfig)
  lspconfig.jsonls.setup({
    settings = {
      json = {
        schemas = {
          {
            fileMatch = { 'package.json' },
            url = 'https://json.schemastore.org/package.json',
          },
          {
            fileMatch = { 'tsconfig.json', 'tsconfig.*.json' },
            url = 'https://json.schemastore.org/tsconfig.json',
          },
          {
            fileMatch = { '.prettierrc', '.prettierrc.json', 'prettier.config.json' },
            url = 'https://json.schemastore.org/prettierrc.json',
          },
          {
            fileMatch = { '.eslintrc', '.eslintrc.json' },
            url = 'https://json.schemastore.org/eslintrc.json',
          },
          {
            fileMatch = { '.babelrc', '.babelrc.json', 'babel.config.json' },
            url = 'https://json.schemastore.org/babelrc.json',
          },
          {
            fileMatch = { 'lerna.json' },
            url = 'https://json.schemastore.org/lerna.json',
          },
          {
            fileMatch = { 'now.json', 'vercel.json' },
            url = 'https://json.schemastore.org/now.json',
          },
          {
            fileMatch = { '.stylelintrc', '.stylelintrc.json', 'stylelint.config.json' },
            url = 'https://json.schemastore.org/stylelintrc.json',
          },
          {
            fileMatch = { 'tailwind.config.json' },
            url = 'https://json.schemastore.org/tailwind-config.json',
          },
          {
            fileMatch = { 'netlify.toml' },
            url = 'https://json.schemastore.org/netlify.json',
          },
          ---------------------------------------------------------------------------
          {
            fileMatch = { '.code-snippets' },
            url = 'https://json.schemastore.org/vscode-snippets.json',
          },
          {
            fileMatch = { 'now.json', 'vercel.json' },
            url = 'https://json.schemastore.org/now.json',
          },
          {
            fileMatch = { 'workspace.code-snippets' },
            url = 'https://json.schemastore.org/vscode-workspace-snippets.json',
          },
          {
            fileMatch = { 'composer.lock' },
            url = 'https://getcomposer.org/schema.json',
          },
          {
            fileMatch = { 'composer.json' },
            url = 'https://getcomposer.org/schema.json',
          },
          {
            fileMatch = { 'composer.json' },
            url = 'https://json.schemastore.org/composer.json',
          },
          {
            fileMatch = { 'composer.lock' },
            url = 'https://json.schemastore.org/composer.lock',
          },
          {
            fileMatch = { 'composer.json' },
            url = 'https://json.schemastore.org/composer.schema.json',
          },
          {
            fileMatch = { 'composer.lock' },
            url = 'https://json.schemastore.org/composer.lock.schema.json',
          },
          {
            fileMatch = { 'composer.json' },
            url = 'https://json.schemastore.org/composer.schema.json',
          },
          {
            fileMatch = { 'composer.lock' },
            url = 'https://json.schemastore.org/composer.lock.schema.json',
          },
          {
            fileMatch = { 'composer.json' },
            url = 'https://json.schemastore.org/composer.schema.json',
          },
          {
            fileMatch = { 'composer.lock' },
            url = 'https://json.schemastore.org/composer.lock.schema.json',
          },
          {
            fileMatch = { 'composer.json' },
            url = 'https://json.schemastore.org/composer.schema.json',
          },
          {
            fileMatch = { 'composer.lock' },
            url = 'https://json.schemastore.org/composer.lock.schema.json',
          },
          {
            fileMatch = { 'composer.json' },
            url = 'https://json.schemastore.org/composer.schema.json',
          },
        },
      },
    },
  })
end

return M
