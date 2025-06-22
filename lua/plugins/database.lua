-- lua/plugins/database.lua
-- Configuration for vim-dadbod and its UI/completion plugins

return {
  -- Core Dadbod plugin
  {
    "tpope/vim-dadbod",
    lazy = true,
    cmd = { "DB" },
  },

  -- Dadbod UI plugin
  {
    "kristijanhusak/vim-dadbod-ui",
    -- Explicitly depend on the core plugin to ensure correct load order
    dependencies = { "tpope/vim-dadbod" },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    keys = {
      { "<leader>db", "<cmd>DBUIToggle<cr>", desc = "Toggle Dadbod UI" },
    },
    init = function()
      -- These global settings must be applied before the plugin loads
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_hide_password = 1
      vim.g.db_ui_win_position = 'left'
      vim.g.db_ui_win_size = 30
    end,
  },

  -- Dadbod Completion plugin
  {
    "kristijanhusak/vim-dadbod-completion",
    -- Also depends on the core plugin
    dependencies = { "tpope/vim-dadbod" },
    -- Load completion for these filetypes
    ft = { "sql", "mysql", "plsql", "mongo" },
    config = function()
      -- nvim-cmp setup
      require("cmp").setup.buffer({
        sources = {
          { name = "vim-dadbod-completion" },
        },
      })
    end,
  },
}
