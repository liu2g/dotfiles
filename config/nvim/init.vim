call plug#begin('~/.local/share/nvim/plugged')

" Plug 'foo/bar', { 'on': [] } " Disable template
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'} " Auto-complete
Plug 'vim-airline/vim-airline' " Bottom statusbar
Plug 'davidhalter/jedi-vim', " LSP framework
Plug 'zchee/deoplete-jedi' " Python LSP
Plug 'tpope/vim-surround' " Auto complete quotes, brackets, etc
Plug 'nathanaelkane/vim-indent-guides' " Indent helper
Plug 'scrooloose/nerdcommenter' " Comment helper 
Plug 'sbdchd/neoformat' " Auto formatter
Plug 'scrooloose/nerdtree' " File tree
Plug 'glepnir/oceanic-material' " Editor theme
Plug 'vim-airline/vim-airline-themes' " Airline theme
Plug 'svermeulen/vim-yoink' " Clipboard registers
Plug 'svermeulen/vim-cutlass' " Delete but not cut
Plug 'kassio/neoterm' " Integraded terminal
Plug 'ryanoasis/vim-devicons' " File icons
Plug 'tpope/vim-fugitive' " Git integration
Plug 'mhinz/vim-signify' " Show git diff
Plug 'jreybert/vimagit' " Easier git
Plug 'Xuyuanp/nerdtree-git-plugin' " Git integration to nerdtree
Plug 'bagrat/vim-buffet' " Gives tabs
Plug 'lifepillar/vim-cheat40'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'dpelle/vim-LanguageTool'


call plug#end()

syntax on

nnoremap ; :
nnoremap : ;

set wrap linebreak nolist

:set colorcolumn=79

nnoremap j gj
nnoremap k gk

"Case incensitive search
set ignorecase smartcase

set incsearch hlsearch

let g:python_host_prog  = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'

nnoremap <Space><Space> <C-w>w 

"Show 10 lines around cursor
set scrolloff=10

"Set tab config
set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set expandtab


" Set airline theme
let g:airline_theme='murmur' 

" Set editor theme
colorscheme oceanic_material
set background=dark

" Deoplete setup
let g:deoplete#enable_at_startup = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif " close autocomplete preview
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
autocmd FileType tex  call deoplete#custom#buffer_option('auto_complete', v:false)
autocmd FileType markdown call deoplete#custom#buffer_option('auto_complete', v:false)

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=236
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=238
let g:indent_guides_guide_size = 1 
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Open nerdtree if use dir or empty in arg
function! StartUp()
    if !argc() && !exists("s:std_in")
        NERDTree
    end
    if argc() && isdirectory(argv()[0]) && !exists("s:std_in")
        exe 'NERDTree' argv()[0]
        wincmd p
        ene
    end
endfunction
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * call StartUp()
nnoremap <C-_> :NERDTreeToggle<CR>

" Hybrid line number
:set number
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END

" Faster scrolling
set ttyfast

" Use system clipboard
set clipboard+=unnamedplus

" Change paste keybind for Yoink
nmap <c-n> <plug>(YoinkPostPasteSwapBack)
nmap <c-p> <plug>(YoinkPostPasteSwapForward)
nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)
nmap gp <plug>(YoinkPaste_gp)
nmap gP <plug>(YoinkPaste_gP)
let g:yoinkIncludeDeleteOperations=1

" Change cut keybind for Cutlass
nnoremap m d
xnoremap m d
nnoremap mm dd
nnoremap M D

" Configure vim-buffet
noremap <Tab> :bn<CR>
noremap <S-Tab> :bp<CR>
noremap <Leader><Tab> :Bw<CR>
noremap <Leader><S-Tab> :Bw!<CR>
noremap <C-t> :tabnew split<CR>
let g:buffet_tab_icon = "\uf00a"
let g:buffet_left_trunc_icon = "\uf0a8"
let g:buffet_right_trunc_icon = "\uf0a9"
function! g:BuffetSetCustomColors()
  hi! BuffetCurrentBuffer ctermbg=235 ctermfg=193
  hi! BuffetActiveBuffer ctermbg=235 ctermfg=193
  hi! BuffetTab ctermbg=235 ctermfg=193
endfunction

