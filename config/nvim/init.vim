" ----- Global settings ----- "
syntax on
let mapleader = "<Space>"
set timeoutlen=2000
" This saves one more key stroke
" nnoremap ; :
" nnoremap : ;
" Disallow word breaking on softwrap
set wrap linebreak nolist
" 80 char limit line
" set colorcolumn=79
" Movement scale with display
nnoremap j gj
nnoremap k gk
" Case incensitive search
set ignorecase smartcase
" Quickly switch buffers
nnoremap <Space><Space> <C-w>w 
"Show 10 lines around cursor
set scrolloff=10
"Set tab config
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Hybrid line number
set number

" Faster scrolling
set ttyfast

" Use system clipboard
set clipboard+=unnamedplus

" Use Esc to remove search highlight
noremap <silent><esc> <esc>:noh<CR><esc>

nmap <Leader>o o<Esc>
nmap <Leader>O O<Esc>

" Folds open by default
set nofoldenable

" Persisent undo
set undodir=~/.vim/undo-dir
set undofile

