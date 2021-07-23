syntax on

set noerrorbells
set tabstop=4 softtabstop=4
set relativenumber
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set noswapfile
set incsearch
set encoding=UTF-8

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'

Plug 'preservim/nerdtree'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'airblade/vim-rooter'

Plug 'ryanoasis/vim-devicons'

Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'scrooloose/nerdcommenter'

"Plug 'davidhalter/jedi-vim'

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-jedi'

Plug 'tpope/vim-fugitive'

call plug#end()

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect
let g:python3_host_prog='/usr/bin/python3'

set laststatus=2
let g:python_highlight_all = 1

if exists("g:loaded_webdevicons")
    call webdevicons#refresh()
endif

let g:webdevicons_enable_nerdtree = 1

let g:fzf_layout = {'down': '30%'}

set background=dark

colorscheme gruvbox
let g:gruvbox_contrast_dark = "hard"

nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <C-p> :Files<CR>
"nnoremap <C-> :!python %<CR>
"nmap <C-s> <plug>NERDCommenterToggle
"vmap <C-s> <plug>NERDCommenterToggle

ino " ""<left>
ino ' ''<left>
ino ( ()<left>
ino [ []<left>
ino { {}<left>
