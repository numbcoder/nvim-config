local lspconfig = require('lspconfig')

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
    group = 'lsp_attach_group',
    buffer = bufnr,
    callback = require('lspsaga.diagnostic').show_line_diagnostics,
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
  debounce_text_changes = 400,
}

-- ruby lsp
lspconfig.solargraph.setup({
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
})

-- lspsaga
require('lspsaga').init_lsp_saga{
  border_style = "rounded",
  diagnostic_header = {"✗", "▵", "", "●"},
  max_preview_lines = 30,
  finder_action_keys = {
    open = "o",
    vsplit = "v",
    split = "x",
    quit = "q",
    scroll_down = "<C-f>",
    scroll_up = "<C-b>",
  },
}

-- lspsaga keymap
local opts = {noremap = true, silent = true}
vim.keymap.set("n", "gh", require("lspsaga.finder").lsp_finder, opts)
vim.keymap.set("n", "gd", function() require('telescope.builtin').lsp_definitions({jump_type = 'vsplit'}) end, opts)
vim.keymap.set("n", "gp", require("lspsaga.definition").peek_definition, opts)
vim.keymap.set("n", "gr", require("lspsaga.rename").lsp_rename, opts)
vim.keymap.set("n", "gx", require("lspsaga.codeaction").code_action, opts)
vim.keymap.set("v", "gx", function()
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
  require("lspsaga.codeaction").range_code_action()
end, opts)
vim.keymap.set("n", "K",  require("lspsaga.hover").render_hover_doc, opts)
vim.keymap.set("n", "go", require("lspsaga.diagnostic").show_line_diagnostics, opts)
vim.keymap.set("n", "gj", require("lspsaga.diagnostic").goto_next, opts)
vim.keymap.set("n", "gk", require("lspsaga.diagnostic").goto_prev, opts)
vim.keymap.set("n", "<C-d>", function() require('lspsaga.action').smart_scroll_with_saga(1) end, opts)
vim.keymap.set("n", "<C-u>", function() require('lspsaga.action').smart_scroll_with_saga(-1) end, opts)
