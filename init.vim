if !has('nvim')
  echom "Config only applicable for neovim..."
  finish
endif

source $HOME/.config/nvim/modules/plugin.vim

source $HOME/.config/nvim/modules/options.vim

source $HOME/.config/nvim/modules/autocmds.vim

source $HOME/.config/nvim/modules/mappings.vim

source $HOME/.config/nvim/modules/globals.vim

lua require("m_telescope")

lua require("m_treesitter")

lua require("m_lsp")

lua require("m_galaxyline")

source $HOME/.config/nvim/plugin_modules/telescope.vim

source $HOME/.config/nvim/plugin_modules/goyo.vim

source $HOME/.config/nvim/plugin_modules/vimwiki.vim

source $HOME/.config/nvim/plugin_modules/fugitive.vim

colorscheme dracula
