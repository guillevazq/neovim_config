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
Plug 'unkiwii/vim-nerdtree-sync'

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

" HTML Emmet
Plug 'mattn/emmet-vim'

call plug#end()

let g:nerdtree_sync_cursorline = 1

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

" Exit vim if nerdtree is the only window left
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Enable emmet only for css and html files
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" lua require "lsp_signature".setup()

" Avoid nerdtree icon bug
if exists("g:loaded_webdevicons")
    call webdevicons#refresh()
endif

let g:webdevicons_enable_nerdtree = 1
let g:NERDTreeMinimalUI=1
let g:NERDTreeMinimalMenu=1
let g:NERDTreeWinSize=31

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
            width = 0.85,
            height = 0.5,
            prompt_position = "top",
            preview_width = 0.6;
        },
      }
    }

EOF

source $HOME/.config/nvim/plug-config/coc.vim
