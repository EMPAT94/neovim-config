""""""""""""""""""""""""""""""
""""""""""" PLUGINS """"""""""
""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/goyo.vim'
call plug#end()




""""""""""""""""""""""""""""""
""""""""""" DEFAULTS """""""""
""""""""""""""""""""""""""""""

colorscheme dracula
set mouse=a
set splitright splitbelow
set relativenumber
set ignorecase smartcase
set expandtab tabstop=2 shiftwidth=2
set autoindent smartindent
set hidden
set nobackup noswapfile




""""""""""""""""""""""""""""""
""""""""""" MAPPINGS """""""""
""""""""""""""""""""""""""""""

let mapleader = ","
let maplocalleader = " "

" remap j and k to scroll by visual lines
nnoremap j gj
nnoremap k gk

" Colon switch
nnoremap ; :

" Quick config change and reloads
noremap <leader>e :vsp ~/.config/nvim/init.vim<CR>
noremap <leader>r :source ~/.config/nvim/init.vim<CR>

" Quick save and quit
noremap <leader>w :w<CR>
noremap <leader>q :q<CR>
noremap <leader>Q :q!<CR>

" Quick split window jumps
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Clear highlights TODO: Change to something with leader
noremap <localleader><CR> :nohls<CR>

" FZF
noremap <C-p> :Files<CR>

" GOYO
noremap <silent> <leader><CR> :Goyo<CR>

" Commentary
" TODO


""""""""""""""""""""""""""""""
""""""""""" GLOBALS """""""""
""""""""""""""""""""""""""""""

" FZF [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" Goyo
let g:goyo_width = 120
let g:goyo_height = 100
