```vim
if !has('nvim')
  echom "Config only applicable for neovim..."
  finish
endif

let plug_dir=expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(plug_dir)
  echo "Installing Vim-Plug..."
  exec "!" expand('curl') " -fLo " . shellescape(plug_dir) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
endif

let eviline=expand('~/.config/nvim/eviline.lua')
if !filereadable(eviline)
  echo "Downloading eviline.lua..."
  exec "!" expand('curl') . " -fLo " . shellescape(eviline) . " https://raw.githubusercontent.com/glepnir/galaxyline.nvim/main/example/eviline.lua"
endif

if has('termguicolors')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  set termguicolors
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'glepnir/galaxyline.nvim', { 'branch': 'main' }
Plug 'kyazdani42/nvim-web-devicons'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color'
Plug 'dhruvasagar/vim-table-mode'
Plug 'vimwiki/vimwiki'
" Plug 'npxbr/glow.nvim'
call plug#end()


" TODO Add this to "after" folder and use gui colors
function! MyHighlights() abort
  highlight DraculaDiffDelete guifg=#870000 guibg=#000

  highlight Normal guibg=Black
  highlight link Function DraculaCyan

  highlight Todo gui=italic guibg=Black guifg=Purple
  highlight jsObjectKey gui=italic
  highlight Search guibg=248 guibg=#a8a8a8

  highlight DiffAdd guibg=236
  highlight DiffChange guibg=236
  highlight DiffText guibg=236 guifg=215

  highlight GitGutterAdd guifg=#009900 guifg=2
  highlight link GitGutterChange DraculaOrange
  highlight GitGutterDelete guifg=#ff2222 guifg=1

  highlight Trail guifg=DarkRed
  match Trail /\s\+$/
endfunction


set noshowmode
set encoding=UTF-8
set mouse=a
set splitright splitbelow
set number relativenumber
set ignorecase smartcase
set expandtab tabstop=2 shiftwidth=2
set smartindent autoindent
set hidden
set nobackup noswapfile nowritebackup
set updatetime=100
set signcolumn=yes
set clipboard=unnamedplus
set spelllang=en
set inccommand=split " Show substitution while on it
set scrolloff=5 sidescrolloff=5
set cmdheight=2
set lazyredraw
set numberwidth=5
set list listchars=tab:\ \ ,trail:·,extends:»,precedes:«
set completeopt=menuone,noinsert,noselect

" COMMANDS ------------- {{{

" Blink yanked text
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

" Set custom highlights
augroup MyColors
  autocmd!
  autocmd ColorScheme * call MyHighlights()
augroup END

" }}}

" MAPPINGS ------------- {{{

let mapleader = ","
let maplocalleader = " "

" Remap j and k to scroll by visual lines
nnoremap j gj
nnoremap k gk

" Colon switch
nnoremap ; :
vnoremap ; :

" Quick config change and reloads
noremap <silent> <leader>e :vsp ~/.config/nvim/init.vim<CR>

" Quick save and quit
noremap <silent> <leader>s :update<CR>
noremap <silent> <leader>q :quit<CR>
noremap <silent> <leader>Q :quit!<CR>

" Quick next prev buffer
noremap <silent> gb :bnext<CR>
noremap <silent> gB :bprevious<CR>

" Quick split window jumps
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Quick split
noremap <silent> <leader>v :vsplit<CR>

" Quick close buffer
noremap <silent> <leader>d :bwipe<CR>
noremap <silent> <leader>c :close<CR>

" Quick blank lines
noremap <leader>j o<ESC>k
noremap <leader>k O<ESC>j

" Magic search
noremap / /\v

" Quick Search and replace
xnoremap <leader>r :s/
nnoremap <leader>r :%s/

" Clear search highlights
noremap <silent> <localleader><CR> :nohls<CR>

" Find files using Telescope command-line sugar.
nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files({ previewer = false })<cr>
nnoremap <C-s> <cmd>lua require('telescope.builtin').live_grep({ previewer = false })<cr>

" Completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"  }}}


" GLOBALS ------------- {{{

let $PATH="/Users/pritesh/.nvm/versions/node/v14.5.0/bin:" . $PATH

let g:vimwiki_list = [
      \ { 'path': '~/MEGAsync/notes/private', 'syntax': 'markdown', 'ext': '.md'},
      \ { 'path': '~/MEGAsync/notes', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0

let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

"  }}}

luafile ~/.config/nvim/eviline.lua

luafile ~/.config/nvim/setup.lua

colorscheme dracula
```
