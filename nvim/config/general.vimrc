"Christopher Grossack's nvimrc
"
"See the rest of my dotfiles here:
"https://github.com/HallaSurvivor/dotfiles

"Set colorscheme
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme monokai
set background=dark
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE

"By default, don't use system pasting
set nopaste

"By default, don't check spelling
set nospell

"Put a bar at column 80 for code style
set colorcolumn=80 

"We promise not to use <esc> as part of a shortcut
set noesckeys

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

"don't use any concealing
set cole=0

"Save a file with all the undos we've done.
"But don't clutter the current folder. Put them in undodir
set undofile
set undodir=~/.config/nvim/undodir

"Remember the line you were on when reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"Automatically compile latex docs on save
"TODO - there's a way to do this with neomake...
au BufWritePost *.tex :silent !latexmk
