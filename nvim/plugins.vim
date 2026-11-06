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
  
  "General layout
  Plug 'jeffkreeftmeijer/vim-numbertoggle'
  Plug 'w0rp/ale'
  Plug 'bling/vim-airline'
  Plug 'mhinz/vim-signify'
  Plug 'luochen1990/rainbow'
  Plug 'joshdick/onedark.vim'

  "Work with stuff I do all the time
  Plug 'petRUShka/vim-sage'
  Plug 'lervag/vimtex'

  "Quality of life
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-fugitive'
  Plug 'windwp/nvim-autopairs'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'godlygeek/tabular'

  "Interface with repls
  Plug 'jalvesaq/hlterm'
  
call plug#end()
"Plugin Setup ----- }}}

"Configure Plugins {{{

"Apparently colorscheme is a plugin now...
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
let g:airline_mode_map = {
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

"deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#source('_', 'max_menu_width', 0)

call deoplete#custom#var('omni', 'input_patterns', {
        \ 'tex': g:vimtex#re#deoplete
        \})

"UltiSnips
let g:UltiSnipsSnippetsDir = '~/.config/nvim/UltiSnips/'
let g:UltiSnipsExpandTrigger = '<TAB>'
let g:UltiSnipsJumpForwardTrigger = '<TAB>'
let g:UltiSnipsJumpBackwardTrigger = '<S-TAB>'
let g:ultisnips_python_style = 'doxygen'

"VimTeX
"let g:vimtex_view_method = 'zathura'          
let g:vimtex_imaps_enabled = 0 
let g:vimtex_quickfix_open_on_warning = 0     
let g:vimtex_complete_bib = { 'simple': 1 }   
let g:vimtex_format_enabled = 1

"vimcmdline
lua require("hlterm").setup({ vsplit = true })

"autopairs
lua << EOF
local npairs = require("nvim-autopairs")
local Rule   = require("nvim-autopairs.rule")
local cond   = require("nvim-autopairs.conds")

npairs.setup({ map_cr = false })   -- we define <CR> ourselves, below

-- no tick pairing in LaTeX
npairs.get_rules("`")[1].not_filetypes = { "tex" }
npairs.get_rules("'")[1].not_filetypes = { "tex" }

-- helper: this must come BEFORE the rules that call it
local function inside_inline_math(opts)
  local before = opts.line:sub(1, opts.col - 1):gsub("\\%$", "")
  local _, n = before:gsub("%$", "")
  return n % 2 == 1
end

npairs.add_rules({
  Rule("$", "$", "tex")
    :with_pair(cond.not_before_text("\\"))
    :with_pair(cond.not_after_regex("[%w%$]"))
    :with_pair(function(opts)
      if inside_inline_math(opts) then return false end
    end)
    :with_move(cond.done())
    :with_cr(cond.none()),

  Rule("\\[", "\\]", "tex")
    :with_pair(cond.not_before_text("\\\\")),
})
EOF
"}}}
