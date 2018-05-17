set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

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

Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
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

" Haskell
" Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'dag/vim2hs', { 'for': 'haskell' }
" Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
Plug 'parsonsmatt/intero-neovim'
" Plug 'neomake/neomake'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins', 'for': 'haskell'  }
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plug 'w0rp/ale', { 'for': 'haskell' }
Plug 'sbdchd/neoformat'
Plug 'travitch/hasksyn'
Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }

" Initialize plugin system
call plug#end()

set wrap linebreak nolist
set nofoldenable
set background=light
colorscheme solarized

" ======= Motion
nnoremap j gj
nnoremap k gk

" recharge le fichier courant dans vim
noremap <silent><buffer> <F5> :exec 'source '.bufname('%')<CR>

" ======= FZF
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :FZF<CR>
nnoremap <leader>g :GFiles<CR>
nnoremap <leader><tab> :bn<CR>

" GHC Mod
nnoremap <silent> <leader>t :GhcModType<CR>
nnoremap <silent> <leader>tc :GhcModTypeClear<CR>

" autocmd BufWritePost *.hs call s:check_and_lint()
function! s:check_and_lint()
  let l:qflist = ghcmod#make('check', expand('%'))
  " call extend(l:qflist, ghcmod#make('lint', expand('%')))
  call setqflist(l:qflist)
  cwindow
  if empty(l:qflist)
    echo "No errors found"
  endif
endfunction

" let g:ghcmod_hlint_options = ['--ignore=Redundant lambda']

" Use deoplete.
let g:deoplete#enable_at_startup = 1

"----------------------------------------------------------
" Neovim's Python provider
"----------------------------------------------------------
let g:python_host_prog  = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" Supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" ALE
let g:ale_linters = {
\   'haskell': ['hlint','ghc-mod'],
\}
highlight SignColumn ctermbg=white
highlight ALEErrorSign ctermfg=red
highlight ALEWarningSign ctermfg=yellow
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '▵'
let g:ale_sign_column_always = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 1

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <F2> <Plug>(ale_next_wrap)

" Splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" let g:haskell_indent_case_alternative = 1
set smarttab
set smartindent
let g:haskell_indent_disable=1
set expandtab
set tabstop=2
set shiftwidth=2

" Tabular
nnoremap <leader>= :Tabularize /=<CR>
nnoremap <leader>- :Tabularize /-><CR>

" neco
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" Autocommand
" automatically reload MYVIMRC when it's saved
autocmd! bufwritepost MYVIMRC source %
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
let g:airline_section_b = '%{strftime("%c")}'
set laststatus=2
let g:airline_powerline_fonts = 1
"powerline symbols
let g:Powerline_symbols="fancy"
let g:airline_section_z = ' %l / %L : %c '
let g:airline_theme='solarized'

" Intero
" Use ALE (works even when not using Intero)
let g:intero_use_neomake = 0

augroup interoMaps
  au!

  au FileType haskell nnoremap <silent> <leader>io :InteroOpen<CR>
  au FileType haskell nnoremap <silent> <leader>iov :InteroOpen<CR><C-W>H
  au FileType haskell nnoremap <silent> <leader>ih :InteroHide<CR>
  au FileType haskell nnoremap <silent> <leader>is :InteroStart<CR>
  au FileType haskell nnoremap <silent> <leader>ik :InteroKill<CR>

  au FileType haskell nnoremap <silent> <leader>wr :w \| :InteroReload<CR>
  au FileType haskell nnoremap <silent> <leader>il :InteroLoadCurrentModule<CR>
  au FileType haskell nnoremap <silent> <leader>if :InteroLoadCurrentFile<CR>

  au FileType haskell map <leader>t <Plug>InteroGenericType
  au FileType haskell map <leader>T <Plug>InteroType
  au FileType haskell nnoremap <silent> <leader>it :InteroTypeInsert<CR>

  au FileType haskell nnoremap <silent> <leader>iu :InteroUses<CR>
  au FileType haskell nnoremap <leader>ist :InteroSetTargets<SPACE>

  au FileType haskell map <silent> <leader>t <Plug>InteroGenericType
  au FileType haskell map <silent> <leader>T <Plug>InteroType

  au FileType haskell nnoremap <silent> <leader>df :InteroGoToDef<CR>

  au FileType haskell nnoremap <silent> <leader>it :InteroTypeInsert<CR>

  au BufWritePost *.hs InteroReload

  au FileType haskell nnoremap <silent> <leader>jd :InteroGoToDef<CR>
augroup END

let g:intero_prompt_regex = 'λ ❯ '

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
let g:haskell_tabular = 1

vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>

" Neoformat
nnoremap <A-f> :Neoformat<CR>
inoremap <A-f> :Neoformat<CR>
" augroup fmt
"   autocmd!
"   autocmd BufWritePre * undojoin | Neoformat
" augroup END

" Terminal
set splitright
set splitbelow
let g:disable_key_mappings = 1

set clipboard=unnamedplus
