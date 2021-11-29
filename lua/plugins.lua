-- boostrap packer on a new machine
--[[
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
end
--]]

local M = {}
-- fire PackLoad event
vim.cmd [[au VimEnter * ++once lua require('plugins').pack_load()]]
vim.cmd [[packadd packer.nvim]]

require('packer').startup({function(use)
  -- Packer can manage itself
  use { "wbthomason/packer.nvim", event = 'User PackLoad' }

  use {
    "nathom/filetype.nvim",
    config = [[require('config.misc').filetype()]],
    event = 'User PackLoad',
  }

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
    ft = {'ruby', 'javascript', 'json', 'lua'}
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = "make" },
      { 'fannheyward/telescope-coc.nvim' },
    },
    wants = {
        'plenary.nvim',
        'telescope-coc.nvim',
        'telescope-fzf-native.nvim',
      },
    cmd = "Telescope",
    config = [[require('config.telescope')]],
  }

  use {
    'neoclide/coc.nvim',
    requires = { 'honza/vim-snippets' },
    branch = 'release',
    event = 'User PackLoad'
  }
  use {
    'github/copilot.vim',
    event = 'User PackLoad'
  }

  use { 'kdheepak/lazygit.nvim', cmd = 'LazyGit' }
  use { 'pechorin/any-jump.vim', cmd = 'AnyJump' }
  use { 'dyng/ctrlsf.vim', cmd = 'CtrlSF' }

  use { 'tpope/vim-commentary', keys = {'gcc'} }
  use { 'bootleq/vim-cycle', keys = {{'n', '<C-a>'}, {'n', '<C-x>'}} }
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

-- defer fire PackLoad event
M.pack_load = function()
  vim.defer_fn(function()
    vim.cmd [[doautocmd User PackLoad]]
  end, 5)
end

return M

