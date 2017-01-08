"Install Plugins

call plug#begin('~/.config/nvim/plugged')
  "AutoCompletion
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'SirVer/ultisnips'

  "General layout
  Plug 'jeffkreeftmeijer/vim-numbertoggle'
  Plug 'bling/vim-airline'
  Plug 'airblade/vim-gitgutter'
  Plug 'luochen1990/rainbow'
  Plug 'Yggdroot/indentline'

  "Quality of life
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-vinegar'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'godlygeek/tabular'
  Plug 'Townk/vim-autoclose'
  Plug 'neomake/neomake'

  "Haskell
  Plug 'neovimhaskell/haskell-vim'
  Plug 'eagletmt/neco-ghc'

  "Syntax highlighting
  Plug 'plasticboy/vim-markdown'  
  Plug 'vimperator/vimperator.vim'
  Plug 'keith/tmux.vim'
  Plug 'sheerun/vim-polyglot'
  
call plug#end()

"Configure Plugins

"deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#max_menu_width = 0  "No max menu width

"neomake
autocmd! BufWritePost * Neomake

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

"neco-ghc
let g:necoghc_enable_detailed_browse = 1

"Ultisnips
let g:UltiSnipsEditSplit="vertical"
