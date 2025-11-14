local colors = {
   white = "#abb2bf",
   darker_black = "#1b1f27",
   black = "#1e222a", --  nvim bg
   black2 = "#252931",
   one_bg = "#282c34", -- real bg of onedark
   one_bg2 = "#353b45",
   one_bg3 = "#30343c",
   grey = "#42464e",
   grey_fg = "#565c64",
   grey_fg2 = "#6f737b",
   light_grey = "#6f737b",
   red = "#d47d85",
   baby_pink = "#DE8C92",
   pink = "#ff75a0",
   line = "#2a2e36", -- for lines like vertsplit
   green = "#A3BE8C",
   vibrant_green = "#7eca9c",
   nord_blue = "#81A1C1",
   blue = "#61afef",
   yellow = "#e7c787",
   sun = "#EBCB8B",
   purple = "#b4bbc8",
   dark_purple = "#c882e7",
   teal = "#519ABA",
   orange = "#fca2aa",
   cyan = "#a3b8ef",
   statusline_bg = "#22262e",
   lightbg = "#2d3139",
   lightbg2 = "#262a32",
   pmenu_bg = "#A3BE8C",
   folder_bg = "#61afef",
}

require('bufferline').setup {
  options = {
    numbers = "none",
    close_command = "bdelete! %d",
    right_mouse_command = "vertical sbuffer %d",
    left_mouse_command = function(buf_id)
      local win_ids = vim.fn.win_findbuf(buf_id)
      if win_ids[1] then
        vim.fn.win_gotoid(win_ids[1])
      else
        vim.cmd(string.format("tabe %s", vim.api.nvim_buf_get_name(buf_id)))
        -- vim.cmd(string.format("vertical sbuffer %d", buf_id))
      end
    end,
    middle_mouse_command = nil,
    indicator = {
      icon = '▎',
      style = 'icon',
    },
    buffer_close_icon = ' 󰖭',
    modified_icon = ' ',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    -- display buffer group by tabpage
    -- custom_filter = function(buf_id)
    --   return vim.tbl_contains(vim.fn.tabpagebuflist(), buf_id)
    -- end,
    max_name_length = 20,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 15,
    diagnostics = false,
    offsets = {{filetype = 'NvimTree', text = 'File Explorer', highlight = 'Directory'}},
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    separator_style = 'thin',
    enforce_regular_tabs = false,
    always_show_bufferline = false,
    sort_by = "tabs",
  },
  highlights = {
    background = {
      fg = colors.grey_fg,
      bg = colors.black2,
    },

    -- buffers
    buffer_selected = {
      fg = colors.white,
      bg = colors.black,
      bold = true,
      italic = false,
    },
    buffer_visible = {
      fg = colors.light_grey,
      bg = colors.black2,
    },

    -- close buttons
    close_button = {
      fg = colors.light_grey,
      bg = colors.black2,
    },
    close_button_visible = {
      fg = colors.light_grey,
      bg = colors.black2,
    },
    close_button_selected = {
      fg = colors.light_grey,
      bg = colors.black,
    },
    fill = {
      fg = colors.grey_fg,
      bg = colors.black2,
    },
    indicator_selected = {
      fg = colors.blue,
      bg = colors.black,
    },

    -- modified
    modified = {
      fg = colors.red,
      bg = colors.black2,
    },
    modified_visible = {
      fg = colors.red,
      bg = colors.black2,
    },
    modified_selected = {
      fg = colors.green,
      bg = colors.black,
    },

    -- separators
    separator = {
      fg = colors.black2,
      bg = colors.black2,
    },
    separator_visible = {
      fg = colors.black2,
      bg = colors.black2,
    },
    separator_selected = {
      fg = colors.black2,
      bg = colors.black2,
    },
    -- tabs
    tab = {
      fg = colors.light_grey,
      bg = colors.one_bg3,
    },
    tab_selected = {
      fg = colors.black2,
      bg = colors.nord_blue,
    },
    tab_close = {
      fg = colors.light_grey,
      bg = colors.black,
    },
  }
}

-- keymaps
vim.keymap.set({'n', 'i', 'v'}, '<D-j>', '<ESC>:BufferLineCycleNext<CR>')
vim.keymap.set({'n', 'i', 'v'}, '<D-k>', '<ESC>:BufferLineCyclePrev<CR>')
