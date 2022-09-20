# nvim

## install dependencies

```bash
# should i use mason?
pip install isort black pynvim flake8 debugpy markdownlint-cli
yay -S codespell xsel
npm install -g prettier neovim yarn markdownlint-cli
cargo install stylua
```

---

## fixing thing

```bash
rm -rf ~/.cache/nvim/* ~/.local/share/nvim/site ~/.config/nvim/plugin/packer_compiled.lua

```

---

## my note

`:'<,'>s/[word-to-remove]/[word-to-replace]` -> **search and replace**

`<`(or `>`) + `i` (or `a`) + `p` (or `{},[], etc`) -> **indent +/-**
