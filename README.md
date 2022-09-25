# nvim

<!--toc:start-->

- [nvim](#nvim)
  - [install dependencies](#install-dependencies)
  - [fixing thing](#fixing-thing)
    - [on arch](#on-arch)
  - [my note](#my-note)
  <!--toc:end-->

## install dependencies

`node` `npm` `python3` `pip` `go` `rust` `cargo` `cmake` `git`

<details>
<summary>arch</summary>

via [yay](https://github.com/Jguer/yay)

```bash
yay -S git base-devel go rust perl ruby pyenv tk bat wget tree ripgrep fd jq fzf\
xclip lazygit tmux zip nnn-nerd advcpmv nsxiv zathura zathura-pdf-mupdf\
dragon-drop glow ttf-jetbrains-mono xsel
```

</details>

<details>
<summary>macOS</summary>

```bash
# maybe later
```

</details>

<details>
<summary>windows</summary>

via [scoop](scoop.sh)

```bash
scoop install git
git config --global credential.helper manager-core
scoop bucket add extras
scoop bucket add main
scoop install nu
scoop install nvm pyenv docker docker-compose powertoys sed fzf ripgrep fd\
lazygit JetBrainsMono-NF make mingw  sudo winget wget rust go
```

</details>

```bash
cargo install stylua
npm install -g prettier neovim yarn eslint pnpm alex bash-language-server tree-sitter-cli
pip install isort black pynvim flake8 debugpy proselint pgcli beautysh ueberzug \
pynvim msgpack msgpack codespell markdownlint-cli
go install github.com/rhysd/actionlint/cmd/actionlint
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
