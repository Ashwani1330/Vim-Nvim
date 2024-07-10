function ColorMyPencils(color)
    color = color or "rose-pine-moon"
    vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- Default options:
require('kanagawa').setup({
    compile = false,             -- enable compiling the colorscheme
    undercurl = true,            -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true},
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = true,         -- do not set background color
    dimInactive = true,         -- dim inactive window `:h hl-NormalNC`
    terminalColors = true,       -- define vim.g.terminal_color_{0,17}
    colors = {                   -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
    },
    overrides = function(colors) -- add/modify highlights
        return {}
    end,
    theme = "wave",              -- Load "wave" theme when 'background' option is not set
    background = {               -- map the value of 'background' option to a theme
        dark = "wave",           -- try "dragon" !
        light = "lotus"
    },
})


-- ColorMyPencils()

local g = vim.g
local o = vim.o

require("tokyonight").setup({
    -- your configuration comes here
    -- or leave it empty to use the default settings
    style = "moon", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
    light_style = "moon", -- The theme is used when the background is set to light
    transparent = true, -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
    styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark", -- style for sidebars, see below
        floats = "dark", -- style for floating windows
    },
    sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
    day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
    dim_inactive = true, -- dims inactive windows
    lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    ---@param colors ColorScheme
    on_colors = function(colors) end,

    --- You can override specific highlights to use other groups or a hex color
    --- function will be called with a Highlights and ColorScheme table
    ---@param highlights Highlights
    ---@param colors ColorScheme
    on_highlights = function(highlights, colors) end,
})


-- setup must be called before loading
--vim.cmd("colorscheme tokyonight")

g.gruvbox_material_disable_italic_comment = 1
g.gruvbox_material_enable_italic = 1
g.gruvbox_material_enable_bold = 1
g.gruvbox_material_transparent_background = 1
g.gruvbox_material_foreground = 'mix' 
g.gruvbox_material_background = 'material'

g.dracula_bold = 1
g.dracula_italic = 1
g.dracula_underline = 1
g.dracula_undercurl = 1
g.dracula_full_special_attrs_support = 1
g.dracula_inverse = 1
g.dracula_colorterm = 0


--[[ Set contrast.
This configuration option should be placed before `colorscheme everforest`.
Available values: 'hard', 'medium'(default), 'soft'
]]-- 

g.everforest_background = 'hard'
-- For better performance
g.everforest_better_performance = 1
g.everforest_transparent_background = 1

-- vim.cmd("colorscheme everforest")
-- g.gruvbox_transparent_bg = 1

require('rose-pine').setup({
    disable_background = true,
    variant = "moon", -- auto, main, moon, or dawn
    dark_variant = "main", -- main, moon, or dawn
    dim_inactive_windows = true,
    extend_background_behind_borders = true,
    enable = {
        terminal = true,
        legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        migrations = true, -- Handle deprecated options automatically
    },
    styles = {
        bold = true,
        italic = true,
        transparency = false,
    },
})

-- ColorMyPencils()
vim.cmd("colorscheme rose-pine")
