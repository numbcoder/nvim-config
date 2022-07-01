local M = {}
local keymap = vim.api.nvim_set_keymap

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

  local opts = {noremap = true, silent = true}
  keymap('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], opts)
  keymap('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], opts)
  keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], opts)
  keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], opts)
  keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], opts)
  keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], opts)
end

-- nvim-ufo
M.ufo = function()
  vim.wo.foldcolumn = '0'
  vim.wo.foldlevel = 10
  vim.wo.foldenable = true

  require('ufo').setup({
    fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local suffix = ('   %d '):format(endLnum - lnum)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0
      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, {chunkText, hlGroup})
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          -- str width returned from truncate() may less than 2nd argument, need padding
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end
      table.insert(newVirtText, {suffix, 'MoreMsg'})
      return newVirtText
    end
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

-- autopairs
M.autopairs = function()
  local npairs = require('nvim-autopairs')
  npairs.setup({
    disable_filetype = { "TelescopePrompt" },
  })
  npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
  npairs.add_rules(require('nvim-autopairs.rules.endwise-ruby'))
end

-- Comment.nvim
M.comment = function()
  require('Comment').setup({
    -- ignore empty lines
    -- ignore = '^$',
  })
end

-- dial.nvim
M.dial = function()
  local augend = require("dial.augend")
  require("dial.config").augends:register_group{
    default = {
      augend.integer.alias.decimal_int,
      augend.integer.alias.hex,
      augend.constant.alias.bool,
      augend.date.alias["%Y/%m/%d"],
      augend.date.alias["%Y-%m-%d"],
      augend.date.alias["%Y年%-m月%-d日"],
      augend.constant.new{ elements = {"blank", "present"} },
      augend.constant.new{ elements = {"asc", "desc"} },
      augend.constant.new{ elements = {"each", "map"} },
      augend.constant.new{ elements = {"&&", "||"}, word = false, },
      augend.constant.new{ elements = {"是", "否"} },
    },
  }

  local map = require("dial.map")
  local opts = {noremap = true, silent = true}
  keymap("n", "<C-a>", map.inc_normal(), opts)
  keymap("n", "<C-x>", map.dec_normal(), opts)
  keymap("v", "<C-a>", map.inc_visual(), opts)
  keymap("v", "<C-x>", map.dec_visual(), opts)
  keymap("v", "g<C-a>", map.inc_gvisual(), opts)
  keymap("v", "g<C-x>", map.dec_gvisual(), opts)
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
