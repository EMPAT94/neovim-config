nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files({
      \ previewer = false,
      \ prompt_title = "Files" })<cr>

nnoremap <C-s> <cmd>lua require('telescope.builtin').live_grep({
      \ previewer = false,
      \ prompt_title = "Grep" })<cr>

nnoremap <C-g> <cmd>lua require('telescope.builtin').builtin({
      \ previewer = false,
      \ prompt_title = "Git Status" })<cr>

