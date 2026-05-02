-- Vue Language Tools (Volar) server. Pair with vtsls (lsp/vtsls.lua) — vtsls
-- registers @vue/typescript-plugin so it can resolve TS in .vue files.
return {
  cmd = { 'vue-language-server', '--stdio' },
  filetypes = { 'vue' },
  init_options = {
    typescript = {
      -- nil → vue_ls resolves the workspace TS via vtsls' globalPlugins entry.
      tsdk = nil,
    },
    vue = {
      hybridMode = false,
    },
  },
}
