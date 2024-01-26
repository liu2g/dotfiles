" ----- Imported Plugins ----- "
call plug#begin('$HOME/.local/share/nvim/plugged')

Plug 'konfekt/vim-sentence-chopper'
Plug 'svermeulen/vim-cutlass'

call plug#end()

"let g:latexindent = 0

let mapleader = ","
set timeoutlen=2000
set ignorecase smartcase

set clipboard=unnamedplus
set clipboard+=unnamed

" Persisent undo
set undodir=~/.vim/undo-dir
set undofile

" Workaround for gk/gj
nnoremap k :<C-u>call VSCodeCall('cursorMove', { 'to': 'up', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>
nnoremap j :<C-u>call VSCodeCall('cursorMove', { 'to': 'down', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR>

noremap <silent><esc> <esc>:noh<CR><esc>

nnoremap m d
xnoremap m d

nnoremap mm dd
nnoremap M D
