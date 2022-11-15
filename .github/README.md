# nvim

<!--toc:start-->
- [nvim](#nvim)
  - [install dependencies](#install-dependencies)
    - [OS](#os)
    - [General](#general)
  - [Fixing thing](#fixing-thing)
    - [on Arch or MacOS](#on-arch-or-macos)
  - [My note](#my-note)
<!--toc:end-->

## install dependencies

`node` `npm` `python3` `pip` `go` `rust` `cargo` `cmake` `git`

### OS

<details>
<summary>Arch</summary>

via [yay](https://github.com/Jguer/yay)

```bash
yay -S git base-devel go rust perl ruby luarocks pyenv tk bat wget tree ripgrep\
fd jq fzf xclip lazygit tmux zip nnn-nerd advcpmv nsxiv zathura zathura-pdf-mupdf\
dragon-drop glow ttf-jetbrains-mono xsel
```

</details>

<details>
<summary>MacOS</summary>

via [brew](https://brew.sh/)

```bash
xcode-select --install
  
brew install bat btop docker fd fzf cmake gcc git jq lazygit nnn ripgrep\
tmux tree tree-sitter wget gdu gnupg unzip glow

brew install ruby go luarocks perl rust dotnet
brew install nvm pyenv pyenv-virtualenv
brew tap homebrew/cask-fonts && brew install --cask font-jetbrains-mono-nerd-font

```

</details>

<details>
<summary>Windows</summary>

via [scoop](https://scoop.sh)

```bash
scoop install git
git config --global credential.helper manager-core
scoop bucket add extras
scoop bucket add main
scoop install nu
scoop install nvm pyenv psed fzf ripgrep fd\
lazygit JetBrainsMono-NF make mingw  sudo winget wget rust go luarocks
```

</details>

---

### General

```bash
npm install -g neovim pnpm # tree-sitter-cli
pip install pynvim # pgcli ueberzug
```

---

## Fixing thing

### on Arch or MacOS

```bash
rm -rf ~/.cache/nvim/* ~/.local/share/nvim/site/* ~/.config/nvim/plugin/packer_compiled.lua

```

---

## My note

- Improve key repeat

```bash
# mac os need restart, Too fast !?
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

linux
xset r rate 210 40
```

`:'<,'>s/[word-to-remove]/[word-to-replace]` -> **search and replace**

`<`(or `>`) + `i` (or `a`) + `p` (or `{},[], etc`) -> **indent +/-**

`:w !sudo tee %` -> **write sudo**
