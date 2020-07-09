" PLUGINS ---------- {{{ 

call plug#begin('~/.vim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/goyo.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovimhaskell/haskell-vim'
Plug 'tpope/vim-repeat'
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
" Tired of netrw bugs
Plug 'preservim/nerdtree' 
call plug#end()

" }}} 

" COLORS ------------- {{{

" Get highlight group of word under cursor
" function! <SID>SynStack()
"   if !exists("*synstack")
"     return
"   endif
"   echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
" endfunc
" nnoremap <leader><leader> :call <SID>SynStack()<CR>

function! MyHighlights() abort
  highlight Normal ctermbg=Black
  highlight Todo cterm=italic ctermbg=Black ctermfg=125
  highlight jsObjectKey cterm=italic
  highlight link jsFuncArgs DraculaOrange
endfunction

augroup MyColors
  autocmd!
  autocmd ColorScheme * call MyHighlights()
augroup END

colorscheme dracula

"  }}}

" CUSTOM DEFAULTS ------------- {{{ 

set mouse=a
set splitright splitbelow
set relativenumber
set ignorecase smartcase
set expandtab tabstop=2 shiftwidth=2
set smartindent
set hidden
set nobackup noswapfile nowritebackup
set updatetime=300
set shortmess+=c
set signcolumn=yes
set clipboard=unnamed
set spelllang=en
" set spell " To check spellings
set inccommand=split " Show substitution while on it"
set list listchars=trail:·

" Yanked text highlight
" augroup LuaHighlight
"   autocmd!
"   autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
" augroup END

augroup filetypeVim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

"  }}}

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
noremap <leader>e :vsp ~/.config/nvim/init.vim<CR>
noremap <leader>r :source ~/.config/nvim/init.vim<CR>

"k Quick save and quit
noremap <leader>w :w<CR>
noremap <leader>q :q<CR>
noremap <leader>Q :q!<CR>

" Quick split window jumps
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Quick close buffer
noremap <leader>d :bd<CR>

" Quick blank lines
noremap <leader>j o<ESC>k
noremap <leader>k O<ESC>j

" Quick start/end of line
nnoremap B ^
nnoremap E g_

" Quick nerdtree window
noremap <silent> <leader>z :NERDTreeToggle<CR>

" Magic search
noremap / /\v

" Clear search highlights TODO: Change to something with leader
noremap <silent> <localleader><CR> :nohls<CR>

" FZF
noremap <C-p> :Files<CR>
noremap <C-b> :Buffers<CR>
noremap <C-s> :Rg 

" GOYO
noremap <silent> <leader><CR> :Goyo<CR>

" Commentary
" TODO

" COC
inoremap <silent><expr> <C-space> coc#refresh()

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col
endfunction

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>n <Plug>(coc-rename)

" Formatting selected code.
xmap <silent> <leader>f  <Plug>(coc-format-selected)
nmap <silent> <leader>f  <Plug>(coc-format-selected)

augroup COCGroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')
augroup end

" Introduce function and class text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
" command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" }}}

" GLOBALS ------------- {{{

"FZF
let g:fzf_buffers_jump = 1
let g:fzf_preview_window = ''

" Goyo
let g:goyo_width = 120
let g:goyo_height = 100

" COC
let g:coc_node_path = "/Users/pritesh/.nvm/versions/node/v14.5.0/bin/node"

" Airline
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_section_z = '%l'

" }}}

 " NEOVIM DEFAULTS ------------ {{{

" Syntax highlighting is enabled by default
" ":filetype plugin indent on" is enabled by default
" 'autoindent' is enabled
" 'autoread' is enabled
" 'background' defaults to "dark" (unless set automatically by the terminal/UI)
" 'backspace' defaults to "indent,eol,start"
" 'backupdir' defaults to .,~/.local/share/nvim/backup (|xdg|)
" 'belloff' defaults to "all"
" 'compatible' is always disabled
" 'complete' excludes "i"
" 'cscopeverbose' is enabled
" 'directory' defaults to ~/.local/share/nvim/swap// (|xdg|), auto-created
" 'display' defaults to "lastline,msgsep"
" 'encoding' is UTF-8 (cf. 'fileencoding' for file-content encoding)
" 'fillchars' defaults (in effect) to "vert:│,fold:·"
" 'formatoptions' defaults to "tcqj"
" 'fsync' is disabled
" 'history' defaults to 10000 (the maximum)
" 'hlsearch' is enabled
" 'incsearch' is enabled
" 'langnoremap' is enabled
" 'langremap' is disabled
" 'laststatus' defaults to 2 (statusline is always shown)
" 'listchars' defaults to "tab:> ,trail:-,nbsp:+"
" 'nrformats' defaults to "bin,hex"
" 'ruler' is enabled
" 'sessionoptions' excludes "options"
" 'shortmess' includes "F", excludes "S"
" 'showcmd' is enabled
" 'sidescroll' defaults to 1
" 'smarttab' is enabled
" 'tabpagemax' defaults to 50
" 'tags' defaults to "./tags;,tags"
" 'ttimeoutlen' defaults to 50
" 'ttyfast' is always set
" 'undodir' defaults to ~/.local/share/nvim/undo (|xdg|), auto-created
" 'viminfo' includes "!"
" 'wildmenu' is enabled
" 'wildoptions' defaults to "pum,tagfile"
" The |man.vim| plugin is enabled, to provide the |:Man| command.

"  }}}
