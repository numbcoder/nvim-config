local M = {}

-- filetype
M.filetype = function()
  local ft = require('filetype')
  ft.setup({
    overrides = {
      extensions = {
        rake = 'ruby',
        axlsx = 'ruby',
      },
    }
  })
  ft.resolve()
end

-- gitsigns
M.gitsigns = function()
  require('gitsigns').setup {
    signs = {
      add = { hl = 'GitGutterAdd', text = '│', numhl = 'GitGutterAdd' },
      change = { hl = 'GitGutterChange', text = '│', numhl = 'GitGutterChange' },
      delete = { hl = 'GitGutterDelete', text = '│', numhl = 'GitGutterDelete' },
      topdelete = { hl = 'GitGutterDelete', text = '│', numhl = 'GitGutterDelete' },
      changedelete = { hl = 'GitGutterChangeDelete', text = '│', numhl = 'GitGutterChangeDelete' },
    },
    keymaps = {},
  }
end

-- hlslens
M.hlslens = function()
  require('hlslens').setup({
    calm_down = true,
  })
end

-- indent_blankline
M.indent_blankline = function()
  require("indent_blankline").setup {
    char = '┊',
    filetype_exclude = {'help', 'coc-explorer', 'terminal', 'packer'},
    max_indent_increase = 1,
    show_first_indent_level = false,
    show_trailing_blankline_indent = false,
  }
end

--[[
M.theme_setup = function()
  require('onedark').setup({
    keywordStyle = "NONE",
    sidebars = {'coc-explorer'},
  })
end
--]]

return M
