call plug#begin()

Plug 'sickill/vim-monokai'
Plug 'joshdick/onedark.vim'
Plug 'https://gitlab.com/protesilaos/tempus-themes-vim.git'
Plug 'vim-scripts/CycleColor'

Plug 'itchyny/lightline.vim'

Plug 'ap/vim-buftabline'

Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdtree-project-plugin'
Plug 'PhilRunninger/nerdtree-visual-selection'

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'tpope/vim-fugitive'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'mattn/emmet-vim'

Plug 'tpope/vim-commentary'

Plug 'Yggdroot/indentLine'

call plug#end()

let g:lightline = {'colorscheme': 'onedark'}
colorscheme onedark

set hidden
nnoremap <C-T> :bprev<CR>
nnoremap <C-Y> :bnext<CR>

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
let NERDTreeMinimalUI=1
let g:NERDTreeWinSize=28
let NERDTreeShowHidden=1
noremap <C-b> :NERDTreeToggleVCS<CR>

if (has("termguicolors"))
    set termguicolors
endif

set encoding=utf-8
set showmatch
set tabstop=2
set shiftwidth=2
set expandtab
set noshowmode
set laststatus=2
set incsearch
set guicursor=i:block
syntax enable
set nohlsearch
set splitright
set number

lua << EOF
require'lspconfig'.tsserver.setup{}

require'nvim-treesitter.configs'.setup{ensure_installed = {"javascript", "typescript", "html", "css"}, sync_install = false, highlight = {enable = true}, indent = {enable = true}}

require('telescope').setup{defaults = {file_ignore_patterns = {"node_modules"}, 
  layout_strategy='vertical',
  layout_config={
    anchor="N", width=0.5, prompt_position='top', mirror=true, height=0.25, preview_cutoff=100
  },
  sorting_strategy="ascending",
}}
EOF

let g:user_emmet_mode="n"
let g:user_emmet_leader_key=","
let g:user_emmet_settings={'javascript': {'extends': 'jsx'}}

noremap <C-_> :Commentary<CR>
noremap <C-p> <cmd>Telescope find_files<cr>

set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['tsserver'].setup {
    capabilities = capabilities
  }
EOF

" autocmd BufEnter * lua require'completion'.on_attach()

inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
