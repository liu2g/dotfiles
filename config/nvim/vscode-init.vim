let mapleader = ","
set timeoutlen=2000
set ignorecase smartcase

set clipboard=unnamedplus
set clipboard+=unnamed
" This saves one more key stroke
" nnoremap ; :
" nnoremap : ;

" Persisent undo
set undodir=~/.vim/undo-dir
set undofile

" commenting out the visual line navigation out as it fails navigating notes with embeds
"" Have j and k navigate visual lines rather than logical ones, normal mode
noremap j gj
noremap k gk
noremap gj j
noremap gk k
noremap 0 g0
noremap $ g$
noremap A g$a


"" use logical line navigation in visual mode
vnoremap j gj
vnoremap k gk
vnoremap gj j
vnoremap gk k
