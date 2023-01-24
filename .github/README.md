# nvim

**_This configuration is quite disorganized and riddled with bugs._**

![2022-11-23_15-38](https://user-images.githubusercontent.com/82561297/203920945-1148071e-baa5-45ab-9aa5-3d92086ab149.png)

<!--toc:start-->

- [nvim](#nvim)
  - [install dependencies](#install-dependencies)
    - [General](#general)
      - [- OS](#os)
  - [Remove/uninstall plugin](#removeuninstall-plugin)
  - [Improve key repeat](#improve-key-repeat)
  - [TODO](#todo)
  <!--toc:end-->

## install dependencies

`node` `npm` `python3` `pip` `go` `rust` `cargo` `cmake` `git`

### General

```bash
npm install -g neovim pnpm
pip install pynvim

## also need
# btop, lazygit, lazydocker, nnn
```

#### OS

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

## Remove/uninstall plugin

on Arch or MacOS

```bash
rm -rf ~/.cache/nvim/* ~/.local/share/nvim/lazy/
```

## Improve key repeat

```bash
# mac os need restart, Too fast !? or change it on keyboard setting
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# linux
xset r rate 210 40
```

## TODO

- [ ] fix startup time, restucture plugins by groups (lsps, treesitter, utils)
- [ ] minimal config to run nvim, full config to run nvim
- [ ] whichkey better loading time when changing filetypes
