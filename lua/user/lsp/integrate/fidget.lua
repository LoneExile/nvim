local status_ok, fidget = pcall(require, 'fidget')
if not status_ok then
  return
end

fidget.setup({
  text = {
    spinner = 'moon',
  },
  window = {
    blend = 0,
  },
  sources = {
    ['null-ls'] = { ignore = true },
  },
})
