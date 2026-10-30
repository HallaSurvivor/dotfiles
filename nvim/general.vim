" Chris Grossack's nvim settings 
" (everything but plugins)
"
" See the rest of my dotfiles here:
" https://github.com/HallaSurvivor/dotfiles

let g:python3_host_prog = '/usr/bin/python3'

" General Settings {{{

"By default, don't check spelling
set nospell

"Put a bar at column 80 for code style
set colorcolumn=80 
hi ColorColumn guibg=DarkCyan
set textwidth=80

"We're cool and don't use a mouse
set mouse=

"Require shortcut keys be pressed within .3 seconds
set timeout
set timeoutlen=300

"We promise to back things up by ourselves
set nobackup

"Don't show --insert--, etc. powerline does it for us
set noshowmode

"The height of the bar where :q, etc. show up
set cmdheight=1

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

"Automatically indent after a line ending in {
set smartindent

"Use indentation to determine what a fold is
set foldmethod=marker

"start folded as far as we can go
set foldlevelstart=0

"don't use any concealing
set cole=0

"make searching case insensitive (unless it should obviously be case sensitive)
set ignorecase
set smartcase

"Save a file with all the undos we've done.
"But don't clutter the current folder. Put them in undodir
set undofile
set undodir=~/.config/nvim/undodir

"Makefiles are stupid and tab sensitive
autocmd FileType make setlocal noexpandtab

"Remember the line you were on when reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"Know what macaulay2 files are
autocmd BufNewFile,BufRead *.m2 set ft=Macaulay2

"}}}

" Binds {{{
"Close insert/visual mode with jk
inoremap jk <esc>
tnoremap <esc> <C-\><C-n>
tnoremap jk <C-\><C-n>

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

"reflow paragraphs to fit within 80 columns
nnoremap <leader>q gwip

"}}}

