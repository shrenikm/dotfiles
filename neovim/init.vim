"==================
" Plugin Management
"==================
if has('nvim')
    "let s:vim_plug_file="~/.local/share/nvim/site/autoload/plug.vim"
    let s:vim_plug_file="~/.config/nvim/autoload/plug.vim"
    "let s:vim_plug_dir="~/.local/share/nvim/plugged"
    let s:vim_plug_dir="~/.config/nvim/plugged"
    let s:local_init_file="~/.config/nvim/local_init.vim"
    let s:local_plugins_file="~/.config/nvim/local_plugins.vim"
else
    let s:vim_plug_file="~/.vim/autoload/plug.vim"
    let s:vim_plug_dir="~/.vim/plugged"
    let s:local_init_file="~/.vim/local_init.vim"
    let s:local_plugins_file="~/.vim/local_plugins.vim"
endif

" Download vim-plug if it's not already present.
" Remove these lines to disable automatic downloading of vim-plug
if !filereadable(expand(s:vim_plug_file))
    echom system("curl -fLo " . s:vim_plug_file . " --create-dirs "
    \ . "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim")
endif

" Specify a directory for plugins
call plug#begin(s:vim_plug_dir)

" To see the description/code for the plugin loaded by the line
"
"     Plug 'user/repo'
"
" go to https://github.com/user/repo.
Plug 'vim-scripts/a.vim'
Plug 'tyok/ack.vim'
"Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-scripts/drawit'
Plug 'gregsexton/gitv'
"Plug 'valloric/ListToggle'
Plug 'lifepillar/vim-solarized8'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'mhartington/oceanic-next'
Plug 'phanviet/vim-monokai-pro'
Plug 'crusoexia/vim-monokai'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tyok/nerdtree-ack'
Plug 'mklabs/split-term.vim'
"Plug 'tpope/tpope-vim-abolish'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'moll/vim-bbye'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rhysd/vim-clang-format'
Plug 'tpope/vim-fugitive'
"Plug 'weynhamz/vim-plugin-minibufexpl'
Plug 'tpope/vim-sleuth'
Plug 'wesQ3/vim-windowswap'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'nvie/vim-flake8'
Plug 'tell-k/vim-autopep8'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
Plug 'heavenshell/vim-pydocstring'
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-clang'

" If you add additional "Plug 'user/repo'" lines in the file specified by
" s:local_plugins_file, those plugins will be loaded as well.
if filereadable(expand(s:local_plugins_file))
  exec "source " . s:local_plugins_file
endif

" Initialize plugin system
call plug#end()

"============================================
" Set leader. This is used for many mappings.
"============================================
let mapleader=","

"=========================================
" Settings/Mappings for particular plugins
"=========================================
"-----------
" Theme
"-----------
"silent! colorscheme solarized8_flat
"True colors support
set termguicolors
silent! colorscheme monokai

"--------------
" YouCompleteMe
"--------------
" Jump to definition.
nnoremap <leader>gg :YcmCompleter GoTo<cr>
let g:ycm_always_populate_location_list=1
" Apply fix-it suggestion.
nnoremap <leader>fi :YcmCompleter FixIt<cr>

"------
" a.vim
"------
" Toggle between header/source (Using a.vim)
nnoremap <leader>a :A<cr>

"-----------
" ListToggle
"-----------
" Toggle the location list on and off. Useful for checking YouCompleteMe
" results.
let g:lt_location_list_toggle_map = '<leader>lo'
" Toggle the quickfix list on and off.
let g:lt_quickfix_list_toggle_map = '<leader>lq'

"----------
" ctrlp.vim
"----------
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_custom_ignore = '\v[\/](build|doc|bazel-kcov)$'
" Launch CtrlP. Use this and then start typing fragments of the file path.
nnoremap <leader>ff :CtrlP<cr>

"------------
" vim-airline
"------------
set laststatus=2
set showtabline=2

"-------------------
" vim-airline-themes
"-------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='bubblegum'

