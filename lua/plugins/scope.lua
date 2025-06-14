return {
  "tiagovla/scope.nvim",
  -- No specific event or command needed for it to load,
  -- as it typically integrates with bufferline plugins which load early.
  -- If you want to ensure it loads after your bufferline, you can add a dependency.
  -- For example, if your bufferline plugin is 'akinsho/bufferline.nvim':
  -- dependencies = { "akinsho/bufferline.nvim" },
  config = function()
    require("scope").setup({
      -- You can add any specific configuration options for scope.nvim here
      -- if needed. The default {} is often fine.
      -- For example:
      -- listeners = { -- enable listeners if you want scope to automatically refresh
      --   { "tabnew", "tabclose", "tabentered", "tableft" }, -- Default listeners
      --   autocmd = true, -- enable autocmd listeners
      --   user = true, -- enable user listeners
      -- },
    })
  end,
}
