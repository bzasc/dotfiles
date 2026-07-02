-- Native Catppuccin Configuration (Neovim 0.12+)
vim.g.catppuccin_flavour = "sonokai"

-- 1. Custom Palette Definition (Gruvbox-like feel)
local palettes = {
  macchiato = {
    rosewater = "#ea6962",
    flamingo = "#ea6962",
    red = "#ea6962",
    maroon = "#ea6962",
    pink = "#d3869b",
    mauve = "#d3869b",
    peach = "#e78a4e",
    yellow = "#d8a657",
    green = "#a9b665",
    teal = "#89b482",
    sky = "#89b482",
    sapphire = "#89b482",
    blue = "#7daea3",
    lavender = "#7daea3",
    text = "#ebdbb2",
    subtext2 = "#d5c4a1",
    subtext1 = "#d5c4a1",
    subtext0 = "#bdae93",
    overlay2 = "#a89984",
    overlay1 = "#928374",
    overlay0 = "#595959",
    surface2 = "#414550",
    surface1 = "#3b3e48",
    surface0 = "#33353f",
    base = "#2c2e34",
    mantle = "#222327",
    crust = "#1c1d22",
    none = "NONE",
  },
  sonokai = {
    rosewater = "#fc5d7c",
    flamingo = "#ff6077",
    red = "#fc5d7c",
    maroon = "#fc5d7c",
    pink = "#b39df3",
    mauve = "#b39df3",
    peach = "#f39660",
    yellow = "#e7c664",
    green = "#9ed072",
    teal = "#87c095",
    sky = "#76cce0",
    sapphire = "#76cce0",
    blue = "#76cce0",
    lavender = "#b39df3",
    text = "#e2e2e3",
    subtext2 = "#c7c8cc",
    subtext1 = "#c1c2c7",
    subtext0 = "#a8a9af",
    overlay2 = "#7f8490",
    overlay1 = "#595f6f",
    overlay0 = "#4e525c",
    surface2 = "#414550",
    surface1 = "#3b3e48",
    surface0 = "#363944",
    base = "#2c2e34",
    mantle = "#222327",
    crust = "#1c1d22",
    none = "NONE",
  },
}

