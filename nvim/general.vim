" Chris Grossack's nvim settings 
" (everything but plugins)
"
" See the rest of my dotfiles here:
" https://github.com/HallaSurvivor/dotfiles

" General Settings {{{

"We don't need to be vi compatable
filetype plugin indent on

"By default, don't use system pasting
set nopaste

"By default, don't check spelling
set nospell

"Put a bar at column 80 for code style
set colorcolumn=80 

"We're cool and don't use a mouse
set mouse=

"Require shortcut keys be pressed within .5 second
set timeout
set timeoutlen=500

"We promise to back things up by ourselves
set nobackup

"Don't show --insert--, etc. powerline does it for us
set noshowmode

"Lets you keep unsaved buffers hidden
set hidden

"The height of the bar where :q, etc. show up
set cmdheight=1

"Show a statusline in every window
set laststatus=2

"Wrap text longer than the window to a new line
set wrap

"Split screens go to the right and below.
"default behavior is left and right for some reason
set splitright
set splitbelow

"A tab is worth two spaces
set shiftwidth=2
set tabstop=2

"Make pressing tab type spaces instead
set expandtab

"Line numbers
set number

"Make > and < round to a tabstop number of spaces
set shiftround

"Pressing enter while indented will preserve the indentation level
set autoindent

"Automatically indent after a line ending in {
set smartindent

"Use indentation to determine what a fold is
set foldmethod=marker

"fold as far down as you can go
set foldlevel=99

"start folded as far as we can go
set foldlevelstart=0

"don't use any concealing
set cole=0

"make searching case insensitive (unless it should obviously be case sensitive)
set smartcase

"make searches start while typing them (a la ctrl-f)
set incsearch

"Save a file with all the undos we've done.
"But don't clutter the current folder. Put them in undodir
set undofile
set undodir=~/.config/nvim/undodir

"Makefiles are stupid and tab sensitive
autocmd FileType make setlocal noexpandtab

"Haskell should be using hoogle for K
au FileType haskell set kp=hoogle

"C should use syntax folding
au FileType c set foldmethod=syntax

"Remember the line you were on when reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"Treat sage files like python
autocmd BufRead,BufNewFile *.sage,*.pyx,*.spyx set filetype=python

"}}}

" Binds {{{
"Close insert/visual mode with jk
inoremap jk <esc>
vnoremap jk <esc>
let mapleader=' '

"Allow for right-click paste without
"needing massive reformatting
set pastetoggle=<F2>

"Show the search results in the middle of the screen
nnoremap n nzz
nnoremap N Nzz

"Spell check
set spelllang=en_us
nnoremap <silent> <leader>ss :set spell!<cr>

"Y yanks to end of line instead of whole line
nnoremap Y y$

"U does a redo, instead of whatever it does by default
nnoremap U <C-R>

"pressing enter will remove hilights from search terms
nnoremap <silent> <CR> :noh<CR><CR>

"toggle folds (still autoscroll)
nnoremap <leader>f zazz
"}}}
