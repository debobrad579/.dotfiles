## Installation

1. Install dependencies:
```bash
sudo pacman -S --needed base-devel neovim ripgrep unzip xclip
```

2. Install language dependencies:
```bash
sudo pacman -S --needed nodejs npm go pgformatter
sudo npm install -g prettier
```

3. Symlink the config:
```bash
cd ~/.dotfiles
stow nvim
```