local function apply_custom_highlights()
  local flavor = vim.g.catppuccin_flavour or "macchiato"
  local colors = palettes[flavor] or palettes.macchiato

  -- [1] Core UI & Transparency
  local transparent_groups = {
    "Normal",
    "NormalNC",
    "LineNr",
    "Folded",
    "SignColumn",
    "EndOfBuffer",
    "VertSplit",
    "WinSeparator",
    "StatusLine",
    "StatusLineNC",
  }
  for _, group in ipairs(transparent_groups) do
    vim.api.nvim_set_hl(0, group, { fg = colors.text, bg = colors.none, ctermbg = colors.none })
  end

  local highlights = {
    -- UI Elements
    CmpItemMenu = { fg = colors.surface2 },
    CursorLine = { bg = colors.surface0 },
    CursorColumn = { bg = colors.surface0 },
    CursorLineNr = { fg = colors.text, bold = true },
    FloatBorder = { bg = colors.base, fg = colors.text },
    NormalFloat = { fg = colors.text, bg = colors.base },
    LineNr = { fg = colors.overlay0 },
    LspInfoBorder = { link = "FloatBorder" },
    Pmenu = { bg = colors.mantle, fg = colors.text },
    PmenuSel = { bg = colors.surface0, fg = colors.text },
    Question = { fg = colors.blue },
    WarningMsg = { fg = colors.yellow },
    ErrorMsg = { fg = colors.red },
    YankHighlight = { bg = colors.surface2 },
    VertSplit = { bg = colors.none, fg = colors.surface0 },
    Visual = { bg = colors.surface1 },
    Search = { bg = colors.surface1, fg = colors.text },
    CurSearch = { bg = colors.yellow, fg = colors.base },
    Directory = { fg = colors.blue, bold = true },
    NonText = { fg = colors.surface2 },
    SpecialKey = { fg = colors.surface2 },

    -- [2] Plugin: Snacks (Pickers, Notifier, etc.)
    SnacksBackdrop = { bg = "#000000" },
    -- Dim (used by zen) must NOT inherit DiagnosticUnnecessary's undercurl,
    -- else every dimmed line gets a spell-error-like squiggle. Plain fade only.
    SnacksDim = { fg = colors.overlay0 },
    SnacksNormal = { link = "NormalFloat" },
    SnacksPicker = { link = "NormalFloat" },
    SnacksPickerBorder = { link = "FloatBorder" },
    SnacksPickerList = { bg = colors.base, fg = colors.text },
    SnacksPickerPreview = { bg = colors.crust, fg = colors.text },
    SnacksPickerPreviewBorder = { bg = colors.crust, fg = colors.crust },
    SnacksPickerInput = { bg = colors.base, fg = colors.text },
    SnacksPickerInputBorder = { bg = colors.base, fg = colors.base },
    SnacksPickerTitle = { fg = colors.mauve, bold = true },
    SnacksPickerMatch = { fg = colors.blue, bold = true },
    SnacksPickerLabel = { fg = colors.overlay1 },
    SnacksPickerDirectory = { fg = colors.subtext1 },
    SnacksPickerSelection = { bg = colors.surface0, bold = true },
    SnacksPickerRow = { bg = colors.mantle },
    SnacksPickerListCursorLine = { bg = colors.surface0 },
    SnacksPickerCursorLine = { bg = colors.surface0 },
    SnacksPickerDir = { fg = colors.overlay2 },
    SnacksPickerDimmed = { fg = colors.overlay2 },
    SnacksPickerFile = { fg = colors.text },
    SnacksPickerPathHidden = { fg = colors.overlay2 },
    SnacksPickerPathIgnored = { fg = colors.overlay2 },
    SnacksPickerTree = { fg = colors.overlay1 },
    SnacksPickerGitStatusUntracked = { fg = colors.subtext0 },
    SnacksPickerGitStatusIgnored = { fg = colors.overlay1 },

    -- [3] Plugin: WhichKey
    WhichKey = { fg = colors.pink },
    WhichKeyGroup = { fg = colors.blue },
    WhichKeySeparator = { fg = colors.overlay1 },
    WhichKeyDesc = { fg = colors.teal },
    WhichKeyFloat = { bg = colors.mantle },
    WhichKeyValue = { fg = colors.overlay1 },

    -- [4] Plugin: Other Integrations
    FidgetTask = { fg = colors.subtext2 },
    FidgetTitle = { fg = colors.peach, bold = true },
    IblIndent = { fg = colors.surface0 },
    IblScope = { fg = colors.overlay0 },
    GitSignsChange = { fg = colors.peach },
    GitSignsAdd = { fg = colors.green },
    GitSignsDelete = { fg = colors.red },
    GitSignsCurrentLineBlame = { fg = colors.overlay1 },
    BlinkCmpLabelMatch = { fg = colors.blue, bold = true },
    FlashMatch = { bg = colors.mauve, fg = colors.base },
    FlashLabel = { bg = colors.peach, fg = colors.base, bold = true },
    NoiceLspProgressTitle = { fg = colors.peach, bold = true },
    YankyYanked = { bg = colors.surface2 },
    TinyCmdlineNormal = { bg = colors.base, fg = colors.text },
    TinyCmdlineBorder = { bg = "NONE", fg = colors.text },

    -- [7] Debugger (DAP)
    DapBreakpoint = { fg = colors.red },
    DapStopped = { fg = colors.green },
    DapLogPoint = { fg = colors.yellow },

    -- [8] Diagnostics
    DiagnosticError = { fg = colors.red },
    DiagnosticWarn = { fg = colors.yellow },
    DiagnosticInfo = { fg = colors.sky },
    DiagnosticHint = { fg = colors.teal },
    DiagnosticUnderlineError = { sp = colors.red, undercurl = true },
    DiagnosticUnderlineWarn = { sp = colors.yellow, undercurl = true },
    DiagnosticUnderlineInfo = { sp = colors.sky, undercurl = true },
    DiagnosticUnderlineHint = { sp = colors.teal, undercurl = true },
    DiagnosticUnnecessary = { fg = colors.overlay0, undercurl = true },

    -- [9] Syntax Overrides (General)
    Identifier = { fg = colors.text },
    Boolean = { fg = colors.mauve },
    Number = { fg = colors.mauve },
    Float = { fg = colors.mauve },
    PreProc = { fg = colors.mauve },
    PreCondit = { fg = colors.mauve },
    Include = { fg = colors.mauve },
    Define = { fg = colors.mauve },
    Conditional = { fg = colors.red },
    Repeat = { fg = colors.red },
    Keyword = { fg = colors.red },
    Typedef = { fg = colors.red },
    Exception = { fg = colors.red },
    Statement = { fg = colors.red },
    Error = { fg = colors.red },
    StorageClass = { fg = colors.peach },
    Tag = { fg = colors.peach },
    Label = { fg = colors.peach },
    Structure = { fg = colors.peach },
    Operator = { fg = colors.peach },
    Title = { fg = colors.peach, bold = true },
    Special = { fg = colors.yellow },
    SpecialChar = { fg = colors.yellow },
    Type = { fg = colors.yellow, bold = true },
    Function = { fg = colors.green, bold = true },
    Delimiter = { fg = colors.subtext2 },
    Ignore = { fg = colors.subtext2 },
    Macro = { fg = colors.teal },
    String = { fg = colors.teal },
    Comment = { fg = colors.overlay2, italic = true },

    -- [10] Treesitter & LSP Highlighting (Comprehensive)
    ["@variable"] = { fg = colors.text },
    ["@variable.builtin"] = { fg = colors.red },
    ["@variable.parameter"] = { fg = colors.text },
    ["@variable.member"] = { fg = colors.blue },
    ["@property"] = { fg = colors.blue },
    ["@field"] = { fg = colors.blue },
    ["@parameter"] = { fg = colors.text },
    ["@constant"] = { fg = colors.text },
    ["@constant.builtin"] = { fg = colors.mauve },
    ["@constructor"] = { fg = colors.green, bold = true },
    ["@module"] = { fg = colors.yellow },
    ["@namespace"] = { fg = colors.yellow },
    ["@label"] = { fg = colors.peach },
    ["@attribute"] = { fg = colors.mauve },
    ["@none"] = { fg = colors.text },

    -- Language specific
    ["@tag"] = { fg = colors.peach },
    ["@tag.attribute"] = { fg = colors.green },
    ["@tag.delimiter"] = { fg = colors.green },

    -- Feature Files (Cucumber/Gherkin)
    ["@gherkin.feature"] = { fg = colors.peach, bold = true },
    ["@gherkin.scenario"] = { fg = colors.peach, bold = true },
    ["@gherkin.step"] = { fg = colors.text },
    ["@gherkin.keyword"] = { fg = colors.peach, bold = true },
    ["@gherkin.text"] = { fg = colors.text },
    ["@gherkin.parameter"] = { fg = colors.sky },
    ["@gherkin.tag"] = { fg = colors.mauve },
    ["@keyword.gherkin"] = { fg = colors.peach, bold = true },
    ["@string.gherkin"] = { fg = colors.teal },
    ["@cucumber.step"] = { fg = colors.text },
    ["@cucumber.keyword"] = { fg = colors.peach, bold = true },
    gherkinFeature = { fg = colors.peach, bold = true },
    gherkinScenario = { fg = colors.peach, bold = true },
    gherkinKeyword = { fg = colors.peach, bold = true },
    gherkinStep = { fg = colors.text },
    gherkinText = { fg = colors.text },
    gherkinParameter = { fg = colors.sky },
    gherkinTags = { fg = colors.mauve },

    -- Git Commit
    gitcommitSummary = { fg = colors.red, bold = true },
    gitcommitHeader = { fg = colors.peach },
    gitcommitOverflow = { fg = colors.red },
    gitcommitSelectedFile = { fg = colors.green },
    gitcommitDiscardedFile = { fg = colors.red },

    -- Markdown
    ["@markup.heading.1.markdown"] = { fg = colors.yellow, bold = true },
    ["@markup.heading.2.markdown"] = { fg = colors.peach, bold = true },
    ["@markup.heading.3.markdown"] = { fg = colors.green, bold = true },
    ["@markup.heading.4.markdown"] = { fg = colors.teal, bold = true },
    ["@markup.heading.5.markdown"] = { fg = colors.blue, bold = true },
    ["@markup.heading.6.markdown"] = { fg = colors.mauve, bold = true },
    ["@markup.list"] = { fg = colors.peach },
    ["@markup.list.checked"] = { fg = colors.green, strikethrough = true },
    ["@markup.list.unchecked"] = { fg = colors.overlay1 },
    ["@markup.link"] = { fg = colors.teal, underline = true },
    ["@markup.link.label"] = { fg = colors.sky, bold = true },
    ["@markup.link.url"] = { fg = colors.overlay0, underline = true, italic = true },
    ["@markup.raw"] = { fg = colors.green, bg = colors.surface0 },
    ["@markup.raw.block"] = { fg = colors.text, bg = colors.surface0 },
    ["@markup.raw.delimiter"] = { fg = colors.overlay0 },
    ["@markup.italic"] = { fg = colors.subtext1, italic = true },
    ["@markup.strong"] = { fg = colors.text, bold = true },
    ["@markup.strikethrough"] = { fg = colors.overlay1, strikethrough = true },
    ["@markup.quote"] = { fg = colors.subtext0, italic = true, bg = colors.surface0 },

    -- LSP Semantic Tokens
    ["@lsp.type.variable"] = { link = "@variable" },
    ["@lsp.type.property"] = { link = "@property" },
    ["@lsp.type.function"] = { link = "@function" },
    ["@lsp.type.parameter"] = { fg = colors.text },
    ["@lsp.type.member"] = { link = "@variable.member" },
    ["@lsp.type.type"] = { link = "@type" },
    ["@lsp.type.class"] = { link = "@type" },
    ["@lsp.type.enum"] = { link = "@type" },
    ["@lsp.type.enumMember"] = { link = "@variable.member" },
    ["@lsp.type.namespace"] = { link = "@namespace" },
    ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },

    -- Diff & Git
    DiffAdd = { bg = "#374a2f", fg = colors.none },
    DiffChange = { bg = "#2e3a4a", fg = colors.none },
    DiffDelete = { bg = "#4a2f2f", fg = colors.red },
    DiffText = { bg = "#3a5060", fg = colors.none },
    DiffTextAdd = { bg = "#2a5040", fg = colors.none }, -- 0.12: added text within a changed line
    diffAdded = { fg = colors.green },
    diffRemoved = { fg = colors.red },
    diffChanged = { fg = colors.blue },

    -- New highlight groups
    SnippetTabstopActive = { bg = colors.surface1, underline = true }, -- active snippet tabstop
    PmenuBorder = { fg = colors.surface2, bg = colors.mantle }, -- completion popup border (pumborder)
    PmenuShadow = { bg = colors.crust }, -- completion popup shadow
    OkMsg = { fg = colors.green }, -- success messages
    StderrMsg = { fg = colors.red }, -- stderr messages
    StdoutMsg = { fg = colors.text }, -- stdout messages
  }

  for group, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

-- Create autocommand to apply overrides whenever catppuccin is loaded
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("NativeCatppuccinOverrides", { clear = true }),
  pattern = "catppuccin*",
  callback = apply_custom_highlights,
})

-- Load the colorscheme
vim.cmd("colorscheme catppuccin")
