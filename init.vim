if !has('nvim')
  echom "Config only applicable for neovim..."
  finish
endif


"------------------------------------"
"---------- PLUGIN MANAGER ----------"
"------------------------------------"

" If plugin not present, install it.
let plug_dir=expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(plug_dir)
  echo "Installing Vim-Plug..."
  exec "!" expand('curl') " -fLo " . shellescape(plug_dir) . " --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  " exec ":PlugInstall"
endif


call plug#begin('~/.config/nvim/plugged')

" Collection of common configurations for Neovim's built-in language server client.
Plug 'neovim/nvim-lspconfig'

" An auto completion framework that aims to provide a better completion experience with neovim's built-in LSP.
Plug 'nvim-lua/completion-nvim'

" An implementation of the Popup API from vim in Neovim.
Plug 'nvim-lua/popup.nvim'

" Library of lua functions.
Plug 'nvim-lua/plenary.nvim'

" A highly extendable fuzzy finder over lists.
Plug 'nvim-telescope/telescope.nvim'

" Wraps the Neovim treesitter API to provide functionnalities such as highlighting and incremental selection,
" and a command to easily install parsers.
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

" A light-weight and Super Fast statusline plugin.
Plug 'glepnir/galaxyline.nvim', { 'branch': 'main' }

" A lua fork of vim-devicons. This plugin provides the same icons as well as colors for each icon.
Plug 'kyazdani42/nvim-web-devicons'

" A dark theme
Plug 'dracula/vim', { 'as': 'dracula' }

" Provides mappings to easily delete, change and add such surroundings in pairs.
Plug 'tpope/vim-surround'

" Comment stuff out.
Plug 'tpope/vim-commentary'

" Fugitive is the premier Vim plugin for Git. Or maybe it's the premier Git plugin for Vim?
Plug 'tpope/vim-fugitive'

" Insert or delete brackets, parens, quotes in pair.
Plug 'jiangmiao/auto-pairs'

" Shows a git diff in the sign column.
Plug 'airblade/vim-gitgutter'

" A very fast, multi-syntax context-sensitive color name highlighter.
Plug 'ap/vim-css-color', { 'on': [] }

" An awesome automatic table creator & formatter allowing one to create neat tables as you type.
Plug 'dhruvasagar/vim-table-mode', { 'for': 'markdown' }

" Create a personal wiki using the Vim text editor.
Plug 'vimwiki/vimwiki', { 'on': [] }

"  Preview Markdown in real-time with a web browser.
Plug 'iamcco/markdown-preview.nvim', { 'on': [] }

" The interactive scratchpad for hackers.
Plug 'metakirby5/codi.vim', { 'on': [] }

" Distraction-free writing in Vim.
Plug 'junegunn/goyo.vim'

call plug#end()

command! LoadCodi execute "call plug#load('codi.vim') | Codi"
command! LoadWiki execute "call plug#load('vimwiki') | vsplit | VimwikiIndex"
command! LoadMdPreview execute "call plug#load('markdown-preview') | MardownPreview"
" command! LoadCssColors execute "call plug#load('vim-css-color')"

"--------------------------------------"
"---------- GENERAL MAPPINGS ----------"
"--------------------------------------"

let mapleader = ","
let maplocalleader = " "

" Remap j and k to scroll by visual lines
nnoremap j gj
nnoremap k gk

" Colon switch
nnoremap ; :
vnoremap ; :

" Config change
noremap <silent> <leader>e :vsp ~/.config/nvim/init.vim<CR>

" Close, save and quit
noremap <silent> <leader>d :bwipe<CR>
noremap <silent> <leader>c :close<CR>
noremap <silent> <leader>s :update<CR>
noremap <silent> <leader>q :quit<CR>
noremap <silent> Q :quit!<CR>

" Next & prev buffer
noremap <silent> gb :bnext<CR>
noremap <silent> gB :bprevious<CR>

" Split window jumps
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Vertical & horizontal split
noremap <silent> <leader>v :vsplit<CR>
noremap <silent> <leader>x :split<CR>

" Yank till end of line
nnoremap Y yg_

" Indents
nnoremap < <<
nnoremap > >>

" Blank lines
nnoremap <leader>j o<ESC>k
nnoremap <leader>k O<ESC>j

" Magic search
noremap / /\v

" Search and replace
xnoremap <leader>r :s//g<Left><Left>
nnoremap <leader>r :%s//g<Left><Left>

" Clear search highlights
noremap <silent> <localleader><CR> :nohls<CR>

" Use tab for completion selection
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


"------------------------------------"
"---------- EDITOR OPTIONS ----------"
"------------------------------------"

" Enables 24-bit RGB color in the |TUI|.
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors

" Name of the shell to use for ! and :! commands.
set shell=/bin/zsh

" Don't show mode in status line
set noshowmode

" String-encoding used internally and for |RPC| communication.
set encoding=UTF-8

" Enables mouse support for all modes
set mouse=a

" Natural splitting of windows
set splitright splitbelow

" Hybrid number line
set number relativenumber

" Case of normal letters in pattern is ignored unless capital
set ignorecase smartcase

" Convert tabs to spaces, one tab = 2 spaces, one indent = 2 spaces
set expandtab tabstop=2 shiftwidth=2

" Copy indent from previous line smartly
set smartindent autoindent

" Allows closing buffer windows without needing to save first
set hidden

" Do not create backup or swapfiles
set nobackup noswapfile nowritebackup

" Time after cursor no update after which to run autocmds
set updatetime=200

" Always show sign column beside the number line
set signcolumn=yes

" Use system clipboard for yank and delete by default
set clipboard=unnamedplus

" A comma separated list of word list names.
" When the 'spell' option is on spellchecking will be done for these languages.
set spelllang=en_us

" Shows the effects of a command incrementally, as you type, in a preview window
set inccommand=split

" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=5 sidescrolloff=5

" Number of screen lines to use for the command-line.
set cmdheight=2

" The screen will not be redrawn while executing macros, registers and other commands that have not been typed.
" Also, updating the window title is postponed.
set lazyredraw

"	Minimal number of columns to use for the line number.
set numberwidth=5

" List mode on, but hide tabs
set list listchars=tab:\ \ ,trail:·,extends:»,precedes:«

" Insert mode completion.
set completeopt=menuone,noinsert,noselect

" Don't give insert mode messages.
set shortmess+=c


"-------------------------------------------"
"---------- GENERAL AUTO COMMANDS ----------"
"-------------------------------------------"

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

function! MyHighlights() abort
  highlight Normal guibg=#1c1c1c

  highlight Todo gui=bold,italic guibg=NONE guifg=Purple
  highlight Search guibg=#a8a8a8
  highlight Trail guifg=DarkRed
  match Trail /\s\+$/

  highlight DiffAdd guibg=#254035 guifg=NONE gui=NONE
  highlight DiffDelete guibg=#440000 guifg=NONE gui=NONE
  highlight DiffChange guibg=#292929 guifg=NONE gui=NONE
  highlight DiffText guibg=#252525 guifg=orange gui=underline
endfunction


"-----------------------------------"
"---------- GLOBAL VALUES ----------"
"-----------------------------------"

let $PATH="/Users/pritesh/.nvm/versions/node/v14.5.0/bin:" . $PATH
let g:python3_host_prog = "/usr/local/bin/python3"
let g:loaded_python_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0


"-------------------------------------"
"---------- PLUGIN SETTINGS ----------"
"-------------------------------------"

" Completion
imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)

" Telescope
nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files({
      \ previewer = false,
      \ prompt_title = "Files" })<cr>

nnoremap <C-s> <cmd>lua require('telescope.builtin').live_grep({
      \ previewer = false,
      \ prompt_title = "Grep" })<cr>

" Goyo
let g:goyo_width = 120
let g:goyo_height = 90

noremap <silent> <leader><CR> :Goyo<CR>

" Vimwiki
let g:vimwiki_list = [{ 'path': '~/MEGAsync/notes/private', 'syntax': 'markdown', 'ext': '.md' }]
let g:vimwiki_global_ext = 0

" Fugitive
nnoremap <silent> <localleader>s :G<CR>
nnoremap <silent> <localleader>d :Gvdiffsplit<CR>

let g:fugitive_no_maps = 1

" Netrw
let g:netrw_banner = 0 " Hide banner
let g:list_style = 1 "long listing one file per line with time stamp information and file size


"------------------------------"
"---------- LUA CODE ----------"
"------------------------------"

" See lua/init.lua
lua require("init")


"------------------------------------"
"---------- OTHER SETTINGS ----------"
"------------------------------------"

colorscheme dracula

" When on, ":autocmd", shell and write commands are not allowed in .nvimrc and .exrc in the current directory
" and map commands are displayed.
set secure
