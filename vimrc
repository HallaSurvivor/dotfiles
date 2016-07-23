"Christopher Grossack's vimrc
"
"See the rest of my dotfiles here:
"https://github.com/HallaSurvivor/dotfiles

"==================================
"========Vundle and Plugins========
"==================================

"Ensure vundle is installed
"Shamlessly taken from:
"http://erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/

let vundleInstalled=1
let vundleReadme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundleReadme)
  echo "Installing vundle..."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
  let vundleInstalled=0
endif

"We're using vim, not vi. might as well act like it
set nocompatible

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"Vundle
Plugin 'VundleVim/Vundle.vim'

"Plugins

"General layout, visuals, etc.
Plugin 'jeffkreeftmeijer/vim-numbertoggle' "Relative line numbers in Normal mode only
Plugin 'bling/vim-airline'         "Status bar that interacts with other plugins
Plugin 'airblade/vim-gitgutter'    "Show git status to the left of line numbers
Plugin 'luochen1990/rainbow'       "Change color of parentheses based on nesting level
Plugin 'Yggdroot/indentLine'       "Show vertical lines indicating the indentation level
Plugin 'vim-scripts/IndexedSearch' "Show which result of how many after searching

"General Programming
Plugin 'scrooloose/syntastic'   "Check program syntax on saving file
Plugin 'Shougo/neocomplete'     "Amazing autocomplete
Plugin 'scrooloose/nerdtree'    "File browser inside vim
Plugin 'simnalamburt/vim-mundo' "Undo tree for better undo history navigation
Plugin 'tpope/vim-commentary'   "Quickly comment/uncomment lines of code
Plugin 'tpope/vim-surround'     "Quickly surround text with quotes, braces, etc.
Plugin 'godlygeek/tabular'      "Automatically align characters in lines of text
Plugin 'Townk/vim-autoclose'    "Automatically close braces when typing [, (, etc.

"Haskell
Plugin 'eagletmt/neco-ghc'         "Better autocompletion (uses neocomplete)
Plugin 'neovimhaskell/haskell-vim' "Better syntax highlighting, etc.
Plugin 'eagletmt/ghcmod-vim'       "Display types of expression
Plugin 'bitc/vim-hdevtools'        "Typecheck on file write (uses syntastic)

"Python
Plugin 'michaeljsmith/vim-indent-object' "New vim motions based on indentation
Plugin 'tmhedberg/Simpylfold'            "Fold python code properly

"Writing Prose
Plugin 'junegunn/goyo.vim'           "Center text and remove distractions such as airline
Plugin 'plasticboy/vim-markdown'     "Better markdown syntax highlighting
Plugin 'reedes/vim-pencil'           "Better controls inside vim for prose writing
Plugin 'reedes/vim-wordy'            "Proofreading and suggestions
Plugin 'reedes/vim-textobj-sentence' "Better sentence recognition in vim

"Misc
Plugin 'Shougo/vimproc.vim'        "Asynchronous execution in vim, a dependency for other plugins
Plugin 'vimperator/vimperator.vim' "Vimperator config syntax highlighting
Plugin 'keith/tmux.vim'            "Tmux config syntax highlighting
Plugin 'tpope/vim-repeat'          "Repeat plugin commands with .

if vundleInstalled == 0
  echo "Installing vim plugins..."
  echo ""
  :PluginInstall
endif

call vundle#end()

"necoGhc
let g:necoghc_enable_detailed_browse = 1 "Show types in necoghc

"haskell-vim
"Fix the random default indentations
let g:haskell_indent_if    = 2
let g:haskell_indent_case  = 2
let g:haskell_indent_let   = 2
let g:haskell_indent_where = 2
let g:haskell_indent_do    = 2
let g:haskell_indent_in    = 2
let g:haskell_indent_guard = 2

"neocomplete
if has("lua")
  let g:acp_enableAtStartup = 0           "Disable AutoComplPop
  let g:neocomplete#enable_at_startup = 1 "Use neocomplete
  let g:neocomplete#enable_smart_case = 1 "Show upper case completions if I'm typing in lower case
  let g:neocomplete#max_list = 10         "Set maximum completion list length
  let g:neocomplete#sources#syntax#min_keyword_length = 3 "Number of letters before starting completion
else
  let g:acp_enableAtStartup = 0
  let g:neocomplete#enable_at_startup = 0
endif

"NERDTree
"Close vim if NERDTree is the only open buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"indentLine
let g:indentLine_color_term    = 239   "indentline color
let g:indentLine_concealcursor = "in"  "show even when inserting text
let g:indentLine_char          = "|"   "use a | as the indicator
let g:indentLine_first_char    = "|"   "use a | even if it's the first one

"airline
"Use shorthand names in powerline
"i.e. I for insert, N for normal
let airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ }

"show a list of buffers (just the filenames)
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

"Rainbow Parentheses
let g:rainbow_active = 1

"Markdown
let g:vim_markdown_conceal = 0

"Turn Plugins On
filetype plugin on
filetype indent on

"=====================
"========Binds========
"=====================

