# LSP Configuration Directory

This directory contains server-specific configurations for the Neovim 0.10+ core LSP system.

## Architecture

The LSP configuration uses the Neovim 0.11+ core LSP approach:

- **Global Configuration**: Set via `vim.lsp.config('*', {...})` in `lua/LoneExile/lsp/init.lua` (capabilities + on_attach).
- **Server Activation**: `mason-lspconfig.nvim` v2 with `automatic_enable = true` calls `vim.lsp.enable()` for every installed server. The manual `servers = {...}` list and explicit `vim.lsp.enable()` calls have been removed.
- **Server-Specific Config**: Individual files in this directory that return configuration tables. Files are auto-discovered from the runtime path by `vim.lsp.enable()`.

The `require('lspconfig')` framework call has been removed. Neovim 0.11+ resolves `lsp/<name>.lua` files via the runtime path automatically; lspconfig v3 will drop the framework entirely and only ship server data files.

## File Structure

```
lsp/
├── README.md                       # This documentation
├── lua_ls.lua                      # Lua
├── gopls.lua                       # Go
├── ts_ls.lua                       # TypeScript (legacy; vtsls is preferred)
├── vtsls.lua                       # TypeScript wrapper (registers @vue/typescript-plugin for Vue)
├── vue_ls.lua                      # Vue Language Tools (Volar)
├── emmet_language_server.lua       # Emmet (olrtg/emmet-language-server)
├── pyright.lua                     # Python
├── jsonls.lua                      # JSON
├── yamlls.lua                      # YAML
└── [other servers].lua             # Additional server configurations
```

## Configuration Format

Each server configuration file should return a table with server-specific settings:

```lua
-- Example: lsp/example_server.lua
return {
  cmd = { 'example-language-server', '--stdio' },
  filetypes = { 'example' },
  root_dir = function(fname)
    local lspconfig = require('lspconfig')
    return lspconfig.util.root_pattern('.git')(fname) or lspconfig.util.path.dirname(fname)
  end,
  settings = {
    example = {
      -- Server-specific settings
    },
  },
}
```

## Common Patterns

### Root Directory Functions

Most servers need a root_dir function. Common patterns:

```lua
-- Git-based projects
root_dir = function(fname)
  local lspconfig = require('lspconfig')
  return lspconfig.util.root_pattern('.git')(fname) or lspconfig.util.path.dirname(fname)
end

-- JavaScript/TypeScript projects
root_dir = function(fname)
  local lspconfig = require('lspconfig')
  return lspconfig.util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git')(fname) 
    or lspconfig.util.path.dirname(fname)
end
```

### Schema Integration

For JSON/YAML servers with schemastore integration:
```lua
schemas = function()
  local status, schemastore = pcall(require, 'schemastore')
  if status then
    return schemastore.json.schemas() -- or schemastore.yaml.schemas()
  end
  return {}
end
```

## Adding New Servers

1. Create a new file `lsp/<server_name>.lua` returning the config table.
2. If the server is on Mason: add the Mason package name to `ensure_installed` in `lua/LoneExile/lsp/integrate/mason_tool_installer.lua`. mason-lspconfig (`automatic_enable = true`) will call `vim.lsp.enable('<server_name>')` automatically.
3. If the server is NOT on Mason: install the binary yourself and call `vim.lsp.enable('<server_name>')` from a setup hook.
4. Use common patterns for root_dir and schema functions when applicable.

## Migration from Old System

This configuration replaces the previous approach:

**Old (deprecated):**
```lua
lspconfig[server].setup({
  -- configuration
})
```

**New (current):**
```lua
-- Global config in init.lua
vim.lsp.config('*', { ... })

-- Server-specific config in lsp/server.lua
return { ... }

-- Server activation in init.lua
vim.lsp.enable(servers)
```

## Benefits

- **Performance**: Global configuration reduces redundancy and improves startup time
- **Maintainability**: Server-specific configs are isolated and easier to manage
- **Consistency**: Common patterns ensure consistent configuration across servers
- **Simplicity**: Adding new servers requires minimal configuration