## Installation

1. Install dependencies:
```bash
sudo pacman -S --needed neovim ripgrep unzip xclip
```

2. Install language dependencies:
```bash
sudo pacman -S --needed nodejs npm go
```

3. Symlink the config:
```bash
cd ~/.dotfiles
stow nvim
```
