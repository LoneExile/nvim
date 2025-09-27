# LSP Configuration Directory

This directory contains server-specific configurations for the Neovim 0.10+ core LSP system.

## Architecture

The LSP configuration uses the new Neovim 0.10+ core LSP approach:

- **Global Configuration**: Set via `vim.lsp.config('*', {...})` in the main init.lua
- **Server Activation**: Done via `vim.lsp.enable(servers)` instead of individual setup calls
- **Server-Specific Config**: Individual files in this directory that return configuration tables

## File Structure

```
lsp/
├── README.md              # This documentation
├── lua_ls.lua             # Lua language server config
├── gopls.lua              # Go language server config
├── tsserver.lua           # TypeScript/JavaScript server config
├── pyright.lua            # Python language server config
├── jsonls.lua             # JSON language server config
├── yamlls.lua             # YAML language server config
└── [other servers].lua    # Additional server configurations
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

1. Create a new file `lsp/server_name.lua`
2. Return a configuration table with server-specific settings
3. Add the server name to the `servers` list in `lua/LoneExile/lsp/init.lua`
4. Use common patterns for root_dir and schema functions when applicable

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