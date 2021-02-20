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
