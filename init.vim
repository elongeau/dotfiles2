set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
set termguicolors 
set mouse=a

if !has('nvim')
    set ttymouse=xterm2
endif

let MYVIMRC=$HOME . "/.config/nvim/init.vim"

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Plug outside ~/.vim/plugged with post-update hook
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

Plug 'xolox/vim-misc'
" Plug 'xolox/vim-colorscheme-switcher'
" Plug 'altercation/vim-colors-solarized'
Plug 'lifepillar/vim-solarized8'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'ervandew/supertab'
Plug 'osyo-manga/vim-over'
Plug 'easymotion/vim-easymotion'
Plug 'asciidoc/vim-asciidoc'
Plug 'plasticboy/vim-markdown'
Plug 'godlygeek/tabular'
Plug 'vimlab/split-term.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'dag/vim-fish'
Plug 'vim-scripts/bash-support.vim'
Plug 'skywind3000/asyncrun.vim'

" Haskell
" Plug 'alx741/vim-stylishask'
Plug 'tinco/haskell.vim', { 'for': 'haskell' }
" Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
" Plug 'itchyny/vim-haskell-indent'
" Plug 'dag/vim2hs', { 'for': 'haskell' }
" Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
" Plug 'neomake/neomake'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins', 'for': 'haskell'  }
" Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
" Plug 'w0rp/ale', { 'for': 'haskell' }
Plug 'sbdchd/neoformat', { 'for': 'haskell' }
" Plug 'travitch/hasksyn'
Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': './install.sh'
"     \ }

" React
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

" Initialize plugin system
call plug#end()

set wrap linebreak nolist
set nofoldenable
set background=light
colorscheme solarized8_light

" recharge le fichier courant dans vim
noremap <silent><buffer> <F5> :exec 'source '.bufname('%')<CR>

" ======= FZF
nnoremap <leader>b :w<CR>:Buffers<CR>
nnoremap <leader>f :w<CR>:FZF<CR>
nnoremap <leader>t :w<CR>:!fast-tags -R src/ app/<CR><CR>:Tags<CR>
nnoremap <leader><tab> :w<CR>:bn<CR>

" let g:ghcmod_hlint_options = ['--ignore=Redundant lambda']

"----------------------------------------------------------
" Neovim's Python provider
"----------------------------------------------------------
let g:python_host_prog  = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" Supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" ALE
" highlight SignColumn ctermbg=white
" highlight ALEErrorSign ctermfg=red
" highlight ALEWarningSign ctermfg=yellow
" let g:ale_sign_error = '✘'
" let g:ale_sign_warning = '▵'
" let g:ale_sign_column_always = 1
" let g:ale_set_loclist = 1
" let g:ale_set_quickfix = 0
" let g:ale_open_list = 0

" nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" nmap <silent> <C-j> <Plug>(ale_next_wrap)
" nmap <silent> <F2> <Plug>(ale_next_wrap)

" Splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" let g:haskell_indent_case_alternative = 1
set smarttab
set smartindent
" let g:haskell_indent_disable=1
set expandtab
set tabstop=2
set shiftwidth=2

" Tabular
nnoremap <leader>= :Tabularize /=<CR>
nnoremap <leader>- :Tabularize /-><CR>

" neco
" let g:haskellmode_completion_ghc = 0
" autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" Autocommand
autocmd BufEnter * :syntax sync fromstart

" Indentation
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Backup
set nobackup
set noswapfile

" Scrolling
set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" vertical line indentation
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#09AA08'
let g:indentLine_char = '¦'

" Clipboard
" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

" Airline
"let g:airline_section_b = '%{strftime("%c")}'
"set laststatus=2
"let g:airline_powerline_fonts = 1
""powerline symbols
"let g:Powerline_symbols="fancy"
"let g:airline_section_z = ' %l / %L : %c '
"let g:airline_theme='solarized'

" Alt-{hjkl} for navigating panes
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Tabular 
" let g:haskell_tabular = 1

" vmap a= :Tabularize /=<CR>
" vmap a; :Tabularize /::<CR>
" vmap a- :Tabularize /-><CR>

" Neoformat
nnoremap <A-f> :%!stylish-haskell<CR>
" set formatprg=stylish-haskell
" augroup fmt
"   autocmd!
"   autocmd BufWritePre *.hs undojoin | :%!stylish-haskell
" augroup END
" let g:neoformat_enabled_haskell = ['brittany']
" let g:neoformat_enabled_haskell = ['stylish-haskell']
" let g:neoformat_enabled_haskell = ['stylish-haskell', 'brittany']

" Terminal
set splitright
set splitbelow
let g:disable_key_mappings = 1

set clipboard=unnamedplus

" Tags
" augroup tags
" au BufWritePost *.hs            AsyncRun fast-tags "%"
" au BufWritePost *.hsc           AsyncRun fast-tags "%"
" augroup END

" let g:stylishask_on_save = 1


