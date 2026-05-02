# Neovim 0.13 Upgrade TODO

Plugin audit results for migrating LoneExile config from pre-0.11 era to Nvim 0.13.0-nightly.
Already done: partial LSP migration to `vim.lsp.config()` + `lsp/` dir + `vim.lsp.enable()`,
manual patch for 0.12 treesitter `match[id]` regression in `editor/treesitter/ts.lua`.

Order of operations is roughly top-to-bottom (biggest blast radius first).

---

## 🔴 Critical — broken / archived / forced migrations

### Treesitter `main` branch migration (BIG) — ✅ DONE 2026-05-02
- [x] Switched to `branch = "main"` (rewrite). `nvim-treesitter` now at `4916d65` (origin/main).
- [x] Rewrote `lua/LoneExile/editor/treesitter/ts.lua`: FileType autocmd calls `vim.treesitter.start()`, tuple-form `language.add()` check with sync 60s install + notify, buffer-local `vim.wo[0][0].foldexpr`/`foldmethod`, `:TSStatus` user command, VeryLazy background-prime.
- [x] `nvim-treesitter-textobjects` pinned to `branch = "main"`; keymaps registered via Lua API (`select_textobject`, `goto_next_start`, `swap_next`).
- [x] Removed `match[id]` query_predicates patch (lines 27-70 of old ts.lua) — unnecessary on `main`.
- [x] `RRethy/nvim-treesitter-textsubjects` dropped from deps (still in `lazy/` dir, will be cleaned next sync). Existing `is`/`as` keep working via textobjects `@statement.inner/outer`.
- [x] Added `folke/ts-comments.nvim` as redundant safety net.
- [x] Kept `JoosepAlviste/nvim-ts-context-commentstring` + `pre_hook` (load-bearing for Comment.nvim's JSX/TSX/Vue commentstring resolution).
- [x] Added `vim.g.skip_ts_context_commentstring_module = true` to silence its deprecated module-style auto-setup.
- Verified: `:checkhealth nvim-treesitter` passes; JSX `pre_hook` returns `{/* %s */}`; treesitter attaches on `.tsx`.
- Plan: `.omc/plans/treesitter-main-migration.md` (3 ralplan iterations).
- Rollback if needed: `git checkout -- lua/LoneExile/editor/treesitter/ts.lua lua/LoneExile/editor/treesitter/comment.lua lua/LoneExile/core/settings/plugins/all.lua && cp resources/lazy-lock.json.pre-ts-main resources/lazy-lock.json && nvim --headless +"Lazy! restore" +qa`.

### Archived plugin replacements — ✅ DONE 2026-05-02
- [x] `simrat39/rust-tools.nvim` → `mrcjkb/rustaceanvim` (archived Jan 2024). Rust LSP settings (lens/clippy/inlayHints) moved to `vim.g.rustaceanvim.server.default_settings`. `lsp/rust_analyzer.lua` deleted; `rust_analyzer` excluded from mason-lspconfig `automatic_enable` to prevent double-attach (rustaceanvim manages the LSP itself).
- [x] `phaazon/hop.nvim` → `folke/flash.nvim` (author abandoned). File renamed `motion/hop.lua` → `motion/flash.lua`. Preserved `gh` keymap, added `s`/`S`/`r`/`R` defaults, kept the same label-key string `etovxqpdygfblzhckisuran` for muscle memory.
- [x] `sindrets/diffview.nvim` → `dlyongemallo/diffview.nvim` (upstream silent since June 2024). Config + keymaps unchanged (active fork is API-compatible). Required `rm -rf ~/.local/share/nvim/lazy/diffview.nvim` + re-install since lazy.nvim keys plugins by final-path-segment.

### mason-lspconfig v2 breakage — ✅ DONE 2026-05-02
- [x] `lua/LoneExile/lsp/init.lua`: dropped `automatic_installation`, set `automatic_enable = { exclude = { 'ts_ls' } }` (excludes ts_ls so vtsls is the only TS LSP).
- [x] Dropped the manual `servers = {...}` list and `vim.lsp.enable(servers)` call.
- [x] Dropped `require('lspconfig')` call.
- [x] Replaced deprecated `vim.lsp.with(vim.lsp.handlers.hover, {border='rounded'})` with `vim.o.winborder = 'rounded'` (Nvim 0.11+).
- [x] mason org `williamboman/` → `mason-org/` already in spec.

### `mini.*` org rename (Oct 2025) — ✅ DONE (already in repo before this session)
- [x] All four specs (`mini.surround`, `mini.ai`, `mini.icons`, `mini.diff`) already use `nvim-mini/` in `all.lua` and the per-plugin spec files.
- [x] Clones on disk verified pointing at `https://github.com/nvim-mini/...` origins (mini.diff isn't cloned because it's disabled in all.lua).

---

## 🟡 LSP server name renames — ✅ DONE 2026-05-02

- [x] `tsserver` → `ts_ls` (file renamed; kept as fallback, but excluded from auto-enable in favour of vtsls).
- [x] `vuels` → `vue_ls` (file renamed and **rewritten** for Vue Language Tools / Volar; cmd `vls` → `vue-language-server`).
- [x] `emmet_ls` → `emmet_language_server` (file renamed; cmd `emmet-ls` → `emmet-language-server`; mason package `emmet-ls` → `emmet-language-server`).
- [x] Added `lsp/vtsls.lua` (registers `@vue/typescript-plugin` for `.vue` support).
- [x] Disabled `pmizio/typescript-tools.nvim` in `all.lua`; deleted `lua/LoneExile/lsp/servers/addon/typescript.lua`.
- [x] Updated `mason_tool_installer.lua`: `+vtsls`, `+vue-language-server`, `+emmet-language-server`; removed `typescript-language-server`, `vetur-vls`, `emmet-ls`.
- [x] Dropped `require('lspconfig')` call (Nvim 0.11+ auto-discovers `lsp/<name>.lua` from runtime path).

**Manual step**: in your nvim session, run `:Lazy sync` (to pick up disabled typescript-tools) then `:Mason` and uninstall the now-obsolete `typescript-language-server`, `vetur-vls`, `emmet-ls` packages.

---

## 🟠 Drop — redundant with `snacks.nvim`

You already have `folke/snacks.nvim` loaded. These are duplicates:

- [ ] `goolord/alpha-nvim` → `snacks.dashboard`
  - File: `lua/LoneExile/ui/alpha.lua`
- [ ] `stevearc/dressing.nvim` → `snacks.input` + `snacks.picker` (stevearc himself recommends this)
  - File: `lua/LoneExile/ui/dressing.lua`
- [ ] `rcarriga/nvim-notify` → `snacks.notifier`
  - File: `lua/LoneExile/ui/notify.lua`

### Optional drops (matter of taste)
- [ ] `j-hui/fidget.nvim` — `snacks.notifier` renders LSP `$/progress`. Keep only if you specifically want fidget's progress styling.
- [ ] `nvim-neo-tree/neo-tree.nvim` — `snacks.explorer` covers basic cases. Keep neo-tree if you use git/buffers/symbols sources or DnD.
- [ ] `akinsho/toggleterm.nvim` — `snacks.terminal` covers ~90%. Lacks `ToggleTermToggleAll`.

---

## 🟢 Config updates needed (keep the plugin, fix usage)

- [x] ~~`numToStr/Comment.nvim` — drop~~ **RECONSIDERED — kept** (load-bearing for JSX/TSX commentstring via `pre_hook`, see treesitter migration).
- [x] ~~`JoosepAlviste/nvim-ts-context-commentstring` — drop~~ **RECONSIDERED — kept** (same reason).
- [x] `andymass/vim-matchup` — verified 2026-05-02. The TODO's `matchup = { enable = true }` snippet was the old `master`-branch nvim-treesitter module API which no longer exists on `main`. On the current setup the TS engine is **on by default** (`g:matchup_treesitter_enabled = v:true`) — no opt-in flag exists or is needed. Cleaned up the stale "intentionally disabled" comment in `ts.lua` and added `require('match-up').setup({ matchparen = { deferred = 1, offscreen = { method = 'popup' } } })` for nicer offscreen UX + perf-friendly deferred matchparen.
- [x] `windwp/nvim-ts-autotag` — config rewritten 2026-05-02 to post-2024 API: `setup({ opts = { enable_close, enable_rename, enable_close_on_slash } })`. Top-level `filetypes`/`skip_tags` removed (now auto-detected via TS parser; void elements handled internally).
  - File: `lua/LoneExile/editor/treesitter/autoTag.lua`
- [ ] `ThePrimeagen/harpoon` — pin `branch = "harpoon2"`. Completely different API (`harpoon:list():add()`, `harpoon:list():select(N)`, `harpoon.ui:toggle_quick_menu(harpoon:list())`). Whole `harpoon.lua` gets rewritten.
  - File: `lua/LoneExile/editor/motion/harpoon.lua`
- [x] `lukas-reineke/indent-blankline.nvim` — verified v3-compliant: `tsIndent.lua` already sets `main = 'ibl'`, requires `'ibl'`, calls `indent_blankline.setup({})`. No `g:indent_blankline_*` globals used.
- [x] `glepnir/lspsaga.nvim` → `nvimdev/lspsaga.nvim` — URL updated 2026-05-02 in `all.lua` and `lspSaga.lua`. (Old org name still redirects, but updating the spec keeps lazy-lock clean.) Native `vim.lsp.buf.*` UIs in 0.11+ remain a future-drop candidate.
- [x] ~~`pmizio/typescript-tools.nvim`~~ — already disabled in LSP cleanup (replaced by vtsls).
- [x] `tomiis4/Hypersonic.nvim` — dropped 2026-05-02. Removed from `all.lua`; deleted `lua/LoneExile/editor/regex.lua`.

---

## 🔵 Optional / nice-to-have

- [ ] `nvim-cmp` → `Saghen/blink.cmp` (LazyVim, kickstart, AstroNvim are migrating). Big rewrite — optional swap.
- [ ] Drop `folke/neodev.nvim` if anywhere transitively — EOL'd in favor of `lazydev.nvim` (you've moved).
- [ ] Watch `nvim-ufo` on 0.13 — slow release pace. Native `vim.lsp.foldexpr()` is the fallback if it breaks.
- [ ] `wakatime` org renamed `williamboman` → `mason-org` checks complete; verify `mason-tool-installer` still works against v2.

