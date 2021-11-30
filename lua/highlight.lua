local M = {}
local c = {
  black = '#17191e', bg0 = '#282c34', bg1 = '#31353f', bg2 = '#393f4a',
  bg3 = '#3b3f4c', bg_d = '#21252b', bg_blue = '#73b8f1', bg_yellow = '#ebd09c',
  fg = '#abb2bf', fg_dark = "#798294", purple = '#c678dd', green = '#98c379', orange = '#d19a66',
  blue = '#61afef', yellow = '#e5c07b', cyan = '#56b6c2', red = '#e86671',
  grey = '#5c6370',light_grey = '#848b98', dark_cyan = '#2b6f77', dark_red = '#993939',
  dark_yellow = '#93691d', dark_purple = '#8a3fa0',
  diff_add =  '#31392b', diff_delete = '#382b2c', diff_change = '#1c3448', diff_text = '#2c5372',
  none = "NONE",
}

local cfg = {bg = false, italic_comment = true}
local hl = {langs = {}, plugins = {}}

local function gui(group_settings)
  if group_settings.bold then return "bold"
  elseif group_settings.underline then return "underline"
  elseif group_settings.italic then return "italic"
  elseif group_settings.reverse then return "reverse"
  else return "NONE" end
end

local function highlight(highlights)
  for group_name, group_settings in pairs(highlights) do
    local fg = group_settings.fg and "guifg=" .. group_settings.fg or "guifg=NONE"
    local bg = group_settings.bg and "guibg=" .. group_settings.bg or "guibg=NONE"
    vim.cmd("highlight " .. group_name .. " ".."gui="..gui(group_settings).." "..fg .. " " .. bg)
  end
end

local colors = {
  Fg = {fg = c.fg},
  Fg_dark = {fg = c.fg_dark},
  Grey = {fg = c.grey},
  LightGrey = {fg = c.light_grey},
  Red = {fg = c.red},
  Cyan = {fg = c.cyan},
  Yellow = {fg = c.yellow},
  Orange = {fg = c.orange},
  Green = {fg = c.green},
  Blue = {fg = c.blue},
  Purple = {fg = c.purple}
}

hl.common = {
  Normal = {fg = c.fg, bg = cfg.bg and c.none or c.bg0},
  NormalFloat = {fg = c.fg_dark, bg = cfg.bg and c.none or c.bg0},
  Terminal = {fg = c.fg, bg = cfg.bg and c.none or c.bg0},
  EndOfBuffer = {fg = c.bg2, bg = cfg.bg and c.none or c.bg0},
  FoldColumn = {fg = c.fg, bg = cfg.bg and c.none or c.bg1},
  Folded = {fg = c.fg, bg = cfg.bg and c.none or c.bg1},
  SignColumn = {fg = c.fg, bg = cfg.bg and c.none or c.bg0},
  ToolbarLine = {fg = c.fg},
  Cursor = {reverse = true},
  vCursor = {reverse = true},
  iCursor = {reverse = true},
  lCursor = {reverse = true},
  CursorIM = {reverse = true},
  CursorColumn = {bg = c.bg1},
  CursorLine = {bg = c.bg1},
  ColorColumn = {bg = c.bg1},
  CursorLineNr = {fg = c.fg},
  LineNr = {fg = c.grey},
  Conceal = {fg = c.grey, bg = c.bg1},
  DiffAdd = {fg = c.none, bg = c.diff_add},
  DiffChange = {fg = c.none, bg = c.diff_change},
  DiffDelete = {fg = c.none, bg = c.diff_delete},
  DiffText = {fg = c.none, bg= c.diff_text},
  DiffAdded = colors.Green,
  DiffRemoved = colors.Red,
  DiffFile = colors.Cyan,
  DiffIndexLine = colors.Grey,
  Directory = {fg = c.blue},
  ErrorMsg = {fg = c.red, bold = true, underline = true},
  WarningMsg = {fg = c.yellow, bold = true},
  MoreMsg = {fg = c.blue, bold = true},
  IncSearch = {fg = c.bg0, bg = c.orange},
  Search = {fg = c.bg0, bg = c.bg_yellow},
  MatchParen = {fg = c.none, bg = c.grey},
  NonText = {fg = c.grey},
  Whitespace = {fg = c.grey},
  SpecialKey = {fg = c.grey},
  Pmenu = {fg = c.fg, bg = c.bg1},
  PmenuSbar = {fg = c.none, bg = c.bg1},
  PmenuSel = {fg = c.bg0, bg = c.bg_blue},
  WildMenu = {fg = c.bg0, bg = c.blue},
  PmenuThumb = {fg = c.none, bg = c.grey},
  Question = {fg = c.yellow},
  SpellBad = {fg = c.red, underline = true, sp = c.red},
  SpellCap = {fg = c.yellow, underline = true, sp = c.yellow},
  SpellLocal = {fg = c.blue, underline = true, sp = c.blue},
  SpellRare = {fg = c.purple, underline = true, sp = c.purple},
  StatusLine = {fg = c.fg, bg = c.bg2},
  StatusLineTerm = {fg = c.fg, bg = c.bg2},
  StatusLineNC = {fg = c.grey, bg = c.bg1},
  StatusLineTermNC = {fg = c.grey, bg = c.bg1},
  TabLine = {fg = c.fg, bg = c.bg1},
  TabLineFill = {fg = c.grey, bg = c.bg1},
  TabLineSel =  {fg = c.bg0, bg = c.fg},
  VertSplit = {fg = c.bg1},
  Visual = {bg = c.bg3},
  VisualNOS = {fg = c.none, bg = c.bg2, underline = true},
  QuickFixLine = {fg = c.blue, underline = true},
  Debug = {fg = c.yellow},
  debugPC = {fg = c.bg0, bg = c.green},
  debugBreakpoint = {fg = c.bg0, bg = c.red},
  ToolbarButton = {fg = c.bg0, bg = c.bg_blue}
}

