" setup colors
set term=screen-256color
set t_Co=256

" setup vim-plug and plugins
call plug#begin('~/.vim/plugged')
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'tpope/vim-fugitive'
    Plug 'vim-scripts/DoxygenToolkit.vim'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'nanotech/jellybeans.vim'
call plug#end()

" setup vim-airline
let g:airline_theme='hybridline'
let g:airline_powerline_fonts = 1

" unicode symbols if powerline absent
" if !exists('g:airline_symbols')
"         let g:airline_symbols = {}
" endif
" 
" let g:airline_theme='powerlineish'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.whitespace = 'Ξ'

" remove bottom bar
set noshowmode
set laststatus=2

" netrw options
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_winsize = 25

" my options
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
let g:load_doxygen_syntax = 1
set colorcolumn=80
set number
set tabpagemax=100
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

set mouse=a
set backupdir=~/.vim/backup//
set directory=~/.vim/swp//
colorscheme jellybeans

set splitbelow
set splitright
