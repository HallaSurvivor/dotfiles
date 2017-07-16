"Christopher Grossack's nvimrc
"
"See the rest of my dotfiles here:
"https://github.com/HallaSurvivor/dotfiles

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

"Show the search results in the middle of the screen
nnoremap n nzz
nnoremap N Nzz

"Spell check
set spelllang=en_us
nnoremap <silent> <leader>ss :set spell!<cr>

"Automatically create {} brace pairs with a newline between them
inoremap {<tab> {<cr>}<esc>O

"H/L move to start and end of line
nnoremap H ^
nnoremap L g_

"Y yanks to end of line instead of whole line
nnoremap Y y$

"U does a redo, instead of whatever it does by default
nnoremap U <C-R>

"pressing enter will remove hilights from search terms
nnoremap <silent> <CR> :noh<CR><CR>

"press space to toggle folds (still autoscroll)
nnoremap <space> zazz

"Plugins

"Tabularize
"automatically align on the folowing symbols:  = , | <other>
nnoremap <leader>a=     :Tabularize /=<CR>
nnoremap <leader>a,     :Tabularize /,<CR>
nnoremap <leader>a<bar> :Tabularize /<bar><CR>
nnoremap <leader>a-     :Tabularize /-><CR>
nnoremap <leader>a      :Tabularize /

"make <c-j> complete neosnippets
imap <C-j> <plug>(neosnippet_expand_or_jump)
smap <C-j> <plug>(neosnippet_expand_or_jump)
xmap <C-j> <plug>(neosnippet_expand_target)

"nerdTree
nnoremap <leader>f :NERDTreeToggle<CR>

"Gundo
nnoremap <leader>u :MundoToggle<CR>
