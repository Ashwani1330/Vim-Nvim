return {
  'RRethy/vim-illuminate',
  event = { "BufReadPost", "BufNewFile", "CursorHold", "CursorMoved" }, -- Load on these events
  -- Or just "VeryLazy" and let it attach automatically
  opts = { -- Pass configuration directly to opts if the plugin supports it
    providers = {
      'lsp',
      'treesitter',
      'regex',
    },
    delay = 100,
    filetype_overrides = {},
    filetypes_denylist = {
      'dirvish',
      'fugitive',
      'neo-tree', -- Add file explorer
      'NvimTree',
    },
    filetypes_allowlist = {},
    modes_denylist = {},
    modes_allowlist = {},
    providers_regex_syntax_denylist = {},
    providers_regex_syntax_allowlist = {},
    under_cursor = true,
    large_file_cutoff = nil,
    large_file_overrides = nil,
    min_count_to_highlight = 1,
  },
  config = function(_, opts)
    require('illuminate').configure(opts)
  end,
}
