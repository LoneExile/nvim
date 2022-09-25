# nvim

## install dependencies

`node` `npm` `python3` `pip` `go` `rust` `cargo` `cmake` `git`

```bash
# should i use mason?
# yay -S codespell xsel
pip install isort black pynvim flake8 debugpy markdownlint-cli
npm install -g prettier neovim yarn markdownlint-cli
cargo install stylua
```

---

## fixing thing

### on arch

```bash
rm -rf ~/.cache/nvim/* ~/.local/share/nvim/site ~/.config/nvim/plugin/packer_compiled.lua

```

---

## my note

`:'<,'>s/[word-to-remove]/[word-to-replace]` -> **search and replace**

`<`(or `>`) + `i` (or `a`) + `p` (or `{},[], etc`) -> **indent +/-**

`:w !sudo tee %` -> **write sudo**

---

`:%s/\s\+$//e` -> **remove trailing whitespace**

`:set list` -> **show whitespace**

`:set list!` -> **hide whitespace**

`:set listchars=tab:▸\ ,trail:·,nbsp:␣` -> **customize whitespace**
