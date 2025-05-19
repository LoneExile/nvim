local M = {}

M.setup = function()
  return {
    "toppair/peek.nvim",
    ft = { 'markdown' },
    cmd = { 'PeekOpen', 'PeekClose' },
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
        require("peek").setup()
        vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
        vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  }
end

return M
