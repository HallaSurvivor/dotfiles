"Christopher Grossack's nvimrc
"
"See the rest of my dotfiles here:
"https://github.com/HallaSurvivor/dotfiles

"Close insert/visual mode with jk
inoremap jk <esc>
vnoremap jk <esc>
let mapleader=',' "Explicitly set leader

",ev and ,sv open and source .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

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

vnoremap j jzz
vnoremap k kzz

"Spell check
set spelllang=en_us
nnoremap <silent> <leader>ss :set spell!<cr>

"Automatically create {} brace pairs with a newline between them
inoremap {<tab> {<cr>}<esc>O

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

"Plugins

"Tabularize
"automatically align on the folowing symbols:  = , | <other>
nnoremap <leader>a=     :Tabularize /=<CR>
nnoremap <leader>a,     :Tabularize /,<CR>
nnoremap <leader>a<bar> :Tabularize /<bar><CR>
nnoremap <leader>a-     :Tabularize /-><CR>
nnoremap <leader>a      :Tabularize /

"Haskell
nnoremap <silent> <buffer> <leader>ht :GhcModType<CR>
nnoremap <silent> <buffer> <leader>hT :GhcModTypeClear<CR>
