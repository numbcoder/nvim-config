return {
  "folke/snacks.nvim",
  opts = {
    bigfile = { enabled = true },
    notifier = { enabled = true },
    lazygit = { enabled = true },
    picker = {
      layouts = {
        default = {
          layout = {
            box = "horizontal",
            width = 0.7,
            min_width = 120,
            height = 0.75,
            {
              box = "vertical",
              border = true,
              title = "{title} {live} {flags}",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
            },
            { win = "preview", title = "{preview}", border = true, width = 0.6 },
          },
        }
      },
      matcher = {
        frecency = true,
        history_bonus = true,
      }

    }
  },
  keys = {
    { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
    { "<C-p>", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<D-p>", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>b", function() Snacks.picker.buffers() end, desc = "Find Buffers" },
    { "<D-b>", function() Snacks.picker.buffers() end, desc = "Find Buffers" },
    { "<D-S-p>", function() Snacks.picker.commands() end, desc = "Commands" },
    { "<D-f>", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>fl>", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>fg", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "x" } },
    { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
    -- LSP
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    { "gai", function() Snacks.picker.lsp_incoming_calls() end, desc = "C[a]lls Incoming" },
    { "gao", function() Snacks.picker.lsp_outgoing_calls() end, desc = "C[a]lls Outgoing" },
    { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    -- lazygit
    { "<leader>lg", function() Snacks.lazygit.open() end, desc = "Open lazygit" },
    -- git
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
  },

}
