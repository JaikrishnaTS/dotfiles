
set nocompatible

" setup colors
set term=screen-256color
set t_Co=256

set encoding=utf8

" key remaps
nnoremap ; :
let mapleader=','

" setup vim-plug and plugins
call plug#begin('~/.vim/plugged')
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'tpope/vim-fugitive'
    Plug 'vim-scripts/DoxygenToolkit.vim'
    Plug 'nanotech/jellybeans.vim'
    Plug 'ryanoasis/vim-devicons'
    Plug 'Rykka/riv.vim'
    Plug 'nvie/vim-flake8'
    Plug 'fatih/vim-go'
call plug#end()

" setup vim-airline
let g:airline_theme='hybridline'
let g:airline_powerline_fonts = 1

" load doxygen
let g:load_doxygen_syntax = 1

colorscheme jellybeans  " set color scheme

" buffer settings
" Enable buffer bar at top - only when >1 buffer
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#fnamemod = ':t' " Show just the filename
let g:airline#extensions#tabline#buffer_idx_mode = 1
set hidden " allow to leave unsaved buffers

" buffer navigation
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>t :bn<CR>
nmap <leader>T :bp<CR>

" adding to vim-airline's tabline 
let g:webdevicons_enable_airline_tabline = 1
" adding to vim-airline's statusline 
let g:webdevicons_enable_airline_statusline = 1

" riv disable folding
let g:riv_disable_folding = 1

" netrw settings
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_winsize = 25

" start in line where I left
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
    au BufNewFile,BufRead *.service set syntax=dosini
endif

set colorcolumn=80  " 80 char line
set number          " show line numbers
set tabpagemax=100  " increase max tabs
set textwidth=79    " autowrap beyond 79 chars
au Filetype * set formatoptions+=t " enable textwidth for all files

" tab settings
set expandtab       " tabs to spaces
set tabstop=4       " 4 spaces in a tab
set shiftwidth=4
set softtabstop=4

" search settings 
set incsearch       " show first match as entered
set hlsearch        " highlight all after <cr>, :noh to unhighlight
set ignorecase smartcase    " ignore case if all lowercase in query
" press ,/ to unhighlight
nmap <silent> <leader>/ :nohlsearch<CR>
" press ,n to toggle line numbers
nmap <silent> <leader>n :set invnumber<CR>

set pastetoggle=<leader>p   " toggle paste mode with leader p
set title           " change terminal title
set mouse=a         " enable mouse always

" dir settings
set backupdir=~/.vim/backup//   " change backup dir
set directory=~/.vim/swp//      " change swap dir

" split settings
set splitbelow
set splitright

" split navigation
nmap <leader>h <C-W><C-H>
nmap <leader>j <C-W><C-J>
nmap <leader>k <C-W><C-K>
nmap <leader>l <C-W><C-L>
nmap <leader>w :w<CR>
nmap <leader>m /^\s*-

" command bar settings
set laststatus=2    " always show airline
set showcmd         " show partial commands in command bar
set noshowmode      " dont show current mode in command bar
set wildmenu        " menu for command completion
" set wildmode=list:longest,full " complete like shell, also adds multiple rows

" enable manpage support
runtime! ftplugin/man.vim
au FileType man setlocal nonumber tabstop=8 colorcolumn=

" Underline function
function! s:Underline(chars)
  let chars = empty(a:chars) ? '-' : a:chars
  let nr_columns = virtcol('$') - 1
  let uline = repeat(chars, (nr_columns / len(chars)) + 1)
  put =strpart(uline, 0, nr_columns)
endfunction
command! -nargs=? Underline call s:Underline(<q-args>)
