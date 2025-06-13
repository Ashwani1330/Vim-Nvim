local navic = require("nvim-navic")

require("lualine").setup {
  options = {
    theme = "auto",
    component_separators = '',
    section_separators = { left = '', right = '' },
    disabled_filetypes = { 'NvimTree', 'neo-tree', 'alpha' },
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 }
    },
    lualine_b = { 'branch' },
    lualine_c = {
      {
        'filename',
        path = 0,           -- Just the file name (not full path)
        symbols = {
          modified = ' ●', -- Shows when file is modified
          readonly = ' ',
          unnamed = '[No Name]',
        }
      },

      {
        function()
          return navic.is_available() and navic.get_location() or ''
        end,
        cond = navic.is_available,
        color = { fg = "#9CDCFE" },
      }
    },
    lualine_x = { 'encoding', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 }
    }
  }
}