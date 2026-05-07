set scrolloff=8
set number
set relativenumber
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set colorcolumn=80

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'joshdick/onedark.vim'
call plug#end()

if (has("termguicolors"))
  set termguicolors
endif
syntax on
colorscheme onedark

let mapleader = " "
let maplocalleader = " "

nnoremap <leader>pv :Ex<CR>

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

nnoremap <leader>y "+y
xnoremap <leader>y "+y
nnoremap <leader>Y mzgg"+yG`z
nnoremap <leader>v "+p
nnoremap <leader>V "+P
xnoremap <leader>v "_d"+p
xnoremap <leader>V "_d"+P

nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

nnoremap <leader>x :!chmod +x %<CR>
