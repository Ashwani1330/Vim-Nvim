-- Setup for nvim-navic with custom icons, separator, and highlights

local navic = require("nvim-navic")

navic.setup({
  highlight = true, -- enables hl groups defined below
  separator = " › ",
  depth_limit = 4,
  icons = {
    File = " ",
    Module = "",
    Class = "󰠱",
    Method = "󰆧",
    Function = "󰊕",
    Namespace = "󰌗",
  }
})

-- Custom highlight colors
vim.api.nvim_set_hl(0, "NavicText", { fg = "#9CDCFE", bg = "NONE" })       -- cyan for breadcrumbs
vim.api.nvim_set_hl(0, "NavicSeparator", { fg = "#737AA2", bg = "NONE" }) -- grayish blue for separator