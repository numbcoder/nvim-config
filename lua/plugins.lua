-- plugins
return {
  "folke/lazy.nvim",
  'nvim-lua/plenary.nvim',

  {
    'nvim-tree/nvim-web-devicons',
    config = function() require('config.devicons') end,
  },

  {
    "olimorris/onedarkpro.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function() require('config.misc').onedarkpro() end,
  },

  {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-web-devicons',
    config = function() require('config.bufferline') end,
    event = 'VeryLazy',
  },

  {
    'HiPhish/rainbow-delimiters.nvim',
    config = function() require('config.misc').rainbow() end,
    event = 'BufReadPost',
  },

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = 'nvim-web-devicons',
    config = function() require('config.nvim-tree') end,
    keys = { {'<leader>p', ':NvimTreeFindFileToggle<CR>', desc = 'NvimTreeFindFileToggle'} },
    cmd = {'NvimTreeToggle', 'NvimTreeFindFileToggle'}
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = { 'saghen/blink.cmp' },
    -- dependencies = 'hrsh7th/cmp-nvim-lsp',
    config = function() require('config.lsp') end,
    event = 'VeryLazy',
  },

  {
    'windwp/nvim-autopairs',
    dependencies = 'nvim-treesitter',
    config = function() require('config.misc').autopairs() end,
    event = "InsertEnter",
  },

  { "utilyre/sentiment.nvim", opts = {}, event = 'VeryLazy' },

  {
    'lewis6991/gitsigns.nvim',
    dependencies = 'plenary.nvim',
    config = function() require('config.misc').gitsigns() end,
    event = 'VeryLazy'
  },

  {
    'monaqa/dial.nvim',
    keys = { '<C-a>', '<C-x>' },
    config = function() require('config.misc').dial() end
  },

  {
    'ckolkey/ts-node-action',
    dependencies = 'nvim-treesitter',
    keys = { '<leader>k' },
    config = function() require('config.misc').ts_node_action() end,
  },

  {
    'numToStr/Comment.nvim',
    keys = {'gcc', 'gbc', "<D-/>"},
    config = function() require('config.misc').comment() end,
  },

  { 'pechorin/any-jump.vim', cmd = 'AnyJump' },

  { 'mg979/vim-visual-multi', keys = { {'<C-n>', mode = {'n', 'v'} } } },

  {
    'kylechui/nvim-surround',
    keys = { {'s', mode = {'n', 'v'} } },
    config = function() require('config.misc').surround() end,
  },

  {
    'kevinhwang91/nvim-hlslens',
    keys = {'n', '/', '*'},
    config = function() require('config.misc').hlslens() end,
  },

  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    config = function() require('config.misc').ufo() end,
    keys = {'za', 'zR', 'zM', '<Tab>', 'zm'},
    enabled = false
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    config = function() require('config.misc').indent_blankline() end,
    event = "VeryLazy",
  },

  { 'ntpeters/vim-better-whitespace', event = 'BufReadPost' },

  {
    'NvChad/nvim-colorizer.lua',
    ft = {'css', 'html', 'lua'},
    cmd = 'ColorizerToggle',
    opts = {},
  },

  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    config = function() require('config.misc').dressing() end,
  },

  {
    "chrisgrieser/nvim-early-retirement",
    opts = { retirementAgeMins = 60 },
    enabled = false,
    event = "VeryLazy",
  },


  {
    'jinh0/eyeliner.nvim',
    event = 'BufReadPost',
    opts = { highlight_on_key = true,  dim = true },
  },

  {
    "hat0uma/csvview.nvim",
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  },
  {
    'mvllow/modes.nvim',
    event = 'VeryLazy',
  },

  -- lang
  -- { 'vim-ruby/vim-ruby', ft = 'ruby' },
}