hl.syntax = {
  String = colors.Green,
  Character = colors.Orange,
  Number = colors.Orange,
  Float = colors.Orange,
  Boolean = colors.Orange,
  Type = colors.Yellow,
  Structure = colors.Yellow,
  StorageClass = colors.Yellow,
  Identifier = colors.Red,
  Constant = colors.Cyan,
  PreProc = colors.Purple,
  PreCondit = colors.Purple,
  Include = colors.Blue,
  Keyword = colors.Purple,
  Define = colors.Red,
  Typedef = colors.Purple,
  Exception = colors.Purple,
  Conditional = colors.Purple,
  Repeat = colors.Purple,
  Statement = colors.Purple,
  Macro = colors.Cyan,
  Error = colors.Purple,
  Label = colors.Purple,
  Special = colors.Red,
  SpecialChar = colors.Red,
  Function = colors.Blue,
  Operator = colors.Purple,
  Title = colors.Cyan,
  Tag = colors.Green,
  Delimiter = colors.LightGrey,
  Comment = {fg = c.grey, italic = cfg.italic_comment},
  SpecialComment = {fg = c.grey, italic = cfg.italic_comment},
  Todo = {fg = c.red, italic = cfg.italic_comment}
}

hl.treesitter = {
  TSAnnotation = colors.Fg,
  TSAttribute = colors.Cyan,
  TSBoolean = colors.Orange,
  TSCharacter = colors.Fg,
  TSComment = {fg = c.grey, italic = cfg.italic_comment},
  TSConditional = colors.Purple,
  TSConstant = colors.Cyan,
  TSConstBuiltin = colors.Orange,
  TSConstMacro = colors.Red,
  TSConstructor = {fg = c.yellow, bold = true},
  TSError = colors.Fg,
  TSException = colors.Purple,
  TSField = colors.Cyan,
  TSFloat = colors.Orange,
  TSFunction = colors.Blue,
  TSFuncBuiltin = colors.Cyan,
  TSFuncMacro = colors.Fg,
  TSInclude = colors.Blue,
  TSKeyword = colors.Purple,
  TSKeywordFunction = {fg = c.purple, bold = true},
  TSKeywordOperator = colors.Purple,
  TSLabel = colors.Red,
  TSMethod = colors.Blue,
  TSNamespace = colors.Yellow,
  TSNone = colors.Fg,
  TSNumber = colors.Orange,
  TSOperator = colors.Purple,
  TSParameter = colors.Red,
  TSParameterReference = colors.Fg,
  TSProperty = colors.Cyan,
  TSPunctDelimiter = colors.LightGrey,
  TSPunctBracket = colors.LightGrey,
  TSPunctSpecial = colors.Red, -- custom
  TSRepeat = colors.Purple,
  TSString = colors.Green,
  TSStringRegex = colors.Orange,
  TSStringEscape = colors.Red,
  TSSymbol = colors.Cyan,
  TSTag = colors.Red,
  TSTagDelimiter = colors.Red,
  TSText = colors.Fg,
  TSStrong = colors.Fg,
  TSEmphasis = colors.Fg,
  TSUnderline = colors.Fg,
  TSStrike = colors.Fg,
  TSTitle = colors.Fg,
  TSLiteral = colors.Green,
  TSURI = colors.Fg,
  TSMath = colors.Fg,
  TSTextReference = colors.Fg,
  TSEnviroment = colors.Fg,
  TSEnviromentName = colors.Fg,
  TSNote = colors.Fg,
  TSWarning = colors.Fg,
  TSDanger = colors.Fg,
  TSType = colors.Yellow,
  TSTypeBuiltin = colors.Orange,
  TSVariable = colors.Fg,
  TSVariableBuiltin = colors.Red
}

