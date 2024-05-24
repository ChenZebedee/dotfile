local m = {
  require("oneDarkPro").setup({
    style = "deep",
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
      strings = true,
      comments = true,
      operators = false,
      folds = true,
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
      SignColumn = { bg = "#680000" },
    },
    dim_inactive = false,
    transparent_mode = true,
  }),
}

return m
