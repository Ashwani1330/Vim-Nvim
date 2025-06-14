-- Or add to a general 'tools.lua' or 'git.lua'
return {
  'tpope/vim-fugitive',
  cmd = "Git", -- Load when :Git command is run
  keys = {
    { "<leader>gs", "<Cmd>Git<CR>", desc = "Git (fugitive)" },
    -- Add other fugitive keymaps if you have them
    -- e.g., { "<leader>gb", "<Cmd>Git blame<CR>", desc = "Git Blame" },
  },
}
