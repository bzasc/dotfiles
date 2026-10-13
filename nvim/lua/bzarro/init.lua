-- bzarro: Catppuccin (or Dracula) accents on top of Sonokai's #2c2e34 background.
-- Load with `:colorscheme bzarro`; call setup() first to change options.
--
-- Highlight groups only reference `base` and the semantic `roles`, so switching
-- accent sets is a matter of swapping which block below is commented out.

local M = {}

-- Backgrounds: shades tuned around #2c2e34 (same as the ghostty Sonokai theme).
local base = {
  bg_dark = "#222327", -- floats, popup menu
  bg = "#2c2e34",
  bg1 = "#33353f", -- cursorline, folds
  bg2 = "#363944",
  bg3 = "#3b3e48", -- lsp references
  bg4 = "#414550",
  selection = "#44475a",

  fg = "#e2e2e3",
  grey = "#7f8490",
  grey_dim = "#595f6f", -- line numbers
  nontext = "#4b5263", -- listchars, separators
}

-- Dracula ---------------------------------------------------------------------
-- local c = {
--   red = "#ff5555",
--   orange = "#ffb86c",
--   yellow = "#f1fa8c",
--   green = "#50fa7b",
--   cyan = "#8be9fd",
--   blue = "#d6acff",
--   purple = "#bd93f9",
--   pink = "#ff79c6",
--   comment = "#6272a4",
--   bright_red = "#ff6e6e",
--   bright_green = "#69ff94",
--   bright_yellow = "#ffffa5",
--   bright_magenta = "#ff92df",
--   bright_cyan = "#a4ffff",
--   bright_white = "#ffffff",
--   black = "#21222c",
-- }
--
-- local roles = {
--   -- syntax
--   comment = c.comment,
--   identifier = base.fg,
--   keyword = c.pink,
--   operator = c.pink,
--   func = c.green,
--   func_builtin = c.cyan,
--   string = c.yellow,
--   docstring = c.yellow,
--   character = c.pink,
--   constant = c.purple,
--   type = c.cyan,
--   type_builtin = c.cyan,
--   module = c.cyan,
--   label = c.cyan,
--   special = c.pink,
--   regex = c.red,
--   symbol = c.purple,
--   url = c.cyan,
--   builtin_var = c.purple,
--   parameter = c.orange,
--   member = base.fg,
--   key = c.cyan,
--   attribute = c.green,
--   tag = c.pink,
--   tag_attr = c.green,
--   tag_delim = base.fg,
--   punct = base.fg,
--   todo = c.purple,
--   -- markup
--   h1 = c.purple,
--   h2 = c.pink,
--   h3 = c.cyan,
--   h4 = c.green,
--   h5 = c.orange,
--   h6 = c.yellow,
--   markup_bold = c.orange,
--   markup_italic = c.yellow,
--   quote = c.yellow,
--   link = c.cyan,
--   link_label = c.pink,
--   raw = c.green,
--   list = c.cyan,
--   math = c.cyan,
--   -- ui
--   muted = c.comment,
--   border = c.comment,
--   accent = c.purple,
--   prompt = c.pink,
--   match = c.pink,
--   match_paren = c.green,
--   search = c.green,
--   cur_search = c.orange,
--   flash_label = c.pink,
--   flash_current = c.green,
--   -- diagnostics / git
--   error = c.red,
--   warn = c.orange,
--   info = c.cyan,
--   hint = c.purple,
--   ok = c.green,
--   added = c.green,
--   changed = c.orange,
--   removed = c.red,
-- }
--
-- local terminal = {
--   c.black, c.red, c.green, c.yellow, c.purple, c.pink, c.cyan, base.fg,
--   c.comment, c.bright_red, c.bright_green, c.bright_yellow, c.blue, c.bright_magenta, c.bright_cyan, c.bright_white,
-- }

