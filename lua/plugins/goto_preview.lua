-- https://github.com/rmagatti/goto-preview
return {
  "rmagatti/goto-preview",
  dependencies = { "rmagatti/logger.nvim" },
  event = "BufEnter",
  config = true,
  opts = {
    default_mappings = true,
  }
}
