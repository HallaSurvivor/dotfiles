"Christopher Grossack's nvimrc
"
"See the rest of my dotfiles here:
"https://github.com/HallaSurvivor/dotfiles

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

"H/L move to start and end of line
nnoremap H ^
nnoremap L g_

"Y yanks to end of line instead of whole line
nnoremap Y y$

"U does a redo, instead of whatever it does by default
nnoremap U <C-R>

"pressing enter will remove hilights from search terms
nnoremap <silent> <CR> :noh<CR><CR>

"toggle folds (still autoscroll)
nnoremap <leader>f zazz

"Plugins

"Tabularize
"automatically align on the folowing symbols:  = , | <other>
nnoremap <leader>a=     :Tabularize /=<CR>
nnoremap <leader>a,     :Tabularize /,<CR>
nnoremap <leader>a<bar> :Tabularize /<bar><CR>
nnoremap <leader>a-     :Tabularize /-><CR>
nnoremap <leader>a      :Tabularize /

"nerdTree
nnoremap <leader>n :NERDTreeToggle<CR>

"Gundo
nnoremap <leader>u :MundoToggle<CR>

"deoplete + neosnippet + autopairs changes
"Shamelessly stolen from
"https://www.reddit.com/r/neovim/comments/5qj7a7/neosnippets_deoplete/
let g:AutoPairsMapCR=0
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
imap <expr><TAB> pumvisible() ? "\<C-n>": (neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)": "\<TAB>")
imap <expr><S-TAB> pumvisible() ? "\<C-p>": "\<S-TAB>"
imap <expr><CR> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>\<Plug>AutoPairsReturn"
