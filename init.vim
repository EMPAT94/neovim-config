if !has('nvim')
  echom "Config only applicable for neovim..."
  finish
endif

source $HOME/.config/nvim/modules/mappings.vim

if exists('g:vscode')
  finish
endif

source $HOME/.config/nvim/modules/vim-plug.vim

source $HOME/.config/nvim/modules/options.vim

source $HOME/.config/nvim/modules/autocmds.vim

source $HOME/.config/nvim/modules/globals.vim

source $HOME/.config/nvim/modules/plugins.vim

lua require("init")

colorscheme dracula
