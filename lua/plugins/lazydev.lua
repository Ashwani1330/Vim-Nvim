return {
  "folke/lazydev.nvim",
  ft = "lua", -- Only load when editing Lua files
  opts = {
    library = {
      -- See https://github.com/folke/lazydev.nvim/tree/main/types
      -- You can explicitly specify a version of Neovim if you want to
      -- "neovim/v0.10",
      -- Or automatically detect the current version
      "neovim",

      -- Your own config directory will be automatically included
      -- You can add other directories here, for example:
      -- "~/projects/my-awesome-plugin",

      -- Add any missing types here. If you know the plugin provides Make sure to install the plugin if you want to use it
      -- { path = "LazyVim/LazyVim", words = { "LazyVim" } },
    },
    lspconfig = true, -- Configure LuaLS for you
    -- runtime_path = "lua", -- If your Lua files are not in the default 'lua' directory
  },
  -- Ensure it loads after your LSP client and cmp setup if you want it to configure those
  -- For example, if you use nvim-lspconfig and nvim-cmp:
  -- dependencies = {
  --   "neovim/nvim-lspconfig",
  --   "hrsh7th/nvim-cmp",
  -- },
}
