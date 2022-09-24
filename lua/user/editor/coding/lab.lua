local status_ok, lab = pcall(require, 'lab')
if not status_ok then
  vim.notify('lab' .. ' not found!')
  return
end
lab.setup({
  code_runner = {
    enabled = true,
  },
  quick_data = {
    enabled = false,
  },
})
