" PLUGINS ---------- {{{ 

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" NEOVIM
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" VIM
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin('~/.vim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-repeat'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/goyo.vim'
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color'
Plug 'dhruvasagar/vim-table-mode'
Plug 'vimwiki/vimwiki'
Plug 'itchyny/calendar.vim'
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

" TODO Add this to "after" folder
function! MyHighlights() abort
  highlight DraculaDiffDelete ctermfg=088 ctermbg=Black guifg=#870000 guibg=#000

  highlight Normal ctermbg=Black
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

"  }}}

" CUSTOM DEFAULTS ------------- {{{

set mouse=a
set splitright splitbelow
set number relativenumber
set ignorecase smartcase
set expandtab tabstop=2 shiftwidth=2
set smartindent autoindent
set hidden
set nobackup noswapfile nowritebackup
set updatetime=100
set shortmess+=c
set signcolumn=yes
set clipboard=unnamedplus
set spelllang=en
set inccommand=split " Show substitution while on it
set scrolloff=5 sidescrolloff=5
set cmdheight=2
set lazyredraw
set numberwidth=5
set list listchars=tab:\ \ ,trail:·,extends:»,precedes:«
set shada+=<100 " TODO Check more options for faster startup
set nomodeline
set conceallevel=2
" set nowrapscan " Search hit bottom

augroup filetypes
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType css set omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,xhtml setl omnifunc=htmlcomplete#CompleteTags
  autocmd BufEnter *.md setl syntax=markdown
  autocmd BufEnter /private/tmp/scratch setl buftype=nofile
augroup END

" Quick note
command! -nargs=0 Temp :vsp /tmp/scratch

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

" Quick nerdtree window
noremap <silent> <leader>z :NERDTreeToggle<CR>

" Magic search
noremap / /\v

" Quick Search and replace
xnoremap <leader>r :s/
nnoremap <leader>r :%s/

" Clear search highlights TODO: Change to something with leader
noremap <silent> <localleader><CR> :nohls<CR>

" Git Fugitive
nnoremap <silent> <localleader>s :Gstatus<CR>

" GOYO
noremap <silent> <leader><CR> :Goyo<CR>

" Commentary
" TODO

" COC
noremap <silent> <C-p> :CocList files<CR>
noremap <silent> <C-s> :CocList grep<CR>

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>n <Plug>(coc-rename)

" Applying codeAction to the selected region.
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" Formatting selected code.
xmap <silent> <leader>f  <Plug>(coc-format-selected)
nmap <silent> <leader>f  <Plug>(coc-format-selected)

augroup COCGroup
  autocmd!
  autocmd FileType typescript,javascript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
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

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

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

let $PATH="/Users/pritesh/.nvm/versions/node/v14.5.0/bin:" . $PATH

" Providers
let g:python_host_prog = "/usr/bin/python2"
let g:python3_host_prog = "/usr/bin/python3"
let g:node_host_prog = "/Users/pritesh/.npm-global/lib/node_modules/neovim/bin/cli.js"
let g:ruby_host_prog = "/Users/pritesh/gems/bin/neovim-ruby-host"

" Goyo
let g:goyo_width = 120
let g:goyo_height = 100

" Gitgutter
" let g:gitgutter_enabled = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_sign_column_always = 1
let g:gitgutter_sign_added = '▐'
let g:gitgutter_sign_modified = '▐'
let g:gitgutter_sign_removed = '▂'
let g:gitgutter_escape_grep = 1
let g:gitgutter_max_signs = 1500
let g:gitgutter_preview_win_floating = 1

let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-prettier',
  \ 'coc-eslint',
  \ 'coc-yank',
  \ 'coc-lists',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-markdownlint',
  \ 'coc-scssmodules',
  \ 'coc-vimlsp'
  \ ]
  "\ 'coc-snippets',

" Airline
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_section_z = ''
let g:airline_section_c = ' '
let g:airline_skip_empty_sections = 1

" Vimwiki
let g:vimwiki_list = [
      \ { 'path': '~/MEGAsync/private', 'syntax': 'markdown', 'ext': '.md'},
      \ { 'path': '~/MEGAsync', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0

" Calendar
let g:calendar_task = 0
" TODO Attach to google
" let g:calendar_google_calendar = 1
" let g:calendar_google_task = 1


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

" NODE_OUTPUT --------- {{{

function! ShowNodeResult()
  let op = system("node", bufnr())
  let win = bufwinnr("__NODE_OUTPUT__")

  if win == -1
    vsplit __NODE_OUTPUT__
    setlocal buftype=nofile
  else
    exe win . "wincmd w"
    normal! ggdG
  endif

  call append(0, split(op, '\v\n'))
endfunction

" TODO
" augroup nodeOP
"   autocmd!
"   autocmd BufLeave __NODE_OUTPUT__ execute('bd! ' . win)
" augroup end

command! -nargs=0 Node :call ShowNodeResult()

" }}}

set secure
