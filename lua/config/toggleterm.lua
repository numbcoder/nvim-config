require("toggleterm").setup{
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
}

local Terminal  = require('toggleterm.terminal').Terminal
local rails_console = Terminal:new({
  cmd = "rails console",
  on_open = function(term)
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", [[<C-\>]], "<cmd>close<CR>", {noremap = true, silent = true})
  end,
})

function _rails_console_toggle()
  rails_console:toggle()
end
vim.api.nvim_set_keymap("n", [[<leader>\]], "<cmd>lua _rails_console_toggle()<CR>", {noremap = true, silent = true})
