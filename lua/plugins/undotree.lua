return {
  'mbbill/undotree',
  cmd = "UndotreeToggle", -- Load when command is run
  keys = {
    { "<F4>", "<Cmd>UndotreeToggle<CR>", desc = "Toggle Undotree" },
  },
  config = function()
    -- vim.g.undotree_WindowLayout = 2 -- Example: Set layout (check :help undotree)
    -- vim.g.undotree_DiffAutoOpen = 1
  end,
}
