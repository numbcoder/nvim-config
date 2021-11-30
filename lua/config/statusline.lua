local lsp = require 'feline.providers.lsp'
local vi_mode_utils = require 'feline.providers.vi_mode'
local file = require 'feline.providers.file'

local M = {}

local colors = {
  -- bg = '#353b45',
  bg = '#21252b',
  fg = '#abb2bf',
  fg_dark = "#798294",
  yellow = '#e0af68',
  cyan = '#56b6c2',
  darkblue = '#081633',
  green = '#98c379',
  orange = '#d19a66',
  violet = '#a9a1e1',
  magenta = '#c678dd',
  blue = '#61afef',
  red = '#e06c75'
}

local vi_mode_colors = {
  NORMAL = colors.red,
  INSERT = colors.green,
  VISUAL = colors.magenta,
  LINES = colors.magenta,
  OP = colors.green,
  BLOCK = colors.blue,
  REPLACE = colors.violet,
  ['V-REPLACE'] = colors.violet,
  ENTER = colors.cyan,
  MORE = colors.cyan,
  SELECT = colors.orange,
  COMMAND = colors.green,
  SHELL = colors.green,
  TERM = colors.green,
  NONE = colors.yellow
}

local icons = {
  linux = ' ',
  macos = ' ',
  windows = ' ',

  errs = ' ',
  warns = ' ',
  infos = ' ',
  hints = ' ',

  lsp = '',
}

local function file_os_info()
  local os = vim.bo.fileformat:upper()
  local icon
  if os == 'UNIX' then
    icon = icons.linux
  elseif os == 'MAC' then
    icon = icons.macos
  else
    icon = icons.windows
  end
  return icon
end

local function lsp_diagnostics_info()
  return {
    errs = lsp.get_diagnostics_count('Error'),
    warns = lsp.get_diagnostics_count('Warning'),
    infos = lsp.get_diagnostics_count('Information'),
    hints = lsp.get_diagnostics_count('Hint')
  }
end

local function diag_enable(f, s)
  return function()
    local diag = f()[s]
    return diag and diag ~= 0
  end
end

local function diag_of(f, s)
  local icon = icons[s]
  return function()
    local diag = f()[s]
    return icon .. diag
  end
end

local comps = {
  head = {
    provider = '▊',
    right_sep = ' ',
    hl = { fg = colors.blue }
  },
  vi_mode = {
    provider = ' ',
    -- icon = '',
    right_sep = ' ',
    hl = function()
      return {
        name = vi_mode_utils.get_mode_highlight_name(),
        fg = vi_mode_utils.get_mode_color(),
        style = 'bold'
      }
    end,
  },
  file_info = {
    provider = {
      name = 'file_info',
      opts = {
        type = 'relative',
        file_modified_icon = '',
      },
    },
    hl = {
      fg = colors.green,
      -- style = 'bold'
    }
  },
  file_os_info = {
    provider = file_os_info,
    left_sep = ' ',
    hl = {
      -- fg = colors.violet,
      style = 'bold'
    }
  },
  file_encoding = {
    provider = 'file_encoding',
    left_sep = '',
    hl = {
      -- fg = colors.violet,
      style = 'bold'
    }
  },
  file_type = {
    provider = 'file_type',
    left_sep = ' ',
    hl = {
      fg = colors.blue,
      style = 'bold'
    }
  },
  position = {
    provider = 'position',
    left_sep = ' ',
    hl = {
      style = 'bold'
    }
  },
  line_percentage = {
    provider = 'line_percentage',
    left_sep = ' ',
    hl = {
      style = 'bold'
    }
  },
  scroll_bar = {
    provider = 'scroll_bar',
    left_sep = ' ',
    hl = {
      fg = colors.blue,
      style = 'bold'
    }
  },
  diagnos = {
    err = {
      provider = diag_of(lsp_diagnostics_info, 'errs'),
      left_sep = ' ',
      enabled = diag_enable(lsp_diagnostics_info, 'errs'),
      hl = {
        fg = colors.red
      }
    },
    warn = {
      provider = diag_of(lsp_diagnostics_info, 'warns'),
      left_sep = ' ',
      enabled = diag_enable(lsp_diagnostics_info, 'warns'),
      hl = {
        fg = colors.yellow
      }
    },
    info = {
      provider = diag_of(lsp_diagnostics_info, 'infos'),
      left_sep = ' ',
      enabled = diag_enable(lsp_diagnostics_info, 'infos'),
      hl = {
        fg = colors.blue
      }
    },
    hint = {
      provider = diag_of(lsp_diagnostics_info, 'hints'),
      left_sep = ' ',
      enabled = diag_enable(lsp_diagnostics_info, 'hints'),
      hl = {
        fg = colors.cyan
      }
    },
  },
  lsp = {
    name = {
      provider = 'lsp_client_names',
      left_sep = ' ',
      icon = icons.lsp,
      hl = {
        fg = colors.yellow
      }
    }
  },
  git = {
    branch = {
      provider = 'git_branch',
      left_sep = ' ',
      hl = {
        fg = colors.blue,
        style = 'bold'
      },
    },
    add = {
      provider = 'git_diff_added',
      hl = {
        fg = colors.green
      }
    },
    change = {
      provider = 'git_diff_changed',
      hl = {
        fg = colors.orange
      }
    },
    remove = {
      provider = 'git_diff_removed',
      hl = {
        fg = colors.red
      }
    }
  }
}

local inactive_comps = {
  head = {
    provider = '▊',
    right_sep = ' ',
  },
  file_info = {
    provider = {
      name = 'file_info',
      opts = {
        type = 'relative',
        file_modified_icon = '',
        colored_icon = false,
      },
    },
  },
}

local components = {
  active = {},
  inactive = {}
}
-- left
components.active[1] = {
  comps.head,
  comps.vi_mode,
  comps.file_info,
  comps.git.branch,
  comps.git.add,
  comps.git.change,
  comps.git.remove,
}
-- middle
components.active[2] = {
  comps.lsp.name,
  comps.diagnos.err,
  comps.diagnos.warn,
  comps.diagnos.hint,
  comps.diagnos.info
}
-- right
components.active[3] = {
  comps.file_type,
  comps.file_os_info,
  comps.file_encoding,
  comps.position,
  comps.line_percentage,
  comps.scroll_bar,
}

-- inactive left
components.inactive[1] = {
  inactive_comps.head,
  inactive_comps.file_info
}

M.setup = function()
  require'feline'.setup {
    colors = colors,
    components = components,
    vi_mode_colors = vi_mode_colors,
    force_inactive = {
      filetypes = {
        'NvimTree',
        'packer',
      },
      buftypes = {'terminal'},
      bufnames = {}
    }
  }
end

return M
