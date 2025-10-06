local M = {}

M.keys = {
  -- {
  --   '<leader>a',
  --   '',
  --   desc = 'Avante',
  --   mode = 'n',
  -- },
  {
    '<leader>c',
    '',
    desc = 'Copilot',
    mode = { 'n', 'v' },
  },
  {
    '<leader>cM',
    '',
    desc = 'Models',
    mode = { 'n', 'v' },
  },
  {
    '<leader>ca',
    '<cmd>AvanteAsk<CR>',
    desc = 'Ask Avante',
    mode = 'n',
  },
  -- AvanteEdit
  -- {
  --   '<leader>ce',
  --   '<cmd>AvanteEdit<CR>',
  --   desc = 'Edit',
  --   mode = 'v',
  -- },
  -- {
  --   '<leader>cC',
  --   '<cmd>AvanteClear<CR>',
  --   desc = 'Clear',
  --   mode = 'n',
  -- },
  -- AvanteModels
  {
    '<leader>cMa',
    '<cmd>AvanteModels<CR>',
    desc = 'Avante Models',
    mode = 'n',
  },
  -- {
  --   '<leader>cn',
  --   '<cmd>AvanteConflictNextConflict<CR>',
  --   desc = 'Next Conflict',
  --   mode = 'n',
  -- },
  -- {
  --   '<leader>cp',
  --   '<cmd>AvanteConflictPrevConflict<CR>',
  --   desc = 'Prev Conflict',
  --   mode = 'n',
  -- },
  {
    '<leader>cS',
    '<cmd>AvanteStop<CR>',
    desc = 'Stop',
    mode = 'n',
  },
}

M.setup = function()
  vim.fn.setenv('ANTHROPIC_API_KEY', vim.env.ANTHROPIC_API_KEY)
  vim.fn.setenv('OPENAI_API_KEY', vim.env.OPENAI_API_KEY)
  vim.fn.setenv('GEMINI_API_KEY', vim.env.GEMINI_API_KEY)
  vim.fn.setenv('TAVILY_API_KEY', vim.env.TAVILY_API_KEY)
  vim.fn.setenv('OPENROUTER_API_KEY', vim.env.OPENROUTER_API_KEY)
  return {
    'yetone/avante.nvim',
    -- cmd = { 'AvanteAsk', 'AvanteEdit'  },
    -- event = 'VeryLazy',
    event = { 'BufReadPre', 'InsertEnter' },
    lazy = true,
    build = 'make',
    keys = M.keys,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'zbirenbaum/copilot.lua',
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
      {
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
          },
        },
      },
    },

    config = function()
      require('avante').setup({
        provider = 'copilot',
        providers = {
          claude = {
            endpoint = 'https://api.anthropic.com',
            model = 'claude-sonnet-4-20250514',
            extra_request_body = {
              max_tokens = 40000,
              temperature = 0,
            },
            -- disable_tools = true,
          },
          copilot = {
            endpoint = 'https://api.githubcopilot.com',
            model = 'claude-sonnet-4.5',
            allow_insecure = false, -- Allow insecure server connections
            -- timeout = 30000, -- Timeout in milliseconds
            extra_request_body = {
              -- temperature = 0,
              max_tokens = 128000,
            },
          },
          openrouter = {
            __inherited_from = 'openai',
            endpoint = 'https://openrouter.ai/api/v1',
            -- model = 'anthropic/claude-opus-4',
            model = 'google/gemini-2.5-pro-preview-06-05',
            api_key_name = 'OPENROUTER_API_KEY',
            disable_tools = false,
          },
        },
        acp_providers = {
          -- ['claude-code'] = {
          --   -- pnpm install -g @anthropic-ai/claude-code
          --   -- pnpm install -g acp-claude-code
          --   command = 'npx',
          --   args = { 'acp-claude-code' },
          --   env = {
          --     NODE_NO_WARNINGS = '1',
          --     ANTHROPIC_API_KEY = os.getenv('ANTHROPIC_API_KEY'),
          --   },
          -- },
          -- npm install -g @google/gemini-cli
          ['gemini-cli'] = {
            command = 'gemini',
            args = { '--experimental-acp' },
            env = {
              NODE_NO_WARNINGS = '1',
              GEMINI_API_KEY = os.getenv('GEMINI_API_KEY'),
            },
          },
        },
        behaviour = {
          auto_set_keymaps = false,
        },
        hints = { enabled = false },
        windows = {
          edit = {
            border = 'rounded',
            start_insert = false,
          },
          ask = {
            start_insert = false,
          },
        },
        -- ---- ## ravitemer/mcphub.nvim
        disabled_tools = {
          'list_files', -- Built-in file operations
          'search_files',
          'read_file',
          'create_file',
          'rename_file',
          'delete_file',
          'create_dir',
          'rename_dir',
          'delete_dir',
          'bash', -- Built-in terminal access
        },
        -- system_prompt as function ensures LLM always has latest MCP server state
        -- This is evaluated for every message, even in existing chats
        system_prompt = function()
          local hub = require('mcphub').get_hub_instance()
          return hub and hub:get_active_servers_prompt() or ''
        end,
        -- Using function prevents requiring mcphub before it's loaded
        custom_tools = function()
          return {
            require('mcphub.extensions.avante').mcp_tool(),
          }
        end,
      })
    end,
  }
end

return M
