-- Default options:
require("gruvbox").setup({
  terminal_colors = false, -- add neovim terminal colors
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = false,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {

      pythonConditional = { link = "GruvboxBlue" },
      pythonRepeat = { link = "GruvboxBlue" },

  },
  dim_inactive = false,
  transparent_mode = true,
})
vim.cmd("colorscheme gruvbox")

--[[

    pythonBuiltin = { link = "GruvboxOrange" },
    pythonBuiltinObj = { link = "GruvboxOrange" },
    pythonBuiltinFunc = { link = "GruvboxOrange" },
    pythonFunction = { link = "GruvboxAqua" },
    pythonDecorator = { link = "GruvboxRed" },
    pythonInclude = { link = "GruvboxBlue" },
    pythonImport = { link = "GruvboxBlue" },
    pythonRun = { link = "GruvboxBlue" },
    pythonCoding = { link = "GruvboxBlue" },
    pythonOperator = { link = "GruvboxRed" },
    pythonException = { link = "GruvboxRed" },
    pythonExceptions = { link = "GruvboxPurple" },
    pythonBoolean = { link = "GruvboxPurple" },
    pythonDot = { link = "GruvboxFg3" },
    -- pythonConditional = { link = "GruvboxRed" },
    -- pythonRepeat = { link = "GruvboxRed" },
    pythonDottedName = { link = "GruvboxGreenBold" },

--]]
