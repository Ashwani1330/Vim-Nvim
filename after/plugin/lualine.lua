require('lualine').setup {
    options = {
        component_separators = '',
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
        lualine_z = {
            { 'location', separator = { right = '' }, left_padding = 2 },
        }
    }
}

