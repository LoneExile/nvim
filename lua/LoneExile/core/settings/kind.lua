local M = {}

M.kindIcon = function(colors)
  return {
    [1] = { 'File', ' ', colors.fg },
    [2] = { 'Module', ' ', colors.blue },
    [3] = { 'Namespace', ' ', colors.orange },
    [4] = { 'Package', ' ', colors.violet },
    [5] = { 'Class', ' ', colors.violet },
    [6] = { 'Method', ' ', colors.violet },
    [7] = { 'Property', ' ', colors.cyan },
    [8] = { 'Field', ' ', colors.teal },
    [9] = { 'Constructor', ' ', colors.blue },
    [10] = { 'Enum', ' ', colors.green },
    [11] = { 'Interface', ' ', colors.orange },
    [12] = { 'Function', '󰡱 ', colors.violet },
    [13] = { 'Variable', ' ', colors.blue },
    [14] = { 'Constant', ' ', colors.cyan },
    [15] = { 'String', '󰅳 ', colors.green },
    [16] = { 'Number', '󰎠 ', colors.green },
    [17] = { 'Boolean', ' ', colors.orange },
    [18] = { 'Array', '󰅨 ', colors.blue },
    [19] = { 'Object', ' ', colors.orange },
    [20] = { 'Key', ' ', colors.red },
    [21] = { 'Null', '󰟢 ', colors.red },
    [22] = { 'EnumMember', ' ', colors.green },
    [23] = { 'Struct', ' ', colors.violet },
    [24] = { 'Event', ' ', colors.violet },
    [25] = { 'Operator', ' ', colors.green },
    [26] = { 'TypeParameter', ' ', colors.green },
    [27] = { 'cmp-tw2css', ' ', colors.green },
    [28] = { 'Copilot', ' ', colors.green },
    [29] = { 'Color', ' ', colors.green },
    [30] = { 'Folder', ' ', colors.green },
    [31] = { 'Keyword', 'K ', colors.green },
    [32] = { 'Reference', 'R ', colors.green },
    [33] = { 'Snippet', ' ', colors.green },
    [34] = { 'Text', '󰭷 ', colors.green },
    [35] = { 'Unit', '󰊱 ', colors.green },
    [36] = { 'Value', ' ', colors.green },

    -- ccls
    [252] = { 'TypeAlias', ' ', colors.green },
    [253] = { 'Parameter', ' ', colors.blue },
    [254] = { 'StaticMethod', ' ', colors.orange },
    [255] = { 'Macro', ' ', colors.red },
  }
end

return {
  kindIcon = M.kindIcon,
}
