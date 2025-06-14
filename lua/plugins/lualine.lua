return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- Recommended for icons
    'SmiteshP/nvim-navic',       -- If you use navic in lualine
  },
  event = "VeryLazy", -- Or "BufEnter", "WinEnter" - loads when UI is generally ready
  config = function()
    local navic_ok, navic = pcall(require, "nvim-navic")

    require('lualine').setup {
      options = {
        theme = 'auto', -- Or your preferred theme like 'tokyonight', 'catppuccin', etc.
        component_separators = '', -- { left = '', right = '' },
        section_separators = { left = '', right = '' }, -- { left = '', right = '' },
        disabled_filetypes = {
          statusline = { 'NvimTree', 'neo-tree', 'alpha', 'dashboard', 'Outline' }, -- Add 'Outline' or other plugin buffers
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true, -- THIS MAKES THE STATUSLINE GLOBAL
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      sections = {
        lualine_a = { { 'mode', separator = { left = '' }, right_padding = 1 } },
        lualine_b = { 'branch', 'diff' },
        lualine_c = {
          {
            'filename',
            path = 0, -- 0: JUST FILENAME, 1: relative path, 2: absolute path
            shorting_rule = 'truncate_left', -- 'u', 'm', 't' (applies if filename is too long)
            symbols = {
              modified = ' ●', -- Added a space for slight padding
              readonly = ' ',
              unnamed = '[No Name]',
              newfile = '[New]',
            }
          },
          { -- nvim-navic component
            function()
              if navic_ok and navic.is_available() then
                return navic.get_location()
              end
              return ''
            end,
            cond = function() return navic_ok and navic.is_available() end,
            color = { fg = "#9CDCFE" }, -- Your custom navic color
          }
        },
        lualine_x = { 'diagnostics', 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { { 'location', separator = { right = '' }, left_padding = 1 } }
      },
      inactive_sections = {
        -- When globalstatus is true, inactive_sections are less relevant for the main statusline
        -- but can affect winbars if you use them per window.
        -- For consistency if globalstatus were false, or for winbars:
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', path = 0 } }, -- JUST FILENAME FOR INACTIVE WINDOWS TOO
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {}, -- You can configure a tabline here if you want one
      winbar = {},  -- Or a winbar
      inactive_winbar = {},
      extensions = {'nvim-tree', 'neo-tree', 'quickfix', 'toggleterm', 'lazy', 'mason'} -- Added common extensions
    }
  end,
}
