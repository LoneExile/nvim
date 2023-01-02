std = luajit

ignore = {
  '631', -- Line is too long.
}

globals = {
  'vim',
  'packer_plugins',
}

exclude_files = { './lua/user/core/whichKey.lua' }
