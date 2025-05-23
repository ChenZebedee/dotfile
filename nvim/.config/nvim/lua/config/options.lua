-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

opt.wrap = true
--opt.textwidth = 80
opt.guifont = { "DejaVuSansM Nerd Font Mono", "Source Han Sans CN", "微软雅黑", "Maple Mono SC NF", ":h13" }
--opt.guifont = { "DejaVuSansM Nerd Font Mono" }
opt.winminwidth = 2
opt.list = true
opt.listchars = { space = "·" }

-- vim.g.mkdp_markdown_css = '~/.config/nvim/lua/custom/markdown_preview.css'
