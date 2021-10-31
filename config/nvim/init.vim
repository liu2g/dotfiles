" ----- Imported Plugins ----- "
call plug#begin('$HOME/.local/share/nvim/plugged')

" Plug 'foo/bar', { 'on': [] } " Disable template
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'} " Auto-complete
Plug 'vim-airline/vim-airline' " Bottom statusbar
Plug 'davidhalter/jedi-vim' " LSP framework
Plug 'zchee/deoplete-jedi' " Python LSP
Plug 'tpope/vim-surround' " Auto complete quotes, brackets, etc
Plug 'nathanaelkane/vim-indent-guides'
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
Plug 'tmhedberg/simpylfold'
Plug 'dpelle/vim-LanguageTool'
Plug 'sbdchd/neoformat'
Plug 'puremourning/vimspector'
Plug 'elzr/vim-json'
Plug 'lervag/vimtex'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'

call plug#end()

" ----- Global settings ----- "
syntax on
let mapleader = ","
set timeoutlen=2000
" This saves one more key stroke
nnoremap ; :
nnoremap : ;
" Disallow word breaking on softwrap
set wrap linebreak nolist
" 80 char limit line
:set colorcolumn=79
" Movement scale with display
nnoremap j gj
nnoremap k gk
" Case incensitive search
set ignorecase smartcase
" Offer hard link to python because it works badly with conda
let g:python_host_prog  = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'
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

" Use Esc to remove search highlight
noremap <silent><esc> <esc>:noh<CR><esc>

nmap <Leader>o o<Esc>
nmap <Leader>O O<Esc>

" Folds open by default
set nofoldenable

" ----- Appearance ----- "
" Set airline theme
let g:airline_theme='murmur' 

" Set editor theme
colorscheme oceanic_material
set background=dark

" ----- Plugin Settings ----- "
" Deoplete
let g:deoplete#enable_at_startup = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif " close autocomplete preview
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
autocmd FileType tex  call deoplete#custom#buffer_option('auto_complete', v:false)
autocmd FileType markdown call deoplete#custom#buffer_option('auto_complete', v:false)

" IndentGuides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=236
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=238
let g:indent_guides_guide_size = 1 
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

" NERDTree
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
let g:NERDTreeChDirMode = 2


" Yoink
nmap <c-n> <plug>(YoinkPostPasteSwapBack)
nmap <c-p> <plug>(YoinkPostPasteSwapForward)
nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)
nmap gp <plug>(YoinkPaste_gp)
nmap gP <plug>(YoinkPaste_gP)
let g:yoinkIncludeDeleteOperations=1

" Cutlass
nnoremap m d
xnoremap m d
nnoremap mm dd
nnoremap M D

" Vim-buffet
noremap <Tab><Tab> :bn<CR>
noremap <S-Tab><S-Tab> :bp<CR>
noremap <Tab>q :Bw<CR>
noremap <Leader><Tab>q :Bw!<CR>
noremap <Tab>t :tabnew<CR>
let g:buffet_tab_icon = "\uf00a"
let g:buffet_left_trunc_icon = "\uf0a8"
let g:buffet_right_trunc_icon = "\uf0a9"
function! g:BuffetSetCustomColors()
  hi! BuffetCurrentBuffer ctermbg=235 ctermfg=193
  hi! BuffetActiveBuffer ctermbg=235 ctermfg=193
  hi! BuffetTab ctermbg=235 ctermfg=193
endfunction

" LanguageTool
let g:languagetool_jar='$HOME/.local/bin/LanguageTool/languagetool-commandline.jar'
let g:languagetool_win_height=8

" VimMarkdown
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0

" NERDCommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Jedi
let g:jedi#goto_command = "<leader>g"
let g:jedi#goto_assignments_command = "<leader>ga"
let g:jedi#goto_stubs_command = "<leader>gs"
let g:jedi#goto_definitions_command = "<leader>gd"
let g:jedi#documentation_command = "<leader>gk"
let g:jedi#usages_command = "<leader>gn"
let g:jedi#rename_command = "<leader>gr"

" Asynctasks 
let g:asyncrun_open = 6
function! AsyncTaskHelper()
    let task=input("Run async task:")
    execute "AsyncTask" . task
endfun
nnoremap <Leader>tg :call AsyncTaskHelper()<CR> 
nnoremap <Leader>tq :call asyncrun#quickfix_toggle(g:asyncrun_open)<CR>

" Vimspector
nmap <Leader>dl <Plug>VimspectorBalloonEval 
nmap <Leader>de :VimspectorEval
nnoremap <Leader>dc :VimspectorReset<CR>
nmap <Leader>dw <Plug>VimspectorWatch
nmap <Leader>dg <Plug>VimspectorContinue
nmap <Leader>dr <Plug>VimspectorRestart
nmap <Leader>dp <Plug>VimspectorPause
nmap <Leader>db <Plug>VimspectorToggleBreakpoint
nmap <Leader>dB <Plug>VimspectorToggleConditionalBreakpoint
nmap <Leader>dt <Plug>VimspectorRunToCursor
nmap <Leader>di <Plug>VimspectorStepInto
nmap <Leader>do <Plug>VimspectorStepOut
nmap <Leader>ds <Plug>VimspectorStepOver
function! VimspectorEvalHelper()
    let exp=input("Vimspector Evaluate:")
    call vimspector#Evaluate(exp)
endfun
nnoremap <Leader>de :call VimspectorEvalHelper()<CR>
command! Erc edit $MYVIMRC
command! Src source $MYVIMRC

" Vim-json
au! BufRead,BufNewFile *.json set filetype=json
augroup json_autocmd
  autocmd!
  autocmd FileType json set autoindent
  autocmd FileType json set formatoptions=tcq2l
  autocmd FileType json set textwidth=78 shiftwidth=2
  autocmd FileType json set softtabstop=2 tabstop=8
  autocmd FileType json set expandtab
  autocmd FileType json set foldmethod=syntax
augroup END

" ----- Custom Command ----- "
fun! Mksession(...)
    VimspectorReset
    if a:0 > 0
        let name = a:1
    else
        let name = "Session.vim"
    endif
    let nt_open = g:NERDTree.IsOpen()
    NERDTreeClose
    execute "mksession!" . name
    if nt_open
        call writefile(readfile(name)+['NERDTree'], name)
        NERDTree
    endif
endfun
command! -nargs=* SS call Mksession(<f-args>)

com! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"

