local M = {}

-- NOTE: add feature to detect keymap by file type
-- ft = { only = { 'lua' }, exclude = { 'alpha' } },
-- ft = { exclude = { 'lua' } },
-- ft = { only = { 'lua' } },
-- ft = { exclude = {} }, -- exclude all? for what?
-- ft = { only = {} }, -- include all
-- ft = {}, -- include all
-- nil -- include all

-- TODO: check if that plugin is installed

M.split_mappings = function(maps, ft)
  local nmappings = {}
  local vmappings = {}
  local ignore_nmappings = {}
  local ignore_vmappings = {}

  local function check_mode(mapping, mode)
    if #mapping == 0 then
      return true
    end
    return vim.tbl_contains(mapping, mode)
  end

  local function remove_noisy(mapping, key)
    local count = 0
    for _ in pairs(mapping[key]) do
      count = count + 1
    end
    if count == 1 then
      mapping[key] = nil
    end
    return mapping
  end

  local function add_mapping(value, mode, k)
    local map = {}
    for key, mapping in pairs(value) do
      if key == 'name' then
        map.name = mapping
      elseif mapping.mode and check_mode(mapping.mode, mode) then
        map[key] = mapping
        map[key].mode = nil

        --
        if map[key].ft then
          if
            (map[key].ft.exclude and vim.tbl_contains(map[key].ft.exclude, ft))
            or (map[key].ft.only and #map[key].ft.only ~= 0 and not vim.tbl_contains(map[key].ft.only, ft))
          then
            map[key] = nil
            if mode == 'n' then
              table.insert(ignore_nmappings, k .. key)
            elseif mode == 'v' then
              table.insert(ignore_vmappings, k .. key)
            end
          else
            map[key].ft = nil
          end
        end
      --
      elseif not mapping.mode and key ~= 'name' then
        map[key] = add_mapping(mapping, mode, k .. key)
        map = remove_noisy(map, key)
      end
    end

    return map
  end

  for k, v in pairs(maps) do
    local copy_n = vim.deepcopy(v)
    local copy_v = vim.deepcopy(v)
    if v.mode then
      if check_mode(copy_n.mode, 'n') then
        nmappings[k] = copy_n
        if nmappings[k].cmd and copy_n.cmd then
          table.insert(nmappings[k], 1, copy_n.cmd.n)
          nmappings[k]['cmd'] = nil
        end
        nmappings[k]['mode'] = nil

        --
        if nmappings[k].ft then
          if
            (nmappings[k].ft.exclude and vim.tbl_contains(nmappings[k].ft.exclude, ft))
            or (nmappings[k].ft.only and #nmappings[k].ft.only ~= 0 and not vim.tbl_contains(nmappings[k].ft.only, ft))
          then
            nmappings[k] = nil
            table.insert(ignore_nmappings, k)
          else
            nmappings[k].ft = nil
          end
        end
        --
      end
      if check_mode(copy_v.mode, 'v') then
        vmappings[k] = copy_v
        if vmappings[k].cmd and copy_v.cmd then
          table.insert(vmappings[k], 1, copy_v.cmd.v)
          vmappings[k]['cmd'] = nil
        end
        vmappings[k]['mode'] = nil

        --
        if vmappings[k].ft then
          if
            (vmappings[k].ft.exclude and vim.tbl_contains(vmappings[k].ft.exclude, ft))
            or (vmappings[k].ft.only and #vmappings[k].ft.only ~= 0 and not vim.tbl_contains(vmappings[k].ft.only, ft))
          then
            vmappings[k] = nil
            table.insert(ignore_vmappings, k)
          else
            vmappings[k].ft = nil
          end
        end
        --
      end
    else
      vmappings[k] = add_mapping(copy_v, 'v', k)
      nmappings[k] = add_mapping(copy_n, 'n', k)
      vmappings = remove_noisy(vmappings, k)
    end
  end

  return nmappings, vmappings, ignore_nmappings, ignore_vmappings
end

-- https://github.com/folke/which-key.nvim/issues/349
M.deregister = function(mappings_d, prefix, mode, whichkey)
  local all_mappings = {}
  for _, lhs in ipairs(mappings_d) do
    local mapping = (prefix or '<leader>') .. lhs
    pcall(vim.api.nvim_del_keymap, mode or 'n', mapping)
    all_mappings[mapping] = 'which_key_ignore'
  end
  whichkey.register(all_mappings)
end

return M
