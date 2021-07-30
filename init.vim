set encoding=utf-8
set number relativenumber
syntax enable
set noswapfile
set scrolloff=10

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab


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

call plug#begin('~/.vim/plugged')

" Color schemes
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'lifepillar/vim-solarized8'

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

" Commenter
Plug 'tpope/vim-commentary'

" Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Plug 'kabouzeid/nvim-lspinstall'
" Plug 'glepnir/lspsaga.nvim'
" Plug 'hrsh7th/nvim-compe'

" Information about functions

" Status bar

" Git commands
Plug 'tpope/vim-fugitive'

" Better syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" Function information
" Plug 'ray-x/lsp_signature.nvim'
" Self closing tags
Plug 'jiangmiao/auto-pairs'

call plug#end()

" lua require "lsp_signature".setup()

" Avoid nerdtree icon bug
if exists("g:loaded_webdevicons")
    call webdevicons#refresh()
endif

let g:webdevicons_enable_nerdtree = 1
let g:NERDTreeMinimalUI=1
let g:NERDTreeMinimalMenu=1
let g:NERDTreeWinSize=26

nmap <C-_> gcc
vmap <C-_> gcc<Esc>

" Set colorscheme
set background=dark
colorscheme onedark

" Keyboard mappings (VSCode shortcuts)
nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <C-p> <cmd>Telescope find_files layout_config.prompt_position=center<cr>

" Run files
nnoremap ,py :w<CR> :!python3 %<CR>
nnoremap ,c :w<CR> :!gcc % -o executable && ./executable<CR>
nnoremap ,so :w<CR> :so %<CR>

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
            width = 0.5,
            height = 0.4,
            prompt_position = "top",
            preview_width = 0.7;
        },
      }
    }
EOF

source $HOME/.config/nvim/plug-config/coc.vim
