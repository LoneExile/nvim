local M = {}

M.keys = {
  {
    '<leader>c',
    '',
    desc = 'Copilot',
    mode = 'n',
  },
  {
    '<leader>cm',
    '<cmd>MCPHub<CR>',
    desc = 'MCPHub',
  },
}

M.setup = function()
  return {
    'ravitemer/mcphub.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = M.keys,
    build = 'pnpm install -g mcp-hub@latest',
    config = function()
      require('mcphub').setup({ auto_approve = true })
    end,
    extensions = {
      avante = {
        make_slash_commands = true, -- make /slash commands from MCP server prompts
      },
    },
  }
end

return M
