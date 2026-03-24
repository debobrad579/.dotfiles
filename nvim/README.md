## Installation

1. Install dependencies:
```bash
sudo pacman -S --needed base-devel neovim ripgrep unzip xclip
```

2. Set up languages:

- TypeScript/JavaScript:
```bash
sudo pacman -S --needed nodejs npm typescript prettier
```

- Go:
```
sudo pacman -S go
```

- Python:
```bash
sudo pacman -S python python-black
```

- PostgreSQL:
```bash
sudo pacman -S postgresql pgformatter
sudo -u postgres initdb --locale en_CA.UTF-8 -D /var/lib/postgres/data
sudo systemctl enable --now postgresql
```

- OCaml:
```
sudo pacman -S opam
opam init -y
eval $(opam env)
opam install ocaml-lsp-server ocamlformat
```

3. Symlink the config:
```bash
cd ~/.dotfiles
stow nvim
```
