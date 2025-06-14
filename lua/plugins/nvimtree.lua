return {
  "nvim-tree/nvim-tree.lua",
  version = "*", -- Or pin to a specific release tag e.g. "v1.2.3"
  lazy = false, -- Load at startup. You can change this to `cmd = "NvimTreeToggle"`
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- For file icons
  },
  config = function()
    require("nvim-tree").setup({
      -- Your NvimTree configuration options go here
      sort_by = "name",
      view = {
        width = 30,
        -- side = "left",
        -- To make NvimTree open as a float by default (relevant for your F7 mapping desire):
        -- float = {
        --   enable = true,
        --   open_win_config = {
        --     relative = "editor",
        --     border = "rounded",
        --     width = 40,
        --     height = 30,
        --     row = 1,
        --     col = 1,
        --   },
        -- },
      },
      renderer = {
        group_empty = true,
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          glyphs = {
            default = "",
            symlink = "",
            folder = {
              arrow_closed = "",
              arrow_open = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "🗑",
              ignored = "◌",
            },
          },
        },
      },
      filters = {
        dotfiles = false, -- Show dotfiles
        custom = {},
        exclude = {},
      },
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      git = {
        enable = true,
        ignore = false,
        timeout = 400,
      },
      actions = {
        open_file = {
          quit_on_open = false, -- Set to true if you want NvimTree to close when you open a file
        },
      },
      -- For more options, see :help nvim-tree-setup
    })
  end,
}
