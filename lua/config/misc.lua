local M = {}

-- filetype
M.filetype = function()
  local ft = require('filetype')
  ft.setup({
    overrides = {
      extensions = {
        axlsx = 'ruby',
      },
    }
  })
  ft.resolve()
  vim.cmd [[
    augroup filetypedetect
      au!
      au BufNewFile,BufRead * lua require('filetype').resolve()
    augroup END
  ]]
end

-- gitsigns
M.gitsigns = function()
  require('gitsigns').setup({
    signs = {
      add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
      change       = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
      delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
      topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
      changedelete = {hl = 'GitSignsChange', text = '≃', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    },
  })
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
    filetype_exclude = {'help', 'NvimTree', 'terminal', 'packer'},
    max_indent_increase = 1,
    show_first_indent_level = false,
    show_trailing_blankline_indent = false,
  }
end

-- indent_blankline
M.autopairs = function()
  local npairs = require('nvim-autopairs')
  npairs.setup({
    disable_filetype = { "TelescopePrompt" },
  })
  npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
  npairs.add_rules(require('nvim-autopairs.rules.endwise-ruby'))
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
