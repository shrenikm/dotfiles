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
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

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
Plug 'patstockwell/vim-monokai-tasty'
Plug 'crusoexia/vim-monokai'
Plug 'scrooloose/nerdcommenter'
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
Plug 'heavenshell/vim-pydocstring'
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-clang'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

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
silent! colorscheme solarized8_flat

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

""---------
"" nerdtree
""---------
"" Launch NerdTree (file system viewer).
"nnoremap <leader>nt :NERDTreeToggle<cr>
"" Launch NerdTree with the current file selected.
"nnoremap <leader>nf :NERDTreeFind<cr>
"" Ignore .pyc files
"let NERDTreeIgnore = ['\.pyc$']


"-------------
" nvim-tree
"-------------
let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_highlight_opened_files = 1 "0 by default, will enable folder and file icon highlight for opened files/directories.
let g:nvim_tree_root_folder_modifier = ':~/Projects/' "This is the default. See :help filename-modifiers for more options
let g:nvim_tree_add_trailing = 1 "0 by default, append a trailing slash to folder names
let g:nvim_tree_group_empty = 1 " 0 by default, compact folders that only contain a single folder into one node in the file tree
let g:nvim_tree_icon_padding = ' ' "one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
let g:nvim_tree_symlink_arrow = ' >> ' " defaults to ' ➛ '. used as a separator between symlinks' source and target.
let g:nvim_tree_respect_buf_cwd = 1 "0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
let g:nvim_tree_create_in_closed_folder = 1 "0 by default, When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 } " List of filenames that gets highlighted with NvimTreeSpecialFile
let g:nvim_tree_show_icons = {
    \ 'git': 0,
    \ 'folders': 0,
    \ 'files': 0,
    \ 'folder_arrows': 0,
    \ }
"If 0, do not show the icons for one of 'git' 'folder' and 'files'
"1 by default, notice that if 'files' is 1, it will only display
"if nvim-web-devicons is installed and on your runtimepath.
"if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
"but this will not work when you set renderer.indent_markers.enable (because of UI conflict)

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:nvim_tree_icons = {
    \ 'default': "",
    \ 'symlink': "",
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   }
    \ }
nnoremap <leader>nt :NvimTreeToggle<CR>
nnoremap <leader>nr :NvimTreeRefresh<CR>
nnoremap <leader>nf :NvimTreeFindFile<CR>

lua require('nvim-tree').setup()


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
let g:deoplete#sources#clang#libclang_path='/usr/lib/llvm-6.0/lib/libclang-6.0.so.1'
let g:deoplete#sources#clang#clang_header='/usr/lib/llvm-6.0/lib/libclang'

" Map to tab through deoplete options.
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

"-----------------
" COC
"---------------
let g:coc_config_home = '~/.config/nvim/'

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>aqf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

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
" Set a mapping for autopep8.
"----------------------------
autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>

" Other autopep8 settings.
let g:autopep8_max_line_length=79
let g:autopep8_indent_size=4
let g:autopep8_on_save = 1
let g:autopep8_disable_show_diff=1


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
