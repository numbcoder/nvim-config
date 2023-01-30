local lspconfig = require('lspconfig')
local keymap = vim.keymap.set

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local opts = {noremap = true, silent = true, buffer = bufnr}
  -- Set some key bindings conditional on server capabilities
  if client.server_capabilities.documentFormattingProvider then
    vim.keymap.set("n", "<space>==", function() vim.lsp.buf.format({async = true}) end, opts)
  end
  if client.server_capabilities.documentRangeFormattingProvider then
    vim.keymap.set("v", "<space>==", vim.lsp.buf.range_formatting, opts)
  end

  vim.api.nvim_create_augroup('lsp_attach_group', {})
  -- highlight symbol under cursor
  -- if client.server_capabilities.documentHighlightProvider then
  --   vim.api.nvim_create_autocmd('CursorHold', {
  --     group = 'lsp_attach_group',
  --     buffer = 0,
  --     callback = vim.lsp.buf.document_highlight,
  --   })
  --   vim.api.nvim_create_autocmd('CursorMoved', {
  --     group = 'lsp_attach_group',
  --     buffer = 0,
  --     callback = vim.lsp.buf.clear_references,
  --   })
  -- end

  -- show diagnostic
  vim.api.nvim_create_autocmd("CursorHold", {
    group = "lsp_attach_group",
    buffer = bufnr,
    command = "Lspsaga show_line_diagnostics",
  })
end

-- diagnostic
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
})
local signs = { Error = "✗", Warn = "▵", Hint = "ﯦ", Info = "●" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- fold
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

-- lsp flags
local lsp_flags = {
  debounce_text_changes = 300,
}

-- ruby lsp
lspconfig.solargraph.setup({
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
})

-- local theme_colors = require("onedarkpro.helpers").get_colors()
-- lspsaga
require('lspsaga').setup({
  ui = {
    border = "rounded",
    diagnostic = '  ',
    -- colors = {
    --   --float window normal bakcground color
    --   normal_bg = theme_colors.float_bg,
    --   --title background color
    --   title_bg = theme_colors.gray,
    --   red = theme_colors.red,
    --   magenta = theme_colors.magenta,
    --   orange = theme_colors.orange,
    --   yellow = theme_colors.yellow,
    --   green = theme_colors.green,
    --   cyan = theme_colors.cyan,
    --   blue = theme_colors.blue,
    --   purple = theme_colors.purple,
    --   white = theme_colors.white,
    --   black = theme_colors.black,
    -- },
  },
  symbol_in_winbar = {
    enable = false
  },
  -- diagnostic_header = {"✗", "▵", "", "●"},
  -- max_preview_lines = 30,
  finder = {
    edit = { 'o', '<CR>' },
    vsplit = 'v',
    split = 'x',
    tabe = 't',
    quit = { 'q', '<ESC>' },
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
keymap({"n", "t"}, "<leader>t", "<cmd>Lspsaga term_toggle<CR>")
