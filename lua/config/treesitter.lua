require'nvim-treesitter.configs'.setup {
  ensure_installed = {"ruby", "javascript", "json", "lua"},
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
    disable = { "ruby" }
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "+",
      node_incremental = "J",
      node_decremental = "K",
      scope_incremental = "+",
    },
  },
  -- nvim-ts-rainbow
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = 500, -- Do not enable for files with more than 500 lines, int
    colors = {
      "#e86671",
      "#d19a66",
      "#e5c07b",
      "#98c379",
      "#56b6c2",
      "#61afef",
      "#c678dd"
    }
  },
}
