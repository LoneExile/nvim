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
├── _utils.lua             # Shared utilities to reduce redundancy
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
local utils = require('lsp._utils')

return {
  cmd = { 'example-language-server', '--stdio' },
  filetypes = { 'example' },
  root_dir = utils.root_dir(utils.root_patterns.git), -- Use shared patterns
  settings = {
    example = {
      -- Server-specific settings
    },
  },
}
```

## Utilities

The `_utils.lua` file provides shared utilities to reduce redundancy:

### Root Directory Patterns

Common root directory patterns are predefined:
- `utils.root_patterns.js_ts` - JavaScript/TypeScript projects
- `utils.root_patterns.python` - Python projects  
- `utils.root_patterns.go` - Go projects
- `utils.root_patterns.git` - Generic git-based projects

### Schema Integration

For JSON/YAML servers with schemastore integration:
```lua
schemas = utils.get_schemas('json'), -- or 'yaml'
```

## Adding New Servers

1. Create a new file `lsp/server_name.lua`
2. Return a configuration table with server-specific settings
3. Add the server name to the `servers` list in `lua/LoneExile/lsp/init.lua`
4. Use shared utilities from `_utils.lua` when possible

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
- **Consistency**: Shared utilities ensure consistent patterns across servers
- **Simplicity**: Adding new servers requires minimal configuration