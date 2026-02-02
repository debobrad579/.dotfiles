# .dotfiles

This repository contains my personal configuration files for arch linux.

## Prerequisites

- Git - Version Control
```bash
sudo pacman -S git
```
- GNU Stow - Symlink Manager
```bash
sudo pacman -S stow
```

## Installation

1. Clone this repository to your home directory:
```bash
git clone https://github.com/debobrad579/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

2. Use GNU Stow to symlink the configurations you want:

```bash
# Install all configurations:
stow */

# Install individual configuration:
stow <package-name>
```

3. Install the required dependencies for each component (see individual README files in each directory).

## Uninstalling

To remove symlinks for a specific configuration:

```bash
cd ~/.dotfiles
stow -D <package-name>
```