hl.plugins.lsp = {
  LspCxxHlGroupEnumConstant = colors.Orange,
  LspCxxHlGroupMemberVariable = colors.Orange,
  LspCxxHlGroupNamespace = colors.Blue,
  LspCxxHlSkippedRegion = colors.Grey,
  LspCxxHlSkippedRegionBeginEnd = colors.Red,
  DiagnosticError = {fg = cfg.darker_diagnostics and c.dark_red or c.red},
  DiagnosticHint = {fg = cfg.darker_diagnostics and c.dark_purple or c.purple},
  DiagnosticInfo = {fg = cfg.darker_diagnostics and c.dark_cyan or c.cyan},
  DiagnosticWarn = {fg = cfg.darker_diagnostics and c.dark_yellow or c.yellow},
  DiagnosticUnderlineError = {underline = not cfg.diagnostics_undercurl, undercurl = cfg.diagnostics_undercurl, sp = c.red},
  DiagnosticUnderlineHint = {underline = not cfg.diagnostics_undercurl, undercurl = cfg.diagnostics_undercurl, sp = c.purple},
  DiagnosticUnderlineInfo = {underline = not cfg.diagnostics_undercurl, undercurl = cfg.diagnostics_undercurl, sp = c.blue},
  DiagnosticUnderlineWarn = {underline = not cfg.diagnostics_undercurl, undercurl = cfg.diagnostics_undercurl, sp = c.yellow},
  LspReferenceText = {underline = true },
  LspReferenceWrite = {underline = true },
  LspReferenceRead = {underline = true }
}

hl.plugins.lsp.LspDiagnosticsDefaultError = hl.plugins.lsp.DiagnosticError
hl.plugins.lsp.LspDiagnosticsDefaultHint = hl.plugins.lsp.DiagnosticHint
hl.plugins.lsp.LspDiagnosticsDefaultInformation = hl.plugins.lsp.DiagnosticInfo
hl.plugins.lsp.LspDiagnosticsDefaultWarning = hl.plugins.lsp.DiagnosticWarn
hl.plugins.lsp.LspDiagnosticsUnderlineError = hl.plugins.lsp.DiagnosticUnderlineError
hl.plugins.lsp.LspDiagnosticsUnderlineHint = hl.plugins.lsp.DiagnosticUnderlineHint
hl.plugins.lsp.LspDiagnosticsUnderlineInformation = hl.plugins.lsp.DiagnosticUnderlineInfo
hl.plugins.lsp.LspDiagnosticsUnderlineWarning = hl.plugins.lsp.DiagnosticUnderlineWarn