"Close insert/visual mode with jk
"Don't press shift when saving/quitting
inoremap jk <esc>
vnoremap jk <esc>
nnoremap ; :
let mapleader=',' "Explicitly set leader

"\ev and \sv open and source .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

"Get rid of the Ex mode
nnoremap Q <nop>

"Allow for right-click paste without
"needing massive reformatting
set pastetoggle=<F2>

"Make vim autoscroll
nnoremap j jzz
nnoremap k kzz
nnoremap G Gzz
nnoremap { {zz
nnoremap } }zz
nnoremap n nzz
nnoremap N Nzz
nnoremap J <C-D>zz
nnoremap K <C-U>zz 

vnoremap j jzz
vnoremap k kzz

"More convenient plugin installation
:ca pi PluginInstall
:ca pc PluginClean

"Spell check
if has("spell")
  set spelllang=en_us
  nnoremap <silent> <leader>ss :set spell!<cr>
endif

"Open G-undo and NERDTree
nnoremap <silent> <leader>u :GundoToggle<CR>
nnoremap <silent> <leader>n :NERDTreeToggle<CR>

"Automatically create {} brace pairs with a newline between them
inoremap {<tab> {<cr>}<esc>O

"Tabularize
"automatically align on the folowing symbols:  = , | <other>
nnoremap <leader>a=     :Tabularize /=<CR>
nnoremap <leader>a,     :Tabularize /,<CR>
nnoremap <leader>a<bar> :Tabularize /<bar><CR>
nnoremap <leader>a      :Tabularize /

"show type of expression under cursor (Haskell)
nnoremap <silent> <buffer> <leader>ht :GhcModType<CR>
nnoremap <silent> <buffer> <leader>hT :GhcModTypeClear<CR>

"Try to compile the program to get errors in advance (Haskell)
nnoremap <silent> <buffer> <leader>hc :GhcModCheck<CR>
nnoremap <silent> <buffer> <leader>hC :GhcModLint<CR>

"Tab completion for neocomplete
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"fold with sapce
nnoremap <space> za

"Y yanks to end of line instead of whole line
nnoremap Y y$

"pressing enter will remove hilights from search terms
nnoremap <silent> <CR> :noh<CR><CR>

"Better navigation

"panes
nnoremap <silent> <c-j> <c-w>j
nnoremap <silent> <c-k> <c-w>k
nnoremap <silent> <c-h> <c-w>h
nnoremap <silent> <c-l> <c-w>l

"buffers
nnoremap <silent> <leader>bc :enew<cr>
nnoremap <silent> <leader>bn :bnext<cr>
nnoremap <silent> <leader>bm :bprev<cr>

"close buffer and move to previous one
nnoremap <leader>bq :bp <bar> bd #<cr> 

"Toggle prose related plugins
nnoremap <leader>p :TogglePencil<cr>:Goyo<cr>:source $MYVIMRC<cr>

"========================
"========Settings========
"========================

"Colors

"Use 256 colors, since we have them
set term=xterm-256color

"Use monokai colors based on programming syntax
syntax enable
set background=dark
colorscheme monokai

"monokai's background doesn't quite match my terminal, here's a fix.
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE

"Make the comments brighter to be more visible.
highlight Comment ctermfg=249


"General

"Use utf8
set encoding=utf-8

"By default, don't use system pasting
"(<f2> still toggles this)
set nopaste

"By default, don't check spelling
set nospell

"Put a bar at column 80 for code style
set colorcolumn=80 

"We promise not to use <esc> as part of a shortcut
set noesckeys

"Make vim run faster
set ttyfast

"Require shortcut keys be pressed within 1 second
set timeout
set timeoutlen=1000

"We promise to back things up by ourselves
set nobackup

"Don't show --insert--, etc. powerline does it for us
set noshowmode

"Store more history. we have the memory.
set history=2000

"Lets you keep unsaved buffers hidden
set hidden

"The height of the bar where :q, etc. show up
set cmdheight=2

"Show a statusline in every window
set laststatus=2

"Wrap text longer than the window to a new line
set wrap

"Show the current line number beside the line
set number

"Split screens go to the right and below.
"default behavior is left and right for some reason
set splitright
set splitbelow

"A tab is worth two spaces
set shiftwidth=2
set tabstop=2

"Make pressing tab type spaces instead
set expandtab

"Make backspace delete a tab's worth of spaces
set smarttab

"Make > and < round to a tabstop number of spaces
set shiftround

"Pressing enter while indented will preserve the indentation level
set autoindent

"Automatically indent after a line ending in {
set smartindent

"Search incrementally, (read: search intuitively)
set incsearch

"Highlight search results
set hlsearch

"ignore case in searching
set ignorecase

"visual bells are annoying. let's turn them off
set visualbell t_vb=
set noerrorbells

"Use indentation to determine what a fold is
set foldmethod=indent

"fold as far down as you can go
set foldlevel=99

"Save a file with all the undos we've done.
"But don't clutter the current folder. Put them in undodir
set undofile
set undodir=~/.vim/undodir

"Make backsapce work properly
set backspace=2
