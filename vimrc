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

"General Programming
Plugin 'tpope/vim-commentary'   "Quickly comment/uncomment lines of code
Plugin 'tpope/vim-surround'     "Quickly surround text with quotes, braces, etc.
Plugin 'godlygeek/tabular'      "Automatically align characters in lines of text
Plugin 'Townk/vim-autoclose'    "Automatically close braces when typing [, (, etc.
Plugin 'tpope/vim-repeat'       "Repeat plugin commands with .
Plugin 'simnalamburt/vim-mundo' "Show undo tree
Plugin 'scrooloose/nerdtree'    "Show directory tree

if vundleInstalled == 0
  echo "Installing vim plugins..."
  echo ""
  :PluginInstall
endif

call vundle#end()

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

"Turn Plugins On
filetype plugin on
filetype indent on

"=====================
"========Binds========
"=====================

"Close insert/visual mode with jk
inoremap jk <esc>
vnoremap jk <esc>
let mapleader='v' "Explicitly set leader

",ev and ,sv open and source .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

"Allow for right-click paste without
"needing massive reformatting
set pastetoggle=<F2>

"Make vim center search terms
nnoremap n nzz
nnoremap N Nzz

"More convenient plugin installation
:ca pi PluginInstall
:ca pc PluginClean

"Spell check
if has("spell")
  set spelllang=en_us
  nnoremap <silent> <leader>ss :set spell!<cr>
endif

"Open G-undo and NERDTree
nnoremap <silent> <leader>u :MundoToggle<CR>
nnoremap <silent> <leader>n :NERDTreeToggle<CR>

"Automatically create {} brace pairs with a newline between them
inoremap {<tab> {<cr>}<esc>O

"Tabularize
"automatically align on the folowing symbols:  = , | <other>
nnoremap <leader>a=     :Tabularize /=<CR>
nnoremap <leader>a,     :Tabularize /,<CR>
nnoremap <leader>a<bar> :Tabularize /<bar><CR>
nnoremap <leader>a-     :Tabularize /-><CR>
nnoremap <leader>a      :Tabularize /

"fold with sapce
nnoremap <space> za

"Y yanks to end of line instead of whole line
nnoremap Y y$

"U does a redo, instead of whatever it does by default
nnoremap U <C-R>

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
set foldmethod=marker

"fold as far down as you can go
set foldlevel=99

"Save a file with all the undos we've done.
"But don't clutter the current folder. Put them in undodir
set undofile
set undodir=~/.vim/undodir

"Make backsapce work properly
set backspace=2