-- Catppuccin (Mocha) ----------------------------------------------------------
local c = {
  rosewater = "#f5e0dc",
  flamingo = "#f2cdcd",
  pink = "#f5c2e7",
  mauve = "#cba6f7",
  red = "#f38ba8",
  maroon = "#eba0ac",
  peach = "#fab387",
  yellow = "#f9e2af",
  green = "#a6e3a1",
  teal = "#94e2d5",
  sky = "#89dceb",
  sapphire = "#74c7ec",
  blue = "#89b4fa",
  lavender = "#b4befe",
  overlay2 = "#9399b2",
  overlay1 = "#7f849c",
  overlay0 = "#6c7086",
}
-- Generic names shared with the Dracula block (which-key icons use them).
c.orange, c.cyan, c.purple = c.peach, c.sky, c.mauve

local roles = {
  -- syntax
  comment = c.overlay2,
  identifier = c.flamingo,
  keyword = c.mauve,
  operator = c.sky,
  func = c.blue,
  func_builtin = c.peach,
  string = c.green,
  docstring = c.teal,
  character = c.teal,
  constant = c.peach,
  type = c.yellow,
  type_builtin = c.mauve,
  module = c.yellow,
  label = c.sapphire,
  special = c.pink,
  regex = c.pink,
  symbol = c.flamingo,
  url = c.blue,
  builtin_var = c.red,
  parameter = c.maroon,
  member = c.lavender,
  key = c.lavender,
  attribute = c.peach,
  tag = c.blue,
  tag_attr = c.yellow,
  tag_delim = c.teal,
  punct = c.overlay2,
  todo = c.flamingo,
  -- markup
  h1 = c.red,
  h2 = c.peach,
  h3 = c.yellow,
  h4 = c.green,
  h5 = c.sapphire,
  h6 = c.lavender,
  markup_bold = c.red,
  markup_italic = c.red,
  quote = c.pink,
  link = c.lavender,
  link_label = c.lavender,
  raw = c.green,
  list = c.teal,
  math = c.blue,
  -- ui
  muted = c.overlay1,
  border = c.blue,
  accent = c.blue,
  prompt = c.flamingo,
  match = c.blue,
  match_paren = c.peach,
  search = c.sky,
  cur_search = c.red,
  flash_label = c.green,
  flash_current = c.peach,
  -- diagnostics / git
  error = c.red,
  warn = c.yellow,
  info = c.sky,
  hint = c.teal,
  ok = c.green,
  added = c.green,
  changed = c.blue,
  removed = c.red,
}

-- stylua: ignore
local terminal = {
  c.overlay0, c.red, c.green, c.yellow, c.blue, c.pink, c.sky, base.fg,
  c.overlay1, c.red, c.green, c.yellow, c.blue, c.pink, c.sky, base.fg,
}

-------------------------------------------------------------------------------

M.palette = vim.tbl_extend("force", base, c, roles)

local defaults = {
  transparent = false, -- leave Normal/float backgrounds to the terminal
  italic = true,
}

M.options = vim.deepcopy(defaults)

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", vim.deepcopy(defaults), opts or {})
end

-- Mix `fg` over `bg` at `alpha` (0..1).
local function blend(fg, bg, alpha)
  local function rgb(hex)
    return tonumber(hex:sub(2, 3), 16), tonumber(hex:sub(4, 5), 16), tonumber(hex:sub(6, 7), 16)
  end
  local fr, fg_, fb = rgb(fg)
  local br, bg_, bb = rgb(bg)
  local function mix(a, b)
    return math.floor(a * alpha + b * (1 - alpha) + 0.5)
  end
  return string.format("#%02x%02x%02x", mix(fr, br), mix(fg_, bg_), mix(fb, bb))
end

