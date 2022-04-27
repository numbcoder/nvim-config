-- Disable some built-in plugins we don't want
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit",
}

for _, plugin in pairs(disabled_built_ins) do
   vim.g["loaded_" .. plugin] = 1
end

-- disable filetype.vim
vim.g.did_load_filetypes = 0
-- enable filetype.lua
vim.g.do_filetype_lua = 1
vim.filetype.add({
  extension = {
    axlsx = 'ruby',
  },
})

require('plugins')

-- onedark highlight
-- https://github.com/navarasu/onedark.nvim
require('highlight').setup()

