return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    {
      "<leader>pv", -- Your keymap to toggle the tree
      "<cmd>NvimTreeToggle<CR>",
      desc = "Toggle File Explorer (NvimTree)",
    },
  },
  config = function()
    require("nvim-tree").setup({
      sort_by = "name",
      -- OPTIMIZED: Respect .gitignore and filter out Unity's generated files/folders
      filters = {
        dotfiles = false, -- Keep this if you want to see files like .gitignore
        custom = {
          -- This is the most important part for Unity projects
          "\\.meta$", -- Hide .meta files
          "Library/",
          "Temp/",
          "Logs/",
          "obj/",
          "Build/",
          "Builds/",
          "\\.vs/", -- Hide Visual Studio config folder
          "\\.vscode/", -- Hide VSCode config folder
          "\\.sln$", -- Hide solution files
          "\\.csproj$", -- Hide C# project files
        },
        exclude = {},
      },
      git = {
        enable = true,
        -- OPTIMIZED: Set to true to ignore files listed in .gitignore
        -- This is a huge performance boost for Unity projects
        ignore = true,
        timeout = 400,
      },
      -- OPTIONAL: Add diagnostic indicators to see errors/warnings in the tree
      diagnostics = {
        enable = false,
        show_on_dirs = true, -- Show diagnostics on folders
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      -- The rest of your config is great and can remain the same
      view = {
        width = 30,
        side = "right",
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
      update_focused_file = {
        enable = true,
        update_root = false,
      },
      actions = {
        open_file = {
          quit_on_open = false,
        },
      },
    })
  end,
}
