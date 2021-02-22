" Telescope

nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files({
      \ previewer = false,
      \ prompt_title = "Files" })<cr>

nnoremap <C-s> <cmd>lua require('telescope.builtin').live_grep({
      \ previewer = false,
      \ prompt_title = "Grep" })<cr>

nnoremap <C-g> <cmd>lua require('telescope.builtin').builtin({
      \ previewer = false,
      \ prompt_title = "Git Status" })<cr>

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

