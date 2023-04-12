local lspconfig = require('lspconfig')
local keymap = vim.keymap.set

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local opts = {noremap = true, silent = true, buffer = bufnr}
    -- Set some key bindings conditional on server capabilities
    if client.server_capabilities.documentFormattingProvider then
      keymap("n", "<space>==", function() vim.lsp.buf.format({async = true}) end, opts)
    end
    if client.server_capabilities.documentRangeFormattingProvider then
      keymap("v", "<space>==", vim.lsp.buf.range_formatting, opts)
    end
    if client.server_capabilities.definitionProvider then
      vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
    end

    -- highlight symbol under cursor
    -- if client.server_capabilities.documentHighlightProvider then
    --   vim.api.nvim_create_autocmd('CursorHold', {
    --     group = 'UserLspConfig',
    --     buffer = bufnr,
    --     callback = vim.lsp.buf.document_highlight,
    --   })
    --   vim.api.nvim_create_autocmd('CursorMoved', {
    --     group = 'UserLspConfig',
    --     buffer = bufnr,
    --     callback = vim.lsp.buf.clear_references,
    --   })
    -- end

    -- show diagnostic
    vim.api.nvim_create_autocmd("CursorHold", {
      group = "UserLspConfig",
      buffer = bufnr,
      command = "Lspsaga show_line_diagnostics ++unfocus",
    })
  end,
})

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
-- capabilities.textDocument.foldingRange = {
--   dynamicRegistration = false,
--   lineFoldingOnly = true
-- }

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

