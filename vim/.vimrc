set scrolloff=8
set number
set relativenumber
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set colorcolumn=80
set hlsearch
set incsearch

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * ++once PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'sheerun/vim-polyglot'
Plug 'machakann/vim-highlightedyank'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'joshdick/onedark.vim'
Plug 'ojroques/vim-oscyank', {'branch': 'main'}
call plug#end()

if (has("termguicolors"))
  set termguicolors
endif
syntax on
silent! colorscheme onedark

let g:netrw_banner = 0
let g:highlightedyank_highlight_duration = 150

let mapleader = " "
let maplocalleader = " "

nnoremap <leader>pv :Ex<CR>

nnoremap <Esc> :nohlsearch<CR>

nnoremap <C-p> :GFiles<CR>
nnoremap <leader>pf :Files<CR>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap J mzJ`z
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv

xnoremap <leader>p "_dP

let g:oscyank_term = 'default'
let g:oscyank_max_length = 0

nnoremap <leader>y V:OSCYankVisual<CR>
xnoremap <leader>y :OSCYankVisual<CR>
nnoremap <leader>Y mzggVG:OSCYankVisual<CR>`z

nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

nnoremap <leader>x :!chmod +x %<CR>
