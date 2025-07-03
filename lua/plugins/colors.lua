-- You'd typically call this from your init.lua or a command after plugins load.
_G.ColorMyPencils = function(color)
  color = color or "catppuccin" -- Default if no argument (set to catppuccin)
  vim.cmd.colorscheme(color)
  -- Optional: make background transparent for the chosen scheme
  -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  print("Colorscheme set to: " .. color)
end

return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "auto", -- latte, frappe, macchiato, mocha
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = true,
        show_end_of_buffer = false,
        term_colors = false,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        no_italic = false,
        no_bold = false,
        no_underline = false,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        color_overrides = {},
        custom_highlights = {},
        default_integrations = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = false,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
        },
      })
      -- setup must be called before loading
      -- vim.cmd.colorscheme "catppuccin"
    end,
  },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000, -- High priority to load early
    opts = {
      style = "storm",
      light_style = "storm",
      transparent = true,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "dark",
        floats = "dark",
      },
      sidebars = { "qf", "help", "neo-tree", "NvimTree" },
      day_brightness = 0.3,
      hide_inactive_statusline = false,
      dim_inactive = true,
      lualine_bold = true,
      on_colors = function(colors) end,
      on_highlights = function(highlights, colors) end,
    },
    -- config = function(_, opts) -- Use this if opts alone isn't enough
    --   require("tokyonight").setup(opts)
    -- end,
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    opts = {
      disable_background = true, -- For transparency
      variant = "moon",
      dark_variant = "main",
      dim_inactive_windows = true,
      extend_background_behind_borders = true,
      enable = {
        terminal = true,
        legacy_highlights = true,
        migrations = true,
      },
      styles = {
        bold = true,
        italic = true,
        transparency = true, -- This is the key for rose-pine transparency
      },
    },
    -- config = function(_, opts)
    --   require('rose-pine').setup(opts)
    -- end
  },

  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      compile = false,
      undercurl = true,
      commentStyle = { italic = true },
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      transparent = true,
      dimInactive = true,
      terminalColors = true,
      theme = "wave", -- or "dragon", "lotus"
      background = { dark = "wave", light = "lotus" },
    },
  },

  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false,
    priority = 1000, -- Make sure this priority is high enough or it loads after other themes if they also try to set a colorscheme
    config = function()
      -- Moonfly is a vimscript theme, global settings are common
      vim.g.moonflyTransparent = 1
      vim.g.moonflyUndercurls = 1
      vim.g.moonflyCursorColor = 1 -- Or true

      -- Set moonfly as the default colorscheme
      vim.cmd.colorscheme "moonfly"
    end,
  },

  {
    "morhetz/gruvbox", -- This is the original vimscript gruvbox
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_transparent_bg = 1
      vim.o.background = "dark" -- or "light"
      -- vim.cmd.colorscheme "gruvbox"
    end,
  },
  -- Note: You also had settings for gruvbox-material, which is a different plugin.
  -- If you use 'sainnhe/gruvbox-material', add its spec:
  -- {
  --   "sainnhe/gruvbox-material",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.g.gruvbox_material_disable_italic_comment = 1
  --     vim.g.gruvbox_material_enable_italic = 1
  --     vim.g.gruvbox_material_enable_bold = 1
  --     vim.g.gruvbox_material_transparent_background = 1 -- 0, 1, or 2
  --     vim.g.gruvbox_material_foreground = 'mix'
  --     vim.g.gruvbox_material_background = 'material' -- or 'hard', 'soft'
  --     vim.g.gruvbox_material_ui_contrast = 'high' -- or 'low', 'medium'
  --     -- vim.cmd.colorscheme "gruvbox-material"
  --   end,
  -- },


  {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.everforest_background = 'hard' -- 'medium', 'soft'
      vim.g.everforest_better_performance = 1
      vim.g.everforest_transparent_background = 1 -- 0 for opaque, 1 for transparent, 2 for transparent with statusline
      vim.o.background = "dark" -- or "light"
      -- vim.cmd.colorscheme "everforest"
    end,
  },

  {
    "cocopon/iceberg.vim", -- Vimscript theme
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.g.iceberg_transparent_background = 1 -- Check plugin docs for transparency option
      -- vim.cmd.colorscheme "iceberg"
    end,
  },

  {
    "projekt0n/github-nvim-theme",
    lazy = false, -- You can set this to true if you rarely use it and want to load it on demand
    priority = 1000, -- Lower priority if lazy = true and it's not a default
    config = function(_, opts)
      require('github-theme').setup(opts)
    end,
    opts = {
      options = { -- Nest options under an 'options' table as per deprecation notices
        transparent = true,
        styles = {
          comments = "italic",
          keywords = "italic",
          -- You can add other style options here based on the plugin's documentation
          -- e.g., functions = "NONE", variables = "NONE", etc.
        },
        -- Add other specific settings from the plugin's documentation if needed
        -- theme_style = "dark_dimmed", -- for example
        -- dev = false,
      },
      -- Any other top-level opts that are NOT under the 'options = {}' table,
      -- based on the plugin's current documentation.
      -- For example, if 'theme_style' was NOT under 'options':
      -- theme_style = "dark_dimmed",
      -- But based on the deprecation, most seem to be moving under 'options'.
    },
  },

  -- Add other themes like dracula if you use them as plugins
  -- For dracula, if it's 'dracula/vim'
  -- {
  --   "dracula/vim",
  --   name = "dracula",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.g.dracula_bold = 1
  --     vim.g.dracula_italic = 1
  --     vim.g.dracula_underline = 1
  --     vim.g.dracula_undercurl = 1
  --     vim.g.dracula_transparent_bg = true -- Check plugin docs for exact option name
  --     -- vim.cmd.colorscheme "dracula"
  --   end,
  -- }
}
