local lspconfig = require('lspconfig')
local util = require('util')
local keymap = vim.keymap.set

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(args)
    local buf = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local opts = {noremap = true, silent = true, buffer = buf}
    -- Set some key bindings conditional on server capabilities
    -- if client.server_capabilities.documentFormattingProvider then
    --   keymap("n", "<space>==", function() vim.lsp.buf.format({async = true}) end, opts)
    -- end
    -- if client.server_capabilities.documentRangeFormattingProvider then
    --   keymap("v", "<space>==", vim.lsp.buf.range_formatting, opts)
    -- end
    if client:supports_method("textDocument/definition") then
      vim.bo[buf].tagfunc = "v:lua.vim.lsp.tagfunc"
    end

    -- enable inlay hint
    if client:supports_method("textDocument/inlayHint") then
      vim.lsp.inlay_hint.enable(true, {bufnr = buf})
    end

    -- disable treesitter highlight if lsp has semanticTokens capability
    -- if client.server_capabilities.semanticTokensProvider then
    --   vim.cmd("TSBufDisable highlight")
    --   vim.treesitter.stop(buf)
    --   vim.bo[buf].syntax = 'off'
    -- end

    -- highlight symbol under cursor
    -- if client.server_capabilities.documentHighlightProvider then
    --   vim.api.nvim_create_autocmd('CursorHold', {
    --     group = 'UserLspConfig',
    --     buffer = buf,
    --     callback = vim.lsp.buf.document_highlight,
    --   })
    --   vim.api.nvim_create_autocmd('CursorMoved', {
    --     group = 'UserLspConfig',
    --     buffer = buf,
    --     callback = vim.lsp.buf.clear_references,
    --   })
    -- end

    -- show diagnostic
    vim.api.nvim_create_autocmd("CursorHold", {
      group = "UserLspConfig",
      buffer = buf,
      callback = util.debounce(function()
        vim.diagnostic.open_float()
      end, 1200),
    })
  end,
})

-- diagnostic
vim.diagnostic.config({
  underline = true,
  -- virtual_lines = { current_line = true },
  signs = {
     text = {
      [vim.diagnostic.severity.ERROR] = '✗',
      [vim.diagnostic.severity.WARN] = '▵',
      [vim.diagnostic.severity.HINT] = '󰛨',
      [vim.diagnostic.severity.INFO] = '●',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
      [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
      [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
    },
  },
  float = {
    border = "rounded",
    focusable = false,
		scope = 'line',
  },
  update_in_insert = false,
  severity_sort = true,
})


-- fold
-- capabilities.textDocument.foldingRange = {
--   dynamicRegistration = false,
--   lineFoldingOnly = true
-- }

-- lsp default config
vim.lsp.config('*', {
  flags = {
    debounce_text_changes = 400,
  }
})

vim.lsp.config('ruby_lsp', {
  -- flags = lsp_flags,
  init_options = {
    enabledFeatures = {
      semanticHighlighting = false,
    },
    experimentalFeaturesEnabled = true,
    formatter = 'auto'
  },
})
-- vim.lsp.config('solargraph', {
--     flags = lsp_flags,
-- })
local ruby_version = vim.version.parse(vim.fn.system({'ruby', '--version'}), {strict=false})
if vim.version.gt(ruby_version, {3, 0, 0}) then
  vim.lsp.enable('ruby_lsp')
else
  vim.lsp.enable('solargraph')
end

-- json lsp
vim.lsp.enable('jsonls')

-- pyrefly
-- vim.lsp.config('pyrefly', {
--   flags = lsp_flags,
-- })
vim.lsp.enable('pyrefly')

-- ruff
vim.lsp.config('ruff', {
  flags = lsp_flags,
  on_attach = function(client, bufnr)
    -- Disable hover in favor of Pyright
    client.server_capabilities.hoverProvider = false
  end,
})
vim.lsp.enable('ruff')
