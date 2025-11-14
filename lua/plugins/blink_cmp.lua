return {
  'saghen/blink.cmp',
  version = '1.*',
  opts = {
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = {
      preset = 'super-tab',
      -- ["<Tab>"] = {
      --   function(cmp)
      --     if vim.b[vim.api.nvim_get_current_buf()].nes_state then
      --       cmp.hide()
      --       return (
      --         require("copilot-lsp.nes").apply_pending_nes()
      --         and require("copilot-lsp.nes").walk_cursor_end_edit()
      --       )
      --     else
      --       return cmp.select_and_accept()
      --     end
      --   end,
      --   "fallback",
      -- },
      -- ["<Tab>"] = {
      --   function(cmp) -- sidekick next edit suggestion
      --     if require("sidekick.nes").have() then
      --       cmp.hide()
      --       return require("sidekick").nes_jump_or_apply()
      --     else
      --       return cmp.select_and_accept()
      --     end
      --   end,
      --   "fallback",
      -- },
    },


    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = {
      keyword = { range = 'full' },
      trigger = { prefetch_on_insert = false },
      list = { max_items = 20 },
      accept = { },
      menu = {
        draw = {
          -- treesitter = { "lsp" },
        },
      },
      documentation = { auto_show = true },
      ghost_text = { enabled = true },
    },
    signature = { enabled = true },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'buffer', 'copilot' },
      -- default = { 'lsp', 'path', 'buffer', 'minuet' },
      -- default = { 'lsp', 'path', 'buffer'},
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
        },
        -- minuet = {
        --   name = 'minuet',
        --   module = 'minuet.blink',
        --   async = true,
        --   -- Should match minuet.config.request_timeout * 1000,
        --   -- since minuet.config.request_timeout is in seconds
        --   timeout_ms = 5000,
        --   score_offset = 50, -- Gives minuet higher priority among suggestions
        -- },
      },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" },
  dependencies = {
    {
      "copilotlsp-nvim/copilot-lsp",
      enabled = false,
      init = function()
        vim.g.copilot_nes_debounce = 500
        vim.lsp.enable("copilot_ls")
        vim.keymap.set("n", "<tab>", function()
          -- Try to jump to the start of the suggestion edit.
          -- If already at the start, then apply the pending suggestion and jump to the end of the edit.
          local _ = require("copilot-lsp.nes").walk_cursor_start_edit()
          or (
          require("copilot-lsp.nes").apply_pending_nes() and require("copilot-lsp.nes").walk_cursor_end_edit()
        )
        end)
      end,
    },
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      enabled = true,
      opts = {
        suggestion = { enabled = false },
        panel = { enabled = false },
        disable_limit_reached_message = true,
      },
    },
    {
      "fang2hou/blink-copilot",
      enabled = true,
      opts = {
        max_completions = 2,
      }
    }
  },
}
