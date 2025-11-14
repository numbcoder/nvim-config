return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
  init = function()
    local ensure_installed = {
      'diff',
      'dockerfile',
      'fish',
      'python',
      'javascript',
      'typescript',
      'json',
      'ruby',
    }

    local already_installed = require("nvim-treesitter.config").get_installed()
    local to_install = vim.iter(ensure_installed)
      :filter(function(parser) return not vim.tbl_contains(already_installed, parser) end)
      :totable()
    if #to_install > 0 then require('nvim-treesitter').install(to_install) end

    -- Ensure tree-sitter enabled after opening a file for target language
    local filetypes = {}
    for _, lang in ipairs(ensure_installed) do
      for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
        table.insert(filetypes, ft)
      end
    end

    -- WARN: Do not use "*" here
    vim.api.nvim_create_autocmd('FileType', {
      desc = 'Start treesitter',
      group = vim.api.nvim_create_augroup('start_treesitter', { clear = true }),
      pattern = filetypes,
      callback = function(ctx)
        -- syntax highlighting
        vim.treesitter.start(ctx.buf)
        -- folds, provided by Neovim
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        -- indentation, provided by nvim-treesitter
        vim.bo[ctx.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}

