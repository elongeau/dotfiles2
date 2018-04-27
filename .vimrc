set noswapfile
syntax enable

imap jk <Esc>
let mapleader=" "

set rnu
syntax on
filetype plugin indent on

" ======= Numbers =======
" to an easily access of numbers with command on a french keyboad
nnoremap & 1
nnoremap é 2
nnoremap " 3
nnoremap ' 4
nnoremap ( 5
nnoremap § 6
nnoremap è 7
nnoremap ! 8
nnoremap ç 9
nnoremap à 0

nnoremap wq :wq<CR>
nnoremap <leader>w :w<CR>
inoremap <C-s> <ESC>:w<CR>i

" I'm using neovim so check init.vim too ;-)
