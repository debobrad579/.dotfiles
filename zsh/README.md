## Installation

1. Install dependencies:
```bash
sudo pacman -S --needed zsh fzf zoxide xclip
```

2. Symlink the config:
```bash
cd ~/.dotfiles
stow zsh

# Optional, required for tmux sessionizer
stow tmux
```

3. Set as your default shell:
```bash
chsh -s $(which zsh)
```

4. Relog or start a new shell:
```bash
zsh
```