"-----
" gitv
"-----
" Launch Gitv
nnoremap <leader>gv :Gitv<cr>

"---------
" nerdtree
"---------
" Launch NerdTree (file system viewer).
nnoremap <leader>nt :NERDTreeToggle<cr>
" Launch NerdTree with the current file selected.
nnoremap <leader>nf :NERDTreeFind<cr>
" Ignore .pyc files
let NERDTreeIgnore = ['\.pyc$']

"-------------
" vim-fugitive
"-------------
" Show the diff to HEAD for the current file.
nnoremap <leader>gd :Gdiff<cr>
" Show the git status of the repo.
nnoremap <leader>gs :Gstatus<cr>

" Fold method
"set foldmethod=syntax

"-----------------
" vim-clang-format
"-----------------
let g:clang_format#detect_style_file=1
" Call clang-format on the current file.
autocmd FileType c,cpp,objc nnoremap <buffer><leader>cf :<C-u>ClangFormat<CR>
" Call clang-format on the selected portion of the current file.
autocmd FileType c,cpp,objc vnoremap <buffer><leader>cf :ClangFormat<CR>

"------------------------
" vim-windowswap Settings
"------------------------
let g:windowswap_map_keys = 0 "prevent default bindings
" Swap the contents of two windows. Press <leader>ss while in the first
" window, then navigate to the second window and press <leader>ss again.
nnoremap <silent> <leader>pp :call WindowSwap#EasyWindowSwap()<CR>

"------------
" vim-session
"------------
let g:session_dir = '~/.config/nvim/sessions'
exec 'nnoremap <Leader>sse :mksession! ' . g:session_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <Leader>lse :source ' . g:session_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'

"-----------------
" deoplete
"---------------
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path='/usr/lib/llvm-6.0/lib/libclang-6.0.0.so'
let g:deoplete#sources#clang#clang_header='/usr/lib/llvm-6.0/lib/libclang'

" Map to tab through deoplete options.
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

"===================================================================

"----------------------------
" Highlight the 80-th column for cpp.
"----------------------------
autocmd FileType c,cpp set cc=80

"----------------------------
" Highlight the 79-th column for python.
"----------------------------
autocmd FileType python set cc=79

"----------------------------
" Set python autoformatter.
"----------------------------
autocmd FileType python AutoFormatBuffer autopep8


"----------------------------
" Set a mapping for autopep8.
"----------------------------
nnoremap <F8> :FormatCode<CR>

"-------------------------------------------
" Ignore CamelCase words when spell checking
"-------------------------------------------
fun! IgnoreCamelCaseSpell()
  syn match CamelCase /\<[A-Z][a-z]\+[A-Z].\{-}\>/ contains=@NoSpell transparent
  syn cluster Spell add=CamelCase
endfun
autocmd BufRead,BufNewFile * :call IgnoreCamelCaseSpell()

"----------------------------------------
" Recognize doxygen comments as comments.
"----------------------------------------
autocmd Filetype c,cpp set comments^=:///

"---------------
" Misc. Settings
"---------------
" Use filetype plugins.
filetype plugin on
" Do not highlight all search matches.
set nohlsearch
" Show line numbers
set number
let g:session_autosave='no'

"=============================================================
" Other settings/mappings that may be useful in general. YYMV.
"=============================================================

"---------------------
" Buffer configuration
"---------------------
set hidden
" Open next buffer in the current window.
nmap ff :bnext<CR>
" Open previous buffer in the current window.
nmap FF :bprevious<CR>

