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
    'feline-nvim/feline.nvim',
    dependencies = 'nvim-web-devicons',
    config = function() require('config.statusline').setup() end,
    event = 'VeryLazy',
  },

  {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-web-devicons',
    config = function() require('config.bufferline') end,
    event = 'VeryLazy',
  },

  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = 'mrjones2014/nvim-ts-rainbow',
    build = ':TSUpdate',
    config = function() require('config.treesitter') end,
    event = 'VeryLazy'
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
    dependencies = 'hrsh7th/cmp-nvim-lsp',
    config = function() require('config.lsp') end,
    event = 'BufReadPost',
  },

  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = "make" },
    },
    config = function() require('config.telescope') end,
    keys = {
      { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "find files" },
      { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "find files" },
      { "<leader>g", "<cmd>Telescope live_grep<cr>", desc = "live greps" },
      { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "find buffers" },
    },
    cmd = "Telescope",
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-nvim-lsp-document-symbol",
      -- { 'tzachar/cmp-tabnine', build = './install.sh' },
      { "jcdickinson/codeium.nvim", opts = {} },
      { 'saadparwaiz1/cmp_luasnip', dependencies = 'L3MON4D3/LuaSnip' },
      'windwp/nvim-autopairs',
    },
    config = function() require('config.cmp') end,
    event = 'InsertEnter'
  },

  -- snippets
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip").filetype_extend("ruby", {"rails"})
      require("luasnip").setup( {
        history = true,
        delete_check_events = "TextChanged",
      })
    end
  },

  {
    'glepnir/lspsaga.nvim',
    dependencies = 'nvim-lspconfig',
    config = function() require('config.lspsaga') end,
    event = 'LspAttach'
  },

  {
    'windwp/nvim-autopairs',
    dependencies = 'nvim-treesitter',
    config = function() require('config.misc').autopairs() end,
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
    keys = {'gcc', 'gbc'},
    config = function() require('config.misc').comment() end,
  },

  {
    'kdheepak/lazygit.nvim',
    keys = { { '<leader>lg', ':LazyGit<CR>', desc = 'Open LazyGit' } },
    cmd = 'LazyGit'
  },

  { 'pechorin/any-jump.vim', cmd = 'AnyJump' },
  { 'dyng/ctrlsf.vim', cmd = 'CtrlSF' },

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
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    config = function() require('config.misc').indent_blankline() end,
    event = "VeryLazy",
  },

  { 'ntpeters/vim-better-whitespace', event = 'BufReadPost' },

  {
    'rcarriga/nvim-notify',
    config = function() vim.notify = require("notify") end,
    event = 'VeryLazy',
  },

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

  -- lang
  { 'vim-ruby/vim-ruby', ft = 'ruby' },
}