local function groups(p, o)
  local bg = o.transparent and "NONE" or p.bg
  local float_bg = o.transparent and "NONE" or p.bg_dark

  return {
    -- Editor UI
    Normal = { fg = p.fg, bg = bg },
    NormalNC = { link = "Normal" },
    NormalFloat = { fg = p.fg, bg = float_bg },
    FloatBorder = { fg = p.border, bg = float_bg },
    FloatTitle = { fg = p.accent, bg = float_bg, bold = true },
    FloatFooter = { fg = p.muted, bg = float_bg },
    Cursor = { fg = p.bg, bg = p.fg },
    lCursor = { link = "Cursor" },
    CursorIM = { link = "Cursor" },
    TermCursor = { link = "Cursor" },
    CursorLine = { bg = p.bg1 },
    CursorColumn = { bg = p.bg1 },
    ColorColumn = { bg = p.bg1 },
    CursorLineNr = { fg = p.fg, bold = true },
    LineNr = { fg = p.grey_dim },
    LineNrAbove = { link = "LineNr" },
    LineNrBelow = { link = "LineNr" },
    SignColumn = { fg = p.grey_dim, bg = bg },
    FoldColumn = { fg = p.muted, bg = bg },
    Folded = { fg = p.muted, bg = p.bg1 },
    VertSplit = { fg = p.nontext, bg = bg },
    WinSeparator = { link = "VertSplit" },
    EndOfBuffer = { fg = p.bg },
    NonText = { fg = p.nontext },
    Whitespace = { fg = p.nontext },
    SpecialKey = { fg = p.nontext },
    Conceal = { fg = p.muted },
    Visual = { bg = p.selection },
    VisualNOS = { link = "Visual" },
    Search = { fg = p.bg, bg = p.search },
    IncSearch = { fg = p.bg, bg = p.cur_search, bold = true },
    CurSearch = { link = "IncSearch" },
    Substitute = { fg = p.bg, bg = p.error },
    MatchParen = { fg = p.match_paren, bg = p.bg4, bold = true },
    QuickFixLine = { bg = p.selection, bold = true },
    Directory = { fg = p.accent },
    Title = { fg = p.accent, bold = true },
    ModeMsg = { fg = p.fg, bold = true },
    MoreMsg = { fg = p.ok },
    Question = { fg = p.ok },
    ErrorMsg = { fg = p.error },
    WarningMsg = { fg = p.warn },
    MsgArea = { fg = p.fg },
    MsgSeparator = { fg = p.nontext },
    WildMenu = { link = "PmenuSel" },
    Pmenu = { fg = p.fg, bg = p.bg_dark },
    PmenuSel = { bg = p.selection, bold = true },
    PmenuKind = { fg = p.info, bg = p.bg_dark },
    PmenuKindSel = { fg = p.info, bg = p.selection },
    PmenuExtra = { fg = p.muted, bg = p.bg_dark },
    PmenuExtraSel = { fg = p.muted, bg = p.selection },
    PmenuMatch = { fg = p.match, bg = p.bg_dark, bold = true },
    PmenuMatchSel = { fg = p.match, bg = p.selection, bold = true },
    PmenuSbar = { bg = p.bg_dark },
    PmenuThumb = { bg = p.selection },
    StatusLine = { fg = p.fg, bg = float_bg },
    StatusLineNC = { fg = p.muted, bg = float_bg },
    TabLine = { fg = p.muted, bg = p.bg_dark },
    TabLineFill = { bg = float_bg },
    TabLineSel = { fg = p.fg, bg = p.bg4, bold = true },
    WinBar = { fg = p.fg, bg = bg },
    WinBarNC = { fg = p.muted, bg = bg },
    SpellBad = { undercurl = true, sp = p.error },
    SpellCap = { undercurl = true, sp = p.yellow },
    SpellLocal = { undercurl = true, sp = p.info },
    SpellRare = { undercurl = true, sp = p.purple },

    -- Diff
    DiffAdd = { bg = blend(p.added, p.bg, 0.15) },
    DiffDelete = { fg = blend(p.removed, p.bg, 0.6), bg = blend(p.removed, p.bg, 0.15) },
    DiffChange = { bg = blend(p.changed, p.bg, 0.1) },
    DiffText = { bg = blend(p.changed, p.bg, 0.25) },
    Added = { fg = p.added },
    Changed = { fg = p.changed },
    Removed = { fg = p.removed },
    diffAdded = { link = "Added" },
    diffChanged = { link = "Changed" },
    diffRemoved = { link = "Removed" },

    -- Syntax
    Comment = { fg = p.comment, italic = true },
    Constant = { fg = p.constant },
    String = { fg = p.string },
    Character = { fg = p.character },
    Number = { fg = p.constant },
    Boolean = { fg = p.constant },
    Float = { fg = p.constant },
    Identifier = { fg = p.identifier },
    Function = { fg = p.func },
    Statement = { fg = p.keyword },
    Conditional = { fg = p.keyword },
    Repeat = { fg = p.keyword },
    Label = { fg = p.label },
    Operator = { fg = p.operator },
    Keyword = { fg = p.keyword },
    Exception = { fg = p.keyword },
    PreProc = { fg = p.special },
    Include = { fg = p.keyword },
    Define = { fg = p.special },
    Macro = { fg = p.keyword },
    PreCondit = { fg = p.special },
    Type = { fg = p.type, italic = true },
    StorageClass = { fg = p.keyword, italic = true },
    Structure = { fg = p.type },
    Typedef = { fg = p.type },
    Special = { fg = p.special },
    SpecialChar = { fg = p.special },
    Tag = { link = "@tag" },
    Delimiter = { fg = p.punct },
    SpecialComment = { fg = p.info, italic = true },
    Debug = { fg = p.warn },
    Underlined = { fg = p.url, underline = true },
    Ignore = { fg = p.grey_dim },
    Error = { fg = p.error },
    Todo = { fg = p.bg, bg = p.todo, bold = true },

    -- Treesitter
    ["@variable"] = { fg = p.fg },
    ["@variable.builtin"] = { fg = p.builtin_var, italic = true },
    ["@variable.parameter"] = { fg = p.parameter, italic = true },
    ["@variable.parameter.builtin"] = { fg = p.parameter, italic = true },
    ["@variable.member"] = { fg = p.member },
    ["@constant"] = { fg = p.constant },
    ["@constant.builtin"] = { fg = p.constant },
    ["@constant.macro"] = { fg = p.constant },
    ["@module"] = { fg = p.module },
    ["@module.builtin"] = { fg = p.module, italic = true },
    ["@label"] = { link = "Label" },
    ["@string"] = { link = "String" },
    ["@string.documentation"] = { fg = p.docstring },
    ["@string.regexp"] = { fg = p.regex },
    ["@string.escape"] = { fg = p.special },
    ["@string.special"] = { fg = p.special },
    ["@string.special.symbol"] = { fg = p.symbol },
    ["@string.special.url"] = { fg = p.url, underline = true },
    ["@character"] = { link = "Character" },
    ["@character.special"] = { fg = p.special },
    ["@boolean"] = { link = "Boolean" },
    ["@number"] = { link = "Number" },
    ["@number.float"] = { link = "Float" },
    ["@type"] = { fg = p.type, italic = true },
    ["@type.builtin"] = { fg = p.type_builtin, italic = true },
    ["@type.definition"] = { fg = p.type },
    ["@attribute"] = { fg = p.attribute, italic = true },
    ["@attribute.builtin"] = { fg = p.attribute, italic = true },
    ["@property"] = { fg = p.member },
    ["@property.json"] = { fg = p.key },
    ["@property.jsonc"] = { fg = p.key },
    ["@property.yaml"] = { fg = p.key },
    ["@property.toml"] = { fg = p.key },
    ["@function"] = { fg = p.func },
    ["@function.builtin"] = { fg = p.func_builtin },
    ["@function.call"] = { fg = p.func },
    ["@function.macro"] = { fg = p.func },
    ["@function.method"] = { fg = p.func },
    ["@function.method.call"] = { fg = p.func },
    ["@constructor"] = { fg = p.type },
    ["@constructor.lua"] = { link = "@punctuation.bracket" },
    ["@operator"] = { link = "Operator" },
    ["@keyword"] = { fg = p.keyword },
    ["@keyword.modifier"] = { fg = p.keyword, italic = true },
    ["@punctuation.delimiter"] = { fg = p.punct },
    ["@punctuation.bracket"] = { fg = p.punct },
    ["@punctuation.special"] = { fg = p.special },
    ["@comment"] = { link = "Comment" },
    ["@comment.error"] = { fg = p.bg, bg = p.error, bold = true },
    ["@comment.warning"] = { fg = p.bg, bg = p.warn, bold = true },
    ["@comment.todo"] = { link = "Todo" },
    ["@comment.note"] = { fg = p.bg, bg = p.info, bold = true },
    ["@comment.hint"] = { fg = p.bg, bg = p.hint, bold = true },
    ["@markup.strong"] = { fg = p.markup_bold, bold = true },
    ["@markup.italic"] = { fg = p.markup_italic, italic = true },
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@markup.underline"] = { underline = true },
    ["@markup.heading"] = { fg = p.accent, bold = true },
    ["@markup.heading.1"] = { fg = p.h1, bold = true },
    ["@markup.heading.2"] = { fg = p.h2, bold = true },
    ["@markup.heading.3"] = { fg = p.h3, bold = true },
    ["@markup.heading.4"] = { fg = p.h4, bold = true },
    ["@markup.heading.5"] = { fg = p.h5, bold = true },
    ["@markup.heading.6"] = { fg = p.h6, bold = true },
    ["@markup.quote"] = { fg = p.quote, italic = true },
    ["@markup.math"] = { fg = p.math },
    ["@markup.link"] = { fg = p.link },
    ["@markup.link.label"] = { fg = p.link_label },
    ["@markup.link.url"] = { fg = p.url, underline = true },
    ["@markup.raw"] = { fg = p.raw },
    ["@markup.raw.block"] = { fg = p.fg },
    ["@markup.list"] = { fg = p.list },
    ["@markup.list.checked"] = { fg = p.ok },
    ["@markup.list.unchecked"] = { fg = p.muted },
    ["@diff.plus"] = { link = "Added" },
    ["@diff.minus"] = { link = "Removed" },
    ["@diff.delta"] = { link = "Changed" },
    ["@tag"] = { fg = p.tag },
    ["@tag.builtin"] = { fg = p.tag },
    ["@tag.attribute"] = { fg = p.tag_attr, italic = true },
    ["@tag.delimiter"] = { fg = p.tag_delim },

    -- LSP semantic tokens (the rest fall back to Neovim's default @lsp -> treesitter links)
    ["@lsp.type.comment"] = {}, -- keep treesitter's TODO/NOTE highlights inside comments
    ["@lsp.type.variable"] = {}, -- let treesitter tell builtins/members apart
    ["@lsp.type.namespace"] = { link = "@module" },
    ["@lsp.type.parameter"] = { link = "@variable.parameter" },
    ["@lsp.type.property"] = { link = "@property" },
    ["@lsp.type.enumMember"] = { link = "@constant" },
    ["@lsp.type.interface"] = { link = "@type" },
    ["@lsp.type.typeParameter"] = { link = "@type" },
    ["@lsp.type.decorator"] = { link = "@attribute" },
    ["@lsp.type.keyword"] = { link = "@keyword" },
    ["@lsp.type.builtinType"] = { link = "@type.builtin" },
    ["@lsp.type.selfKeyword"] = { link = "@variable.builtin" },
    ["@lsp.type.selfParameter"] = { link = "@variable.builtin" },
    ["@lsp.type.escapeSequence"] = { link = "@string.escape" },
    ["@lsp.type.formatSpecifier"] = { link = "@punctuation.special" },
    ["@lsp.type.unresolvedReference"] = { undercurl = true, sp = p.error },
    ["@lsp.mod.deprecated"] = { strikethrough = true },
    ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },

    -- LSP / diagnostics
    LspReferenceText = { bg = p.bg3 },
    LspReferenceRead = { bg = p.bg3 },
    LspReferenceWrite = { bg = p.bg3, underline = true },
    LspReferenceTarget = { link = "LspReferenceText" },
    LspInlayHint = { fg = p.muted, bg = p.bg1, italic = true },
    LspCodeLens = { fg = p.muted },
    LspCodeLensSeparator = { fg = p.nontext },
    LspSignatureActiveParameter = { fg = p.parameter, bg = p.selection, bold = true },
    DiagnosticError = { fg = p.error },
    DiagnosticWarn = { fg = p.warn },
    DiagnosticInfo = { fg = p.info },
    DiagnosticHint = { fg = p.hint },
    DiagnosticOk = { fg = p.ok },
    DiagnosticVirtualTextError = { fg = p.error, bg = blend(p.error, p.bg, 0.1) },
    DiagnosticVirtualTextWarn = { fg = p.warn, bg = blend(p.warn, p.bg, 0.1) },
    DiagnosticVirtualTextInfo = { fg = p.info, bg = blend(p.info, p.bg, 0.1) },
    DiagnosticVirtualTextHint = { fg = p.hint, bg = blend(p.hint, p.bg, 0.1) },
    DiagnosticVirtualTextOk = { fg = p.ok, bg = blend(p.ok, p.bg, 0.1) },
    DiagnosticUnderlineError = { undercurl = true, sp = p.error },
    DiagnosticUnderlineWarn = { undercurl = true, sp = p.warn },
    DiagnosticUnderlineInfo = { undercurl = true, sp = p.info },
    DiagnosticUnderlineHint = { undercurl = true, sp = p.hint },
    DiagnosticUnderlineOk = { undercurl = true, sp = p.ok },
    DiagnosticUnnecessary = { fg = p.grey, italic = true },
    DiagnosticDeprecated = { strikethrough = true },

    -- blink.cmp (+ colorful-menu, which reuses the treesitter groups above).
    -- Menu, docs and signature stay solid even with `transparent`, so they read over code.
    BlinkCmpMenu = { link = "Pmenu" },
    BlinkCmpMenuBorder = { fg = p.border, bg = p.bg_dark },
    BlinkCmpMenuSelection = { bg = blend(p.accent, p.bg_dark, 0.2), bold = true },
    BlinkCmpLabel = { fg = p.fg },
    BlinkCmpLabelMatch = { fg = p.match, bold = true },
    BlinkCmpLabelDeprecated = { fg = p.muted, strikethrough = true },
    BlinkCmpLabelDetail = { fg = p.muted },
    BlinkCmpLabelDescription = { fg = p.muted },
    BlinkCmpSource = { fg = p.muted },
    BlinkCmpGhostText = { fg = p.muted, italic = true },
    BlinkCmpDoc = { fg = p.fg, bg = p.bg_dark },
    BlinkCmpDocBorder = { link = "BlinkCmpMenuBorder" },
    BlinkCmpDocSeparator = { fg = p.nontext, bg = p.bg_dark },
    BlinkCmpDocCursorLine = { link = "BlinkCmpMenuSelection" },
    BlinkCmpSignatureHelp = { link = "BlinkCmpDoc" },
    BlinkCmpSignatureHelpBorder = { link = "BlinkCmpMenuBorder" },
    BlinkCmpSignatureHelpActiveParameter = { link = "LspSignatureActiveParameter" },
    BlinkCmpKind = { fg = p.info },
    BlinkCmpKindText = { fg = p.fg },
    BlinkCmpKindMethod = { fg = p.func },
    BlinkCmpKindFunction = { fg = p.func },
    BlinkCmpKindConstructor = { fg = p.type },
    BlinkCmpKindField = { fg = p.member },
    BlinkCmpKindVariable = { fg = p.fg },
    BlinkCmpKindProperty = { fg = p.member },
    BlinkCmpKindClass = { fg = p.type },
    BlinkCmpKindInterface = { fg = p.type },
    BlinkCmpKindStruct = { fg = p.type },
    BlinkCmpKindModule = { fg = p.module },
    BlinkCmpKindUnit = { fg = p.constant },
    BlinkCmpKindValue = { fg = p.constant },
    BlinkCmpKindEnum = { fg = p.type },
    BlinkCmpKindEnumMember = { fg = p.constant },
    BlinkCmpKindKeyword = { fg = p.keyword },
    BlinkCmpKindSnippet = { fg = p.string },
    BlinkCmpKindColor = { fg = p.special },
    BlinkCmpKindFile = { fg = p.fg },
    BlinkCmpKindReference = { fg = p.special },
    BlinkCmpKindFolder = { fg = p.accent },
    BlinkCmpKindConstant = { fg = p.constant },
    BlinkCmpKindEvent = { fg = p.warn },
    BlinkCmpKindOperator = { fg = p.operator },
    BlinkCmpKindTypeParameter = { fg = p.type },
    BlinkCmpKindCopilot = { fg = p.ok },

    -- snacks.nvim
    SnacksNormal = { link = "NormalFloat" },
    SnacksWinBar = { link = "Title" },
    SnacksIndent = { fg = p.bg4 },
    SnacksIndentScope = { fg = p.muted },
    SnacksIndentChunk = { fg = p.muted },
    SnacksInputBorder = { fg = p.accent },
    SnacksInputTitle = { fg = p.accent, bold = true },
    SnacksInputIcon = { fg = p.prompt },
    SnacksPickerBorder = { link = "FloatBorder" },
    SnacksPickerTitle = { fg = p.accent, bold = true },
    SnacksPickerInputBorder = { fg = p.accent },
    SnacksPickerInputTitle = { fg = p.accent, bold = true },
    SnacksPickerPrompt = { fg = p.prompt },
    SnacksPickerMatch = { fg = p.match, bold = true },
    SnacksPickerDir = { fg = p.muted },
    SnacksPickerPathHidden = { fg = p.grey },
    SnacksPickerPathIgnored = { fg = p.grey_dim },
    SnacksPickerSelected = { fg = p.ok },
    SnacksPickerCursorLine = { bg = p.bg1 },
    SnacksPickerListCursorLine = { bg = p.selection },
    SnacksPickerTree = { fg = p.nontext },
    SnacksPickerTotals = { fg = p.muted },

    -- flash.nvim
    FlashBackdrop = { fg = p.muted },
    FlashMatch = { fg = p.fg, bg = p.selection },
    FlashCurrent = { fg = p.bg, bg = p.flash_current, bold = true },
    FlashLabel = { fg = p.bg, bg = p.flash_label, bold = true },
    FlashPromptIcon = { fg = p.prompt },

    -- nvim-hlslens
    HlSearchNear = { link = "IncSearch" },
    HlSearchLens = { fg = p.muted, bg = p.bg2 },
    HlSearchLensNear = { fg = p.bg, bg = p.cur_search },

    -- noice.nvim
    NoiceCmdlinePopupBorder = { fg = p.accent },
    NoiceCmdlinePopupTitle = { fg = p.accent, bold = true },
    NoiceCmdlineIcon = { fg = p.accent },
    NoiceCmdlinePopupBorderSearch = { fg = p.yellow },
    NoiceCmdlineIconSearch = { fg = p.yellow },
    NoiceConfirmBorder = { fg = p.accent },

    -- which-key.nvim
    WhichKey = { fg = p.func },
    WhichKeyGroup = { fg = p.keyword },
    WhichKeyDesc = { fg = p.fg },
    WhichKeySeparator = { fg = p.muted },
    WhichKeyValue = { fg = p.muted },
    WhichKeyIconAzure = { fg = p.cyan },
    WhichKeyIconBlue = { fg = p.blue },
    WhichKeyIconCyan = { fg = p.cyan },
    WhichKeyIconGreen = { fg = p.green },
    WhichKeyIconGrey = { fg = p.grey },
    WhichKeyIconOrange = { fg = p.orange },
    WhichKeyIconPurple = { fg = p.purple },
    WhichKeyIconRed = { fg = p.red },
    WhichKeyIconYellow = { fg = p.yellow },

    -- gitsigns.nvim / diffview.nvim
    GitSignsAdd = { fg = p.added },
    GitSignsChange = { fg = p.changed },
    GitSignsDelete = { fg = p.removed },
    GitSignsCurrentLineBlame = { fg = p.muted, italic = true },
    DiffviewFilePanelTitle = { fg = p.accent, bold = true },
    DiffviewFilePanelCounter = { fg = p.prompt },

    -- mini.files
    MiniFilesTitle = { fg = p.muted, bg = float_bg },
    MiniFilesTitleFocused = { fg = p.accent, bg = float_bg, bold = true },
    MiniFilesBorderModified = { fg = p.warn, bg = float_bg },

    -- trouble.nvim / todo-comments.nvim
    TroubleNormal = { link = "NormalFloat" },
    TroubleNormalNC = { link = "NormalFloat" },
    TroubleCount = { fg = p.prompt, bg = p.selection },

    -- render-markdown.nvim
    RenderMarkdownH1Bg = { bg = blend(p.h1, p.bg, 0.15) },
    RenderMarkdownH2Bg = { bg = blend(p.h2, p.bg, 0.15) },
    RenderMarkdownH3Bg = { bg = blend(p.h3, p.bg, 0.15) },
    RenderMarkdownH4Bg = { bg = blend(p.h4, p.bg, 0.15) },
    RenderMarkdownH5Bg = { bg = blend(p.h5, p.bg, 0.15) },
    RenderMarkdownH6Bg = { bg = blend(p.h6, p.bg, 0.15) },
    RenderMarkdownCode = { bg = p.bg_dark },
    RenderMarkdownCodeInline = { fg = p.raw, bg = p.bg1 },
    RenderMarkdownBullet = { fg = p.list },
    RenderMarkdownDash = { fg = p.muted },
    RenderMarkdownTableHead = { fg = p.accent },
    RenderMarkdownTableRow = { fg = p.muted },

    -- nvim-dap / nvim-dap-ui / nvim-dap-virtual-text
    DapBreakpoint = { fg = p.error },
    DapBreakpointCondition = { fg = p.warn },
    DapLogPoint = { fg = p.info },
    DapStopped = { fg = p.ok },
    DapStoppedLine = { bg = blend(p.ok, p.bg, 0.15) },
    NvimDapVirtualText = { fg = p.muted, italic = true },
    DapUIScope = { fg = p.info },
    DapUIType = { fg = p.accent },
    DapUIDecoration = { fg = p.info },
    DapUIThread = { fg = p.ok },
    DapUIStoppedThread = { fg = p.info },
    DapUISource = { fg = p.accent },
    DapUILineNumber = { fg = p.info },
    DapUIFloatBorder = { link = "FloatBorder" },
    DapUIWatchesEmpty = { fg = p.prompt },
    DapUIWatchesValue = { fg = p.ok },
    DapUIWatchesError = { fg = p.error },
    DapUIBreakpointsPath = { fg = p.info },
    DapUIBreakpointsInfo = { fg = p.ok },
    DapUIBreakpointsCurrentLine = { fg = p.ok, bold = true },

    -- yanky.nvim / fidget.nvim
    YankyPut = { bg = p.selection },
    YankyYanked = { bg = p.selection },
    FidgetTitle = { fg = p.accent, bold = true },
    FidgetTask = { fg = p.muted },
  }
end

function M.load()
  if vim.g.colors_name then
    vim.cmd("hi clear")
  end
  vim.o.termguicolors = true
  vim.o.background = "dark"
  vim.g.colors_name = "bzarro"

  local p, o = M.palette, M.options
  for name, spec in pairs(groups(p, o)) do
    if not o.italic then
      spec.italic = nil
    end
    vim.api.nvim_set_hl(0, name, spec)
  end
  for i, color in ipairs(terminal) do
    vim.g["terminal_color_" .. (i - 1)] = color
  end
end

return M