"-----------------------
" 'Ergonomics' mappings.
"-----------------------
" Make getting from INSERT to NORMAL less of a stretch.
imap jj <Esc>
" Use <leader> + navigation keys to jump between windows in both NORMAL and
" INSERT modes.
nnoremap <leader>J <c-w>j
nnoremap <leader>K <c-w>k
nnoremap <leader>H <c-w>h
nnoremap <leader>L <c-w>l
inoremap <leader>J <Esc><c-w>j
inoremap <leader>K <Esc><c-w>k
inoremap <leader>H <Esc><c-w>h
inoremap <leader>L <Esc><c-w>l
" Save the current file.
nnoremap <leader>w :w<cr>
" Close the current file.
nnoremap <leader>q :q<cr>
" Save and close the current file.
" nnoremap <leader>wq :w<cr>:q<cr>
"Sourcing vimrc
nnoremap <leader>so :source ~/.config/nvim/init.vim<CR>
"Saving file and sourcing
nnoremap <leader>sso :w<CR> :source ~/.config/nvim/init.vim<CR>
" Close all files.
" nnoremap <leader>qa :qa<cr>
" Use <leader><leader> as a replacement for ":".
nnoremap <leader><leader> :

" Switch to specific window
nnoremap <leader>sh <c-w>h
nnoremap <leader>sl <c-w>l
nnoremap <leader>sj <c-w>j
nnoremap <leader>sk <c-w>k

" Scroll down 25 lines
nnoremap <leader>md 25<c-e>

" Scroll up 25 lines
nnoremap <leader>me 25<c-y>

" Insert a line below and go to normal mode
nnoremap <leader>no o<Esc>

" Insert a line above and go to normal mode
nnoremap <leader>nO O<Esc>

" Moving between tabs
" Move to the next tab
nnoremap <leader>tl :tabn<CR>

" Move to the previous tab
nnoremap <leader>th :tabp<CR>

" Close tab
nnoremap <leader>tk :tabclose<CR>

" Open window in a new tab
nnoremap <leader>tj :tabedit %<CR>

" Open new tab
nnoremap <leader>tt :tabedit <CR>

" Switch to the next buffer
nnoremap <leader>bh :bn<CR>

" Switch to the previous buffer
nnoremap <leader>bl :bp<CR>

" Close the buffer
nnoremap <leader>bk :bd<CR>

" Tab size
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab


"----------------------------
" Tab spacing for python.
"----------------------------
autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

"============================================
" Pydocstring remap.
"============================================
nmap <silent> <F6> <Plug>(pydocstring)

" Mouse
set mouse=a

" Split location
set splitright

"----------------------------------
" Terminal management (Neovim only)
"----------------------------------
"if has('nvim')
"    " Open a new terminal in a horizontal split.
"    nnoremap <leader>tj :Term<cr><C-\><C-n><c-w>x<c-w>ji
"    " Open a new terminal in a vertical split.
"    nnoremap <leader>tl :VTerm<cr>
"    " Go from TERMINAL mode to NORMAL mode.
"    tnoremap <leader>tq <C-\><C-n>
"    " Go to the next tab while in TERMINAL mode.
"    tnoremap <leader>gt <C-\><C-n>gt
"    " Move to an adjacent window while in TERMINAL mode.
"    tnoremap <leader>J <C-\><C-n><c-w>j<Esc>
"    tnoremap <leader>K <C-\><C-n><c-w>k<Esc>
"    tnoremap <leader>H <C-\><C-n><c-w>h<Esc>
"    tnoremap <leader>L <C-\><C-n><c-w>l<Esc>
"    let g:disable_key_mappings=1
"    set splitright
"    autocmd TermOpen * setlocal nonumber
"endif

"----------------------
" Edit/source this file
"----------------------
let s:current_file=expand('<sfile>:p')
if !exists("*EditVimrc")
  function EditVimrc()
    execute 'split' s:current_file
  endfunction
endif
if !exists("*SourceVimrc")
  function SourceVimrc()
    execute 'source' s:current_file
  endfunction
endif
" Edit this file.
nnoremap <leader>ev :call EditVimrc()<CR>
" Source this file.
nnoremap <leader>sv :call SourceVimrc()<CR>


" If you put more mappings or other magic in the file specified by
" s:local_init_file, those will be added here.
if filereadable(expand(s:local_init_file))
  exec "source " . s:local_init_file
endif