hl.plugins.lspsaga = {
  LspSagaDiagnosticBorder = colors.Fg_dark,
  LspSagaDiagnosticHeader = { fg = c.purple },
  LspSagaDiagnosticTruncateLine = colors.Fg_dark,
  LspFloatWinBorder = colors.Fg_dark,
  LspSagaBorderTitle = { link = "Title" },
  LspSagaFinderSelection = { link = "Search" },
  LspSagaShTruncateLine = colors.Fg_dark,
  LspSagaDocTruncateLine = colors.Fg_dark,
  LineDiagTuncateLine = colors.Fg_dark,
  LspSagaCodeActionTitle = { link = "Title" },
  LspSagaCodeActionTruncateLine = colors.Fg_dark,
  LspSagaCodeActionContent = { link = "Normal" },
  LspSagaRenamePromptPrefix = { fg = c.purple },
}

hl.plugins.cmp = {
  CmpItemAbbr = colors.Fg,
  CmpItemAbbrDeprecated = colors.Fg,
  CmpItemAbbrMatch = colors.Cyan,
  CmpItemAbbrMatchFuzzy = colors.Cyan,
  CmpItemKind = colors.Purple,
  CmpItemMenu = colors.LightGrey,
}

hl.plugins.gitgutter = {
  GitGutterAdd = {fg = c.green},
  GitGutterChange = {fg = c.blue},
  GitGutterDelete = {fg = c.red},
}

--[[
hl.plugins.hop = {
  HopNextKey = {fg = c.bg0, bg = c.orange},
  HopNextKey1 = {fg = c.bg0, bg = c.orange},
  HopNextKey2 = {fg = c.bg0, bg = c.bg_yellow},
  HopUnmatched = {fg = c.fg, bg = c.bg1},
}

hl.plugins.diffview = {
  DiffviewFilePanelTitle = {fg = c.blue, bold = true},
  DiffviewFilePanelCounter = {fg = c.purple, bold = true},
  DiffviewFilePanelFileName = colors.Fg,
  DiffviewNormal = hl.common.Normal,
  DiffviewCursorLine = hl.common.CursorLine,
  DiffviewVertSplit = hl.common.VertSplit,
  DiffviewSignColumn = hl.common.SignColumn,
  DiffviewStatusLine = hl.common.StatusLine,
  DiffviewStatusLineNC = hl.common.StatusLineNC,
  DiffviewEndOfBuffer = hl.common.EndOfBuffer,
  DiffviewFilePanelRootPath = colors.Grey,
  DiffviewFilePanelPath = colors.Grey,
  DiffviewFilePanelInsertions = colors.Green,
  DiffviewFilePanelDeletions = colors.Red,
  DiffviewStatusAdded = colors.Green,
  DiffviewStatusUntracked = colors.Blue,
  DiffviewStatusModified = colors.Blue,
  DiffviewStatusRenamed = colors.Blue,
  DiffviewStatusCopied = colors.Blue,
  DiffviewStatusTypeChange = colors.Blue,
  DiffviewStatusUnmerged = colors.Blue,
  DiffviewStatusUnknown = colors.Red,
  DiffviewStatusDeleted = colors.Red,
  DiffviewStatusBroken = colors.Red
}
--]]

hl.plugins.gitsigns = {
  GitSignsAdd = colors.Green,
  GitSignsAddLn = colors.Green,
  GitSignsAddNr = colors.Green,
  GitSignsChange = colors.Blue,
  GitSignsChangeLn = colors.Blue,
  GitSignsChangeNr = colors.Blue,
  GitSignsDelete = colors.Red,
  GitSignsDeleteLn = colors.Red,
  GitSignsDeleteNr = colors.Red
}

