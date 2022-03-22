" Chris Grossack's nvim settings 
" (just the plugins)
"
" See the rest of my dotfiles here:
" https://github.com/HallaSurvivor/dotfiles

"Plugin Setup {{{
call plug#begin()
  "Autocompletion
  Plug 'Shougo/deoplete.nvim'
  Plug 'SirVer/ultisnips'
  
  "General layout
  Plug 'jeffkreeftmeijer/vim-numbertoggle'
  Plug 'w0rp/ale'
  Plug 'bling/vim-airline'
  Plug 'mhinz/vim-signify'
  Plug 'luochen1990/rainbow'
  Plug 'joshdick/onedark.vim'
  Plug 'sheerun/vim-polyglot'
  Plug 'petRUShka/vim-sage'

  "Quality of life
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-fugitive'
  Plug 'jiangmiao/auto-pairs'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'godlygeek/tabular'
  Plug 'scrooloose/nerdtree'
  Plug 'simnalamburt/vim-mundo'
  Plug 'ervandew/supertab'

  "Interface with repls
  Plug 'jalvesaq/vimcmdline'
  
  "Haskell
  Plug 'parsonsmatt/intero-neovim'
  Plug 'eagletmt/neco-ghc'

  "Lean
  Plug 'Julian/lean.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'hrsh7th/nvim-compe'

call plug#end()
"Plugin Setup ----- }}}

"Configure Plugins {{{

"Apparently colorscheme is a plugin now...
syntax on
colorscheme onedark
let g:airline_theme='onedark'


"nerdTree
let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI  = 1
let NERDTreeDirArrows  = 1

nnoremap <leader>n :NERDTreeToggle<CR>


"Gundo
nnoremap <leader>u :MundoToggle<CR>


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


"neco-ghc
"let g:necoghc_use_stack = 1
"let g:necoghc_enable_detailed_browse = 1


"haskell-vim
"let g:haskell_indent_disable = 1


"deoplete
let g:deoplete#enable_at_startup = 1

let g:deoplete#max_menu_width = 0  "No max menu width

let g:deoplete#sources#biblatex#bibfile = '~/.bib.bib'
call deoplete#custom#source('biblatex', 'filetypes', ['tex'])
let g:deoplete#sources#biblatex#startpattern = '\\cite{(?:[\w,]+:)?'

"Supertab
let g:SuperTabDefaultCompletionType = "<c-n>"


"UltiSnips
let g:UltiSnipsSnippetsDir = '~/.config/nvim/UltiSnips/'
let g:UltiSnipsExpandTrigger = '<TAB>'
let g:UltiSnipsJumpForwardTrigger = '<TAB>'
let g:UltiSnipsJumpBackwardTrigger = '<S-TAB>'
let g:ultisnips_python_style = 'doxygen'


"AutoPairs... I really don't like their binds
let g:AutoPairsShortcutJump=''
let g:AutoPairsShortcutFastWrap=''
let g:AutoPairsShortcutToggle=''
let g:AutoPairsMapCh=0
let g:AutoPairsCenterLine=0
let g:AutoPairsMultilineClose=0
let g:AutoPairsShortcutBackInsert=''
let g:AutoPairsMapCR=1


"Make <CR> interact with deoplete/ultisnips/autopairs properly
function! TryToExpand()
  call UltiSnips#ExpandSnippetOrJump()
  return g:ulti_expand_or_jump_res
endfunction

function! SuperCR()
  if (pumvisible())
    call deoplete#close_popup()
    if (TryToExpand() > 0)
      return ""
    endif
  endif
  return "\<CR>"
endfunction

imap <silent> <CR> <C-R>=SuperCR()<CR>


"vimcmdline
let cmdline_vsplit=1
let cmdline_term_width=80

"}}}
