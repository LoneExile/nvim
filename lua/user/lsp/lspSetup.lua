local status_ok_ui, lsp = pcall(require, 'lsp-zero')
if not status_ok_ui then
  print('LSP Zero not found')
  return
end

local status_ok, lua_dev = pcall(require, 'lua-dev')
if not status_ok then
  print('lua-dev not found')
  return
end

local luadev = lua_dev.setup({
  library = {
    enabled = true,
    runtime = true,
    types = true,
    plugins = true,
  },
  setup_jsonls = true,
  override = function(root_dir, library)
    if require('lua-dev.util').has_file(root_dir, '/etc/nixos') then
      library.enabled = true
      library.plugins = true
    end
  end,
})
lsp.configure('sumneko_lua', luadev)

lsp.configure('pyright', {
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        typeCheckingMode = 'off',
      },
    },
  },
})

lsp.configure('jsonls', {
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
      },
    },
  },
})

-- require("lspconfig").sqls.setup({
-- 	settings = {
-- 		sqls = {
-- 			connections = {
-- 				{
-- 					driver = "postgresql",
-- 					dataSourceName = "host=127.0.0.1 port=5432 user=postgres password='' dbname='' sslmode=disable",
-- 				},
-- 			},
-- 		},
-- 	},
-- })