hl.plugins.nvim_tree = {
  NvimTreeNormal = { fg = c.fg, bg = c.bg_d },
  NvimTreeVertSplit = { fg = c.bg_d, bg = c.bg_d },
  NvimTreeEndOfBuffer = { fg = cfg.hide_ending_tildes and c.bg_d or c.bg2, bg = c.bg_d },
  NvimTreeRootFolder = { fg = c.orange, bold = true },
  NvimTreeGitDirty = colors.Yellow,
  NvimTreeGitNew = colors.Green,
  NvimTreeGitDeleted = colors.Red,
  NvimTreeSpecialFile = { fg = c.yellow, underline=true },
  NvimTreeIndentMarker = colors.Grey,
  NvimTreeImageFile = { fg = c.dark_purple },
  NvimTreeSymlink = colors.Purple,
  NvimTreeFolderIcon = { fg = c.blue },
  NvimTreeFolderName = colors.Blue,
}

hl.plugins.telescope = {
  TelescopeBorder = colors.Fg_dark,
  -- TelescopePromptBorder = colors.Green,
  -- TelescopeResultsBorder = colors.Purple,
  -- TelescopePreviewBorder = colors.Cyan,
  TelescopeMatching = colors.Blue,
  TelescopePromptPrefix = colors.Blue,
  TelescopeSelection =  { bg = c.bg2 },
  TelescopeSelectionCaret = colors.Blue
}

hl.plugins.symbols_outline = {
  FocusedSymbol = { fg = c.bg1, bg = c.yellow, bold = true },
}

hl.plugins.ts_rainbow = {
  rainbowcol1 = colors.Grey,
  rainbowcol2 = colors.Yellow,
  rainbowcol3 = colors.Blue,
  rainbowcol4 = colors.Orange,
  rainbowcol5 = colors.Purple,
  rainbowcol6 = colors.Green,
  rainbowcol7 = colors.Red
}

hl.langs.markdown = {
  markdownBlockquote = colors.Grey,
  markdownBold = {fg = c.none, bold = true},
  markdownBoldDelimiter = colors.Grey,
  markdownCode = colors.Yellow,
  markdownCodeBlock = colors.Yellow,
  markdownCodeDelimiter = colors.Green,
  markdownH1 = {fg = c.red, bold = true},
  markdownH2 = {fg = c.red, bold = true},
  markdownH3 = {fg = c.red, bold = true},
  markdownH4 = {fg = c.red, bold = true},
  markdownH5 = {fg = c.red, bold = true},
  markdownH6 = {fg = c.red, bold = true},
  markdownHeadingDelimiter = colors.Grey,
  markdownHeadingRule = colors.Grey,
  markdownId = colors.Yellow,
  markdownIdDeclaration = colors.Red,
  markdownItalic = {fg = c.none, italic = true},
  markdownItalicDelimiter = {fg = c.grey, italic = true},
  markdownLinkDelimiter = colors.Grey,
  markdownLinkText = colors.Red,
  markdownLinkTextDelimiter = colors.Grey,
  markdownListMarker = colors.Red,
  markdownOrderedListMarker = colors.Red,
  markdownRule = colors.Purple,
  markdownUrl = {fg = c.blue, underline = true},
  markdownUrlDelimiter = colors.Grey,
  markdownUrlTitleDelimiter = colors.Green
}

M.setup = function()
  highlight(hl.common)
  highlight(hl.syntax)
  highlight(hl.treesitter)
  for _, group in pairs(hl.langs) do highlight(group) end
  for _, group in pairs(hl.plugins) do highlight(group) end

  -- terminal
  vim.g.terminal_color_0 = c.grey
  vim.g.terminal_color_1 = c.red
  vim.g.terminal_color_2 = c.green
  vim.g.terminal_color_3 = c.yellow
  vim.g.terminal_color_4 = c.blue
  vim.g.terminal_color_5 = c.purple
  vim.g.terminal_color_6 = c.cyan
  vim.g.terminal_color_7 = c.fg
  vim.g.terminal_color_8 = c.black
  vim.g.terminal_color_9 = c.red
  vim.g.terminal_color_10 = c.green
  vim.g.terminal_color_11 = c.yellow
  vim.g.terminal_color_12 = c.blue
  vim.g.terminal_color_13 = c.purple
  vim.g.terminal_color_14 = c.cyan
  vim.g.terminal_color_15 = c.fg

  hl = nil
  cfg = nil
  colors = nil
end

return M
