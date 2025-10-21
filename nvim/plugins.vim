" Chris Grossack's nvim settings 
" (just the plugins)
"
" See the rest of my dotfiles here:
" https://github.com/HallaSurvivor/dotfiles

"Plugin Setup {{{
call plug#begin()
  "Autocompletion
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'SirVer/ultisnips'
  " Plug 'lionawurscht/deoplete-biblatex'
  
  "General layout
  Plug 'jeffkreeftmeijer/vim-numbertoggle'
  Plug 'w0rp/ale'
  Plug 'bling/vim-airline'
  Plug 'mhinz/vim-signify'
  Plug 'luochen1990/rainbow'
  Plug 'joshdick/onedark.vim'

  "Work with stuff I do all the time
  " Plug 'sheerun/vim-polyglot'
  Plug 'petRUShka/vim-sage'

  "Quality of life
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-fugitive'
  Plug 'windwp/nvim-autopairs'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'godlygeek/tabular'

  "Interface with repls
  Plug 'jalvesaq/vimcmdline'
  
call plug#end()
"Plugin Setup ----- }}}

"Configure Plugins {{{

"Apparently colorscheme is a plugin now...
syntax on
colorscheme onedark
let g:airline_theme='onedark'


"Tabularize
"automatically align on the folowing symbols:  = , | <other>
nnoremap <leader>ae :Tabularize /=<CR>
nnoremap <leader>a, :Tabularize /,<CR>
nnoremap <leader>a- :Tabularize /-><CR>
nnoremap <leader>ac :Tabularize /&<CR>
nnoremap <leader>a  :Tabularize /


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


"Ale
let g:airline#extensions#ale#enabled=1


"deoplete
let g:deoplete#enable_at_startup = 1

let g:deoplete#max_menu_width = 0  "No max menu width

" let g:deoplete#sources#biblatex#bibfile = '~/.bib.bib'
" call deoplete#custom#source('biblatex', 'filetypes', ['tex'])
" let g:deoplete#sources#biblatex#startpattern = '\\cite{(?:[\w,]+:)?'


"UltiSnips
let g:UltiSnipsSnippetsDir = '~/.config/nvim/UltiSnips/'
let g:UltiSnipsExpandTrigger = '<TAB>'
let g:UltiSnipsJumpForwardTrigger = '<TAB>'
let g:UltiSnipsJumpBackwardTrigger = '<S-TAB>'
let g:ultisnips_python_style = 'doxygen'


"vimcmdline
let cmdline_vsplit=1
let cmdline_term_width=80

"bibtex integration
"let g:deoplete#sources#biblatex#bibfile = 'bib.bib'
"let g:deoplete#sources#biblatex#delimiter = 1

"}}}
