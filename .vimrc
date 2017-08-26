
set nocompatible

" setup colors
set term=screen-256color
set t_Co=256

set encoding=utf8

" setup vim-plug and plugins
call plug#begin('~/.vim/plugged')
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'tpope/vim-fugitive'
    Plug 'vim-scripts/DoxygenToolkit.vim'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'nanotech/jellybeans.vim'
    Plug 'ryanoasis/vim-devicons'
call plug#end()

" setup vim-airline
let g:airline_theme='hybridline'
let g:airline_powerline_fonts = 1

" load doxygen
let g:load_doxygen_syntax = 1

colorscheme jellybeans  " set color scheme

" unicode symbols if powerline absent
" if !exists('g:airline_symbols')
"         let g:airline_symbols = {}
" endif
" let g:airline_theme='powerlineish'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.whitespace = 'Ξ'

" buffer settings
" Enable buffer bar at top - only when >1 buffer
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#fnamemod = ':t' " Show just the filename
set hidden " allow to leave unsaved buffers

" vimwiki markdown by default
let g:vimwiki_list = [{'path': '~/', 'syntax': 'markdown', 'ext': '.md'}]

" adding to vim-airline's tabline 
let g:webdevicons_enable_airline_tabline = 1
" adding to vim-airline's statusline 
let g:webdevicons_enable_airline_statusline = 1

" netrw settings
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_winsize = 25

" start in line where I left
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" key remaps
nnoremap ; :
let mapleader=','

set colorcolumn=80  " 80 char line
set number          " show line numbers
set tabpagemax=100  " increase max tabs

" tab settings
set expandtab       " tabs to spaces
set tabstop=4       " 4 spaces in a tab
set shiftwidth=4
set softtabstop=4

" search settings 
set incsearch       " show first match as entered
set hlsearch        " highlight all after <cr>, :noh to unhighlight
set ignorecase smartcase    " ignore case if all lowercase in query
nmap <silent> <leader>/ :nohlsearch<CR>    " press ,/ to unhighlight
nmap <silent> <leader>l :set invnumber<CR> " press ,l to toggle line numbers

set pastetoggle=<leader>p   " toggle paste mode with leader p
set title           " change terminal title
set mouse=a         " enable mouse always

" dir settings
set backupdir=~/.vim/backup//   " change backup dir
set directory=~/.vim/swp//      " change swap dir

" split settings
set splitbelow
set splitright

" command bar settings
set laststatus=2    " always show airline
set showcmd         " show partial commands in command bar
set noshowmode      " dont show current mode in command bar
set wildmenu        " menu for command completion
" set wildmode=list:longest,full " complete like shell, also adds multiple rows

" enable manpage support
runtime! ftplugin/man.vim
au FileType man setlocal nonumber colorcolumn=
let g:airline#extensions#tabline#enabled = 0
