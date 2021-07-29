set encoding=utf-8
set number relativenumber
syntax enable
set noswapfile
set scrolloff=10

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent

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

" File tree explorer
Plug 'preservim/nerdtree'

" File fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Dependencies for more information in the tree
Plug 'airblade/vim-rooter'
Plug 'ryanoasis/vim-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Commenter
Plug 'scrooloose/nerdcommenter'

" Autocompletion
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'
Plug 'glepnir/lspsaga.nvim'
Plug 'hrsh7th/nvim-compe'

" Information about functions

" Status bar

" Git commands
Plug 'tpope/vim-fugitive'

" Better syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'


call plug#end()

" Avoid nerdtree icon bug
if exists("g:loaded_webdevicons")
    call webdevicons#refresh()
endif

let g:webdevicons_enable_nerdtree = 1

let g:NERDTreeMinimalUI=1

" Set colorscheme
set background=dark
colorscheme onedark

" Keyboard mappings
nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <C-p> <cmd>Telescope find_files layout_config.prompt_position=center<cr>

nmap <C-_> <plug>NERDCommenterToggle
vmap <C-_> <plug>NERDCommenterToggle

nnoremap ,py :w<CR> :!python3 %<CR>
nnoremap ,c :w<CR> :!gcc % -o executable && ./executable<CR>
nnoremap ,so :w<CR> :so %<CR>

" Activate good syntax
lua require'nvim-treesitter.configs'.setup {highlight = {enable = true}}
lua require'lspconfig'.pyright.setup{}

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
