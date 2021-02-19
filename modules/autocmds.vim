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
  highlight Normal guibg=Black
  highlight link Function DraculaCyan

  highlight Todo gui=italic guibg=Black guifg=Purple
  highlight jsObjectKey gui=italic
  highlight Search guibg=248 guibg=#a8a8a8

  highlight DiffAdd guibg=236
  highlight DiffChange guibg=236
  highlight DiffText guibg=236 guifg=215
  highlight DraculaDiffDelete guifg=#870000 guibg=#000

  highlight GitGutterAdd guifg=#009900 
  highlight link GitGutterChange DraculaOrange
  highlight GitGutterDelete guifg=#ff2222 guifg=1

  highlight Trail guifg=DarkRed
  match Trail /\s\+$/
endfunction
