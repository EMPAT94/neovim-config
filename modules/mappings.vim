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

" Next prev buffer
noremap <silent> gb :bnext<CR>
noremap <silent> gB :bprevious<CR>

" Split window jumps
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Vertical split
noremap <silent> <leader>v :vsplit<CR>

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

" Completion
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Manually trigger completion
imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)
