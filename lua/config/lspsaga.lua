local keymap = vim.keymap.set

require('lspsaga').setup({
  ui = {
    title = false,
    border = "rounded",
  },
  diagnostic = {
    on_insert = false,
  },
  symbol_in_winbar = {
    enable = false
  },
  -- diagnostic_header = {"✗", "▵", "", "●"},
  -- max_preview_lines = 30,
  finder = {
    keys = {
      edit = { 'o', '<CR>' },
      vsplit = 'v',
      split = 'x',
      tabe = 't',
      quit = { 'q', '<ESC>' },
    },
  },
})

-- lspsaga keymap
-- Lsp finder find the symbol definition implement reference
keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

-- Code action
keymap({"n","v"}, "gx", "<cmd>Lspsaga code_action<CR>")

-- Rename
keymap("n", "gr", "<cmd>Lspsaga rename<CR>")

-- Peek Definition
keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>")

-- Go to Definition
-- keymap("n","gd", "<cmd>Lspsaga goto_definition<CR>")
keymap("n", "gd", function() require('telescope.builtin').lsp_definitions({jump_type = 'vsplit'}) end)

-- show_line_diagnsotic float window unfocus
keymap("n", "go", "<cmd>Lspsaga show_line_diagnostics<CR>")

-- Diagnsotic jump can use `<c-o>` to jump back
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

-- Outline
keymap("n","<leader>o", "<cmd>Lspsaga outline<CR>")
-- Hover Doc
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")
-- Float terminal
keymap({"n", "t"}, "<C-L>", "<cmd>Lspsaga term_toggle<CR>")
