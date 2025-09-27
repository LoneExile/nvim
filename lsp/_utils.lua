-- LSP Configuration Utilities
-- Shared utilities to reduce redundancy across server configurations

local M = {}

-- Common root directory patterns for different project types
M.root_patterns = {
  -- JavaScript/TypeScript projects
  js_ts = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },

  -- Python projects
  python = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', '.git' },

  -- Go projects
  go = { '.golangci.yml', '.golangci.yaml', '.golangci.toml', '.golangci.json', 'go.work', 'go.mod', '.git' },

  -- Tailwind CSS projects
  tailwind = {
    'tailwind.config.js',
    'tailwind.config.ts',
    'tailwind.config.cjs',
    'tailwind.config.mjs',
    'tailwind.config.json',
    'postcss.config.js',
    'postcss.config.ts',
    'postcss.config.cjs',
    'postcss.config.mjs',
    'postcss.config.json',
    'package.json',
    'node_modules',
    '.git',
  },

  -- Generic git-based projects
  git = { '.git' },

  -- Configuration files
  config = { '.git' },
}

-- Create a root_dir function with common patterns
function M.root_dir(patterns)
  return function(fname)
    local lspconfig = require('lspconfig')
    return lspconfig.util.root_pattern(unpack(patterns))(fname) or lspconfig.util.path.dirname(fname)
  end
end

-- Get schema configurations if schemastore is available
function M.get_schemas(schema_type)
  return function()
    local status, schemastore = pcall(require, 'schemastore')
    if status then
      if schema_type == 'json' then
        return schemastore.json.schemas()
      elseif schema_type == 'yaml' then
        return schemastore.yaml.schemas()
      end
    end
    return {}
  end
end

return M
