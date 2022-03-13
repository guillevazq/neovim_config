set encoding=utf-8
set number relativenumber
syntax enable
set noswapfile
set scrolloff=10

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set ic

autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType python set sts=4

set nobackup
set nowritebackup
set updatetime=300

set autoindent
set fileformat=unix
set guicursor=
set nohlsearch
set hidden
set noerrorbells
set nowrap
set noswapfile
set incsearch
set signcolumn=yes
set cindent
set splitright

if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
                               
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>'           " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-d>'           " replace visual C-n

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use ? to show documentation in preview window.
nnoremap <silent> ? :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Add (Neo)Vim's native statusline support.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

call plug#begin('~/.vim/plugged')

" Color schemes
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'lifepillar/vim-solarized8'
Plug 'shaunsingh/nord.nvim'
Plug 'crusoexia/vim-monokai'

" File tree explorer (not show full path)
Plug 'preservim/nerdtree'

" File fuzzy finder (add borders)
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Dependencies for more information in the tree
Plug 'airblade/vim-rooter'
Plug 'ryanoasis/vim-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'unkiwii/vim-nerdtree-sync'

" Commenter
Plug 'tpope/vim-commentary'

" Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Git commands
Plug 'tpope/vim-fugitive'

" Better syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" Function information
" Plug 'ray-x/lsp_signature.nvim'
" Self closing tags
Plug 'jiangmiao/auto-pairs'

" HTML
Plug 'mattn/emmet-vim'

" Multicursor
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Gitignore highlighting
Plug 'gisphm/vim-gitignore'

" Custom snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()

let g:nerdtree_sync_cursorline = 1
let NERDTreeShowHidden=1

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

" Exit vim if nerdtree is the only window left
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Enable emmet only for css and html files
" let g:user_emmet_install_global = 0
" autocmd FileType html,css EmmetInstall

" lua require "lsp_signature".setup()

" Avoid nerdtree icon bug
if exists("g:loaded_webdevicons")
    call webdevicons#refresh()
endif

let g:webdevicons_enable_nerdtree = 1
let g:NERDTreeMinimalUI=1
let g:NERDTreeMinimalMenu=1
let g:NERDTreeWinSize=32

nmap <C-_> gcc
vmap <C-_> gcc<Esc>

" Set colorscheme
set background=dark
colorscheme gruvbox

" Keyboard mappings (VSCode shortcuts)
nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <C-p> <cmd>Telescope find_files layout_config.prompt_position=center<cr>

" Run files
nnoremap ,py :w<CR> :!python %<CR>
nnoremap ,C :w<CR> :!gcc % -o executable && ./executable<CR>
nnoremap ,c :w<CR> :!g++ % -o executable && ./executable<CR>
nnoremap ,n :w<CR> :!gnome-terminal -- bash -c "g++ % -o executable && ./executable"<CR>
nnoremap ,so :w<CR> :so %<CR><C-w><C-w>

" Activate good syntax
lua require'nvim-treesitter.configs'.setup {highlight = {enable = true}}

" Customize telescope
lua << EOF
require('telescope').setup {
    defaults = {
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        dynamic_preview_title = true,
        border = true,
        mappings = {
            i = {
                ["<esc>"] = require('telescope.actions').close,
            }
        },
        layout_config = {
            width = 0.85,
            height = 0.7,
            prompt_position = "top",
            preview_width = 0.6;
        },
      }
    }

EOF

let g:UltiSnipsEditSplit = "vertical"

autocmd BufNewFile *.cpp r ~/.config/nvim/custom_cpp_snippets/template.cpp
source $HOME/.config/nvim/plug-config/coc.vim
