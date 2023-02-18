local status_ok, comment = pcall(require, 'Comment')
if not status_ok then
  return
end

local status, ts_comment = pcall(require, 'ts_context_commentstring.integrations.comment_nvim')
if not status then
  return
end

local configs = {
  padding = true,
  sticky = true,
  ignore = '^$',
  toggler = {
    line = 'gcc',
    block = 'gbc',
  },
  opleader = {
    line = 'gc',
    block = 'gb',
  },
  extra = {
    above = 'gcO',
    below = 'gco',
    eol = 'gcA',
  },
  mappings = {
    basic = true,
    extra = true,
    extended = false,
  },
  pre_hook = ts_comment.create_pre_hook(),
  post_hook = nil,
}

comment.setup(configs)