---

## ✅ Healthy — keep as-is, no changes needed

**LSP/UX**: `nvim-lspconfig` (plan for v3.0.0 removal of framework), `mason.nvim`, `mason-tool-installer.nvim`, `aerial.nvim`, `conform.nvim`, `nvim-lint`, `lazydev.nvim`, `schemastore.nvim`, `tw-values.nvim`, `omnisharp-extended-lsp.nvim`, `go.nvim`, `gopher.nvim`.

**UI/Editor**: `tokyonight.nvim`, `lualine.nvim`, `oil.nvim`, `which-key.nvim` (v3), `nvim-ufo`, `todo-comments.nvim`, `snacks.nvim`, `mini.icons`, `wakatime`, `firenvim`, `live-preview.nvim`, `refactoring.nvim`, `img-clip.nvim`, `mini.diff`, `neotest`, `nvim-coverage`, `neogen`, `fzf-lua`, `nvim-spectre`, `guess-indent.nvim`, `csvview.nvim`, `gitsigns.nvim`, `vim-fugitive`.

**AI**: `copilot.lua`, `CopilotChat.nvim`, `codecompanion.nvim`, `mcphub.nvim`, `sidekick.nvim` (Folke's NES + CLI mux, complements rather than replaces).

**DAP**: `nvim-dap`, `nvim-dap-ui`, `nvim-dap-virtual-text`, `nvim-dap-go`, `nvim-dap-python`.

**DB**: `vim-dadbod`, `vim-dadbod-completion`, `vim-dadbod-ui`.
