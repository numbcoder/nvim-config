return {
  'akinsho/toggleterm.nvim',
  opts = {
    -- size can be a number or function which is passed the current terminal
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<c-\>]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = true,
    direction = 'float',
    close_on_exit = true, -- close the terminal window when the process exits
    shell = vim.o.shell, -- change the default shell
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
      border = 'curved',
      width = function(term) return math.ceil(vim.o.columns * 0.7) end,
      height = function(term) return math.ceil(vim.o.lines * 0.8) end,
    }
  },
  keys = {
    {"<leader>t", "<cmd>lua float_terminal:toggle()<CR>", mode = {"n"}, desc = "Toggle float terminal"},
    {"<leader>rc", "<cmd>lua rails_console_terminal:toggle()<CR>", mode = {"n"}, desc = "Toggle Rails console"},
  },
  config = function()
    local Terminal  = require('toggleterm.terminal').Terminal

    rails_console_terminal = Terminal:new({
      cmd = "bin/rails console",
      direction = "float",
    })

    float_terminal = Terminal:new({
      direction = "float",
    })
  end,
}
