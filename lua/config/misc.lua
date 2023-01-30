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
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      map('n', '<leader>lp', gs.preview_hunk)
      map('n', '<leader>lP', gs.preview_hunk_inline)
      map('n', '<leader>lb', gs.toggle_current_line_blame)
      map('n', '<leader>ld', gs.diffthis)
      map('n', '<leader>lD', function() gs.diffthis('~') end)
    end
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
  vim.wo.foldlevel = 20
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
    use_treesitter = true,
    show_current_context = true,
    max_indent_increase = 1,
    char_highlight_list = {'Whitespace'},
    context_highlight_list = {'Whitespace'},
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

-- dressing.nvim
M.dressing = function()
  require('dressing').setup({
    input = {
      relative = "editor",
      -- anchor = "NW",
      min_width = { 50, 0.3 },
    }
  })
end

-- nvim-surround
M.surround = function()
  require("nvim-surround").setup({
    keymaps = {
      normal = "sa",
      visual = "sa",
      delete = "sd",
      change = "sr",
    },
  })
end

-- olimorris/onedarkpro.nvim
M.onedarkpro = function()
  local color = require("onedarkpro.helpers")
  require("onedarkpro").setup({
    caching = true,
    plugins = {
      all = false,
      native_lsp = true,
      gitsigns = true,
      indentline = true,
      lsp_saga = true,
      nvim_cmp = true,
      nvim_notify = true,
      nvim_tree = true,
      nvim_ts_rainbow = true,
      packer = true,
      telescope = true,
      toggleterm = true,
      treesitter = true,
    },
    options = {
      bold = false,
      cursorline = true,
    },
    highlights = {
      -- editor
      CursorLineNr = { fg = "${fg}" },
      PmenuSel = { bg = color.lighten("bg", 9, "onedark_vivid") }, -- default: 0.97
      -- nvim-tree
      NvimTreeFolderIcon = { fg = "${blue}" },
      -- telescope
      TelescopeSelection = { bg = "${cursorline}", fg = "${fg}" },
      TelescopeSelectionCaret = { fg = "${blue}" },
      TelescopeMatching = { fg = "${yellow}" },
      TelescopePromptPrefix = { fg = "${blue}" },
    }
  })

  vim.cmd("colorscheme onedark_vivid")
end

-- ckolkey/ts-node-action
M.ts_node_action = function()
  vim.keymap.set("n", '<leader>k', require("ts-node-action").node_action, { desc = "Trigger Node Action" })
end

return M
