nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files({
      \ previewer = false,
      \ prompt_title = "Find File" })<cr>

nnoremap <C-s> <cmd>lua require('telescope.builtin').live_grep({
      \ previewer = false,
      \ prompt_title = "Search String" })<cr>
