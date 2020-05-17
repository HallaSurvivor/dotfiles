" Chris Grossack's nvim settings 
" (just the plugins)
"
" See the rest of my dotfiles here:
" https://github.com/HallaSurvivor/dotfiles

"Plugin Setup {{{
set runtimepath+=/home/chris/.local/share/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('/home/chris/.local/share/dein')
  call dein#begin('/home/chris/.local/share/dein')

  "Let dein manage dein
  call dein#add('/home/chris/.local/share/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('haya14busa/dein-command.vim') "dein has REALLY bad binds

  "Autocompletion
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('SirVer/ultisnips')
  " we'll look into this another day
  "call dein#add('lionawurscht/deoplete-biblatex')
  
  "General layout
  call dein#add('jeffkreeftmeijer/vim-numbertoggle')
  call dein#add('w0rp/ale')
  call dein#add('bling/vim-airline') 
  call dein#add('mhinz/vim-signify')
  call dein#add('luochen1990/rainbow')
  call dein#add('joshdick/onedark.vim')
  call dein#add('sheerun/vim-polyglot')

  "Quality of life
  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-fugitive')
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('christoomey/vim-tmux-navigator')
  call dein#add('godlygeek/tabular')
  call dein#add('scrooloose/nerdtree')
  call dein#add('simnalamburt/vim-mundo')
  call dein#add('ervandew/supertab')

  "Haskell
  "call dein#add('neovimhaskell/haskell-vim')
  "call dein#add('eagletmt/neco-ghc')

  call dein#end()
  call dein#save_state()
endif

"Install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
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
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif

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

"}}}
