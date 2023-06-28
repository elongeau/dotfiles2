set noswapfile
syntax enable

imap jk <Esc>
let mapleader=" "

set rnu
syntax on
filetype plugin indent on


nnoremap wq :wq<CR>
nnoremap <leader>w :w<CR>
nnoremap <M-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>i

" I'm using neovim so check init.vim too ;-)
