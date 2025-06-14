return {
  "SmiteshP/nvim-navic",
  event = { "BufReadPre", "BufNewFile" }, -- Or "LspAttach" if you want to be more precise
  -- Ensure it loads if lsp-zero (or whatever uses it) is loaded.
  -- If lsp-zero is already handling its loading via dependencies, this event might be redundant
  -- but doesn't hurt.
  config = function()
    local navic = require("nvim-navic")

    navic.setup({
      highlight = true, -- enables hl groups defined below
      separator = " › ",
      depth_limit = 4,
      icons = {
        File = " ",
        Module = "",
        Class = "󰠱", -- Ensure your font supports this character (e.g., Nerd Font)
        Method = "󰆧", -- Ensure your font supports this character
        Function = "󰊕", -- Ensure your font supports this character
        Namespace = "󰌗", -- Ensure your font supports this character
        -- You can add more or change as per nvim-navic's defaults or your preference
        -- Variable = "󰀫",
        -- Constructor = "",
        -- Interface = "",
        -- Struct = "",
        -- Event = "",
        -- Operator = "󰆕",
        -- TypeParameter = "󰊄",
      }
    })

    -- Custom highlight colors
    -- These should be defined after navic.setup if highlight = true,
    -- or ensure they are set before navic attaches to any buffer if not.
    -- It's generally fine to set them here.
    vim.api.nvim_set_hl(0, "NavicText", { fg = "#9CDCFE", bg = "NONE" })       -- cyan for breadcrumbs
    vim.api.nvim_set_hl(0, "NavicSeparator", { fg = "#737AA2", bg = "NONE" }) -- grayish blue for separator

    -- Note: lsp-zero's on_attach function already handles:
    -- local navic_ok, navic = pcall(require, "nvim-navic")
    -- if navic_ok and client.server_capabilities.documentSymbolProvider then
    --   navic.attach(client, bufnr)
    -- end
    -- So you don't need to repeat the attach logic here. This config function
    -- is just for setting up nvim-navic's options and highlights.
  end,
}
