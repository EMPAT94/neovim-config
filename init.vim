let plug_dir=expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(plug_dir)
  echo "Installing Vim-Plug..."
  echo ""
  exec "!" expand('curl') " -fLo " . shellescape(plug_dir) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
endif

let eviline=expand('~/.config/nvim/eviline.lua')
if !filereadable(eviline)
  echo "Downloading eviline.lua..."
  exec "!" expand('curl') . " -fLo " . shellescape(eviline) . " https://raw.githubusercontent.com/glepnir/galaxyline.nvim/main/example/eviline.lua"
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
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color'
Plug 'dhruvasagar/vim-table-mode'
Plug 'vimwiki/vimwiki'
call plug#end()


luafile ~/.config/nvim/eviline.lua

" TODO Add this to "after" folder and use gui colors
function! MyHighlights() abort
  highlight DraculaDiffDelete ctermfg=088 ctermbg=Black guifg=#870000 guibg=#000

  highlight Normal guibg=Black
  highlight link Function DraculaCyan

  highlight Todo cterm=italic ctermbg=Black ctermfg=125
  highlight jsObjectKey cterm=italic
  highlight Search ctermbg=248 guibg=#a8a8a8

  highlight DiffAdd ctermbg=236
  highlight DiffChange ctermbg=236
  highlight DiffText ctermbg=236 ctermfg=215

  highlight GitGutterAdd guifg=#009900 ctermfg=2
  highlight link GitGutterChange DraculaOrange
  highlight GitGutterDelete guifg=#ff2222 ctermfg=1

  highlight Trail ctermfg=DarkRed
  match Trail /\s\+$/
endfunction

augroup MyColors
  autocmd!
  autocmd ColorScheme * call MyHighlights()
augroup END

colorscheme dracula

if has('termguicolors')
  set termguicolors
endif

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

augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

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
noremap <silent> <leader>t :tabnew<CR>

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
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>

"  }}}


" GLOBALS ------------- {{{

let $PATH="/Users/pritesh/.nvm/versions/node/v14.5.0/bin:" . $PATH

let g:vimwiki_list = [
      \ { 'path': '~/MEGAsync/private', 'syntax': 'markdown', 'ext': '.md'},
      \ { 'path': '~/MEGAsync', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0

"  }}}

:lua << EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
}
EOF
" :TSInstall maintained

:lua << EOF
  local nvim_lsp = require('lspconfig')
  local on_attach = function(client, bufnr)
  require('completion').on_attach()
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>n', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=red guibg=Grey
      hi LspReferenceText cterm=bold ctermbg=red guibg=Grey
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=Grey
    ]], false)
  end
end

-- Use a loop to conveniently both setup defined servers 
-- and map buffer local keybindings when the language server attaches
local servers = { "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end
EOF

" Completion
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
