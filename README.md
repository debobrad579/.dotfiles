# .dotfiles

This repository contains my personal configuration files for arch linux.

## Prerequisites

- Git - Version Control
```bash
sudo pacman -S git
```

- GNU Stow - Symlink Management
```bash
sudo pacman -S stow
```

## Installation

1. Clone this repository to your home directory:

```bash
git clone git@github.com:debobrad579/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

2. Install required dependencies:

```bash
# Install all dependencies:
./install

# Install dependencies for individual module:
./install nvim
```

3. Symlink configurations:

```bash
# Symlink every config:
stow */

# Symlink config for individual module:
stow nvim
```

To remove symlinks for a specific module:

```bash
cd ~/.dotfiles
stow -D nvim
```
