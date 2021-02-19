require('telescope').setup {
  defaults = {
    layout_strategy = "vertical",
    mappings = { i = { ["<esc>"] = require('telescope.actions').close }, },
  }
}

