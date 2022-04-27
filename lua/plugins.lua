-- boostrap packer on a new machine
--[[
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
end
--]]

-- impatient needs to be setup before any other lua plugin is loaded
vim.cmd [[packadd impatient.nvim]]
require('impatient')

-- defer fire User PackLoad event
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  once = true,
  callback = function()
    vim.defer_fn(function()
      vim.api.nvim_exec_autocmds("User", {pattern = "PackLoad"})
    end, 5)
  end,
})

vim.cmd [[packadd packer.nvim]]

require('packer').startup({function(use)
  -- Packer can manage itself
  use { 'wbthomason/packer.nvim' }
  use { 'lewis6991/impatient.nvim' }
  use { 'nvim-lua/plenary.nvim' }

  use {
    'kyazdani42/nvim-web-devicons',
    config = [[require('config.devicons')]],
  }

  use {
    'famiu/feline.nvim',
    wants = {'nvim-web-devicons'},
    config = [[require('config.statusline').setup()]],
    event = 'User PackLoad',
  }

  use {
    'akinsho/bufferline.nvim',
    wants = { 'nvim-web-devicons' },
    config = [[require('config.bufferline')]],
    event = 'User PackLoad',
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    requires = { {'p00f/nvim-ts-rainbow'} },
    run = ':TSUpdate',
    config = [[require('config.treesitter')]],
    event = 'User PackLoad'
  }

  use {
    'kyazdani42/nvim-tree.lua',
    wants = { 'nvim-web-devicons' },
    config = [[require('config.nvim-tree')]],
    cmd = {'NvimTreeToggle', 'NvimTreeFindFileToggle'}
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-telescope/telescope-fzf-native.nvim', run = "make" },
    },
    wants = {
      'plenary.nvim',
      'telescope-fzf-native.nvim',
    },
    cmd = "Telescope",
    config = [[require('config.telescope')]],
  }

  use { "hrsh7th/nvim-cmp", config = [[require('config.cmp')]], event = 'User PackLoad' }
  use { "hrsh7th/cmp-path", after = "nvim-cmp" }
  use { "hrsh7th/cmp-cmdline", after = "nvim-cmp" }
  use { 'tzachar/cmp-tabnine', run = './install.sh', after = "nvim-cmp" }

  use {
    "dcampos/cmp-snippy",
    requires = {
      'dcampos/nvim-snippy',
      'honza/vim-snippets',
    },
    after = "nvim-cmp"
  }

  use { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" }
  use { "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" }
  use { "hrsh7th/cmp-nvim-lsp-document-symbol", after = "nvim-cmp" }
  use { "neovim/nvim-lspconfig", after = "cmp-nvim-lsp" }
  use { 'tami5/lspsaga.nvim', config = [[require('config.lsp')]], after = 'nvim-lspconfig' }

  use { 'windwp/nvim-autopairs', config = [[require('config.misc').autopairs()]], after = 'nvim-treesitter' }
  use {
    'lewis6991/gitsigns.nvim',
    wants = { 'plenary.nvim' },
    config = [[require('config.misc').gitsigns()]],
    event = 'User PackLoad'
  }

  use {
    'monaqa/dial.nvim',
    keys = {{'n', '<C-a>'}, {'n', '<C-x>'}},
    config = [[require('config.misc').dial()]]
  }

  use {
    'numToStr/Comment.nvim',
    keys = {'gcc', 'gbc'},
    config = [[require('config.misc').comment()]]
  }
  -- use { 'github/copilot.vim' }

  use { 'kdheepak/lazygit.nvim', cmd = 'LazyGit' }
  use { 'pechorin/any-jump.vim', cmd = 'AnyJump' }
  use { 'dyng/ctrlsf.vim', cmd = 'CtrlSF' }

  use { 'machakann/vim-sandwich', keys = {{'n', 's'}, {'v', 's'}} }
  use { 'mg979/vim-visual-multi', keys = {'<C-n>'} }
  use {
    'kevinhwang91/nvim-hlslens',
    keys = {'n', '/', '*'},
    config = [[require('config.misc').hlslens()]],
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    event = "User PackLoad",
    config = [[require('config.misc').indent_blankline()]],
  }
  use { 'ntpeters/vim-better-whitespace', event = 'User PackLoad' }

  -- use 'joshdick/onedark.vim'
  -- use {
  --   'ful1e5/onedark.nvim',
  --   diable = true,
  --   config = [[require('config.misc').theme_setup()]],
  -- }

  -- lang
  use { 'vim-ruby/vim-ruby', ft = 'ruby' }
  use { 'plasticboy/vim-markdown', ft = 'markdown' }
end,
config = {
  auto_clean = false,
  opt_default = true,
  display = {
    open_fn = require('packer.util').float,
  }
}})

