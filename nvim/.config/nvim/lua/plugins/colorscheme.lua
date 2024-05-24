return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  { "nxstynate/oneDarkPro.nvim", priority = 1000 },
  { "tanvirtin/monokai.nvim" },
  { "folke/tokyonight.nvim", opts = {
    style = "night",
    transparent = true,
  } },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  -- 配置 LazyVim 以加载gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "oneDarkPro",
    },
  },
}
