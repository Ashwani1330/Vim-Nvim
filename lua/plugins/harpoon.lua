return {
  'ThePrimeagen/harpoon',
  dependencies = { "nvim-lua/plenary.nvim" }, -- Harpoon often needs plenary
  -- Lazy load on a command or key press if possible, or on VeryLazy
  -- event = "VeryLazy", -- If no specific command/key trigger is obvious for initial load
  keys = {
    { "<leader>a", function() require("harpoon.mark").add_file() end, desc = "Harpoon: Add file" },
    { "<C-e>",     function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon: Toggle menu" },
    { "<C-h>",     function() require("harpoon.ui").nav_file(1) end, desc = "Harpoon: Nav file 1" },
    { "<C-t>",     function() require("harpoon.ui").nav_file(2) end, desc = "Harpoon: Nav file 2" },
    { "<C-n>",     function() require("harpoon.ui").nav_file(3) end, desc = "Harpoon: Nav file 3" },
    { "<C-s>",     function() require("harpoon.ui").nav_file(4) end, desc = "Harpoon: Nav file 4" },
    -- You can also use strings for commands:
    -- { "<leader>ha", "<cmd>lua require('harpoon.mark').add_file()<cr>", desc = "Harpoon Add File" },
  },
  config = function()
    -- Harpoon usually doesn't need an explicit setup() call unless you're configuring options.
    -- require("harpoon").setup({}) -- if you have specific options
  end,
}
