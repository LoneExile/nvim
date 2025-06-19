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
    '<leader>ca',
    '<cmd>AvanteAsk<CR>',
    desc = 'Ask',
    mode = 'n',
  },
  -- AvanteEdit
  {
    '<leader>ce',
    '<cmd>AvanteEdit<CR>',
    desc = 'Edit',
    mode = 'v',
  },
  {
    '<leader>cC',
    '<cmd>AvanteClear<CR>',
    desc = 'Clear',
    mode = 'n',
  },
  {
    '<leader>cn',
    '<cmd>AvanteConflictNextConflict<CR>',
    desc = 'Next Conflict',
    mode = 'n',
  },
  {
    '<leader>cp',
    '<cmd>AvanteConflictPrevConflict<CR>',
    desc = 'Prev Conflict',
    mode = 'n',
  },
  {
    '<leader>cs',
    '<cmd>AvanteStop<CR>',
    desc = 'Stop',
    mode = 'n',
  },
  {
    '<leader>cx',
    '<cmd>AvanteModels<CR>',
    desc = 'Avante Switch Provider',
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
    event = 'VeryLazy',
    lazy = false,
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
        -- event = 'VeryLazy',
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
        provider = "claude",
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
          openrouter = {
            __inherited_from = 'openai',
            endpoint = 'https://openrouter.ai/api/v1',
            -- model = 'anthropic/claude-opus-4',
            model = 'google/gemini-2.5-pro-preview-06-05',
            api_key_name = 'OPENROUTER_API_KEY',
            disable_tools = false,
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
