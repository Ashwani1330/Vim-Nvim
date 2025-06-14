return {
  "akinsho/toggleterm.nvim",
  version = "*", -- Or pin to a specific release tag
  -- No specific event needed for it to load if you use keymaps to trigger it.
  -- If you want it to always be available very early:
  -- event = "VeryLazy",
  -- However, it's common to load it on keypress.
  keys = {
    -- Example keymaps (these will also cause the plugin to load on first use)
    -- You can put these directly here, or in your dedicated keymap file (e.g., lua/akm/remap.lua)
    -- and then `toggleterm.nvim` can just have `event = "VeryLazy"` or no specific load trigger.
    { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal (generic)" },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle Floating Term" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Toggle Horizontal Term (bottom)" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Toggle Vertical Term (side)" },
    -- Terminal mode mappings
    -- To exit terminal mode easily, e.g., with <Esc> or <C-\><C-n>
    -- These are often set within the config function's on_open callback.
  },
  config = function()
    require("toggleterm").setup({
      -- size can be a number or a function which is passed the current terminal
      size = function(term)
        if term.direction == "horizontal" then
          return 15 -- Or a percentage like '30%'
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
        return 10 -- Default for float if not specified
      end,
      open_mapping = [[<c-\><c-\>]], -- Can be used to open a new terminal if none are active
      hide_numbers = true, -- Hide numbers in terminal buffers
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2, -- '1' | '2' | '3' how dark the shading is for inactive terminals
      start_in_insert = true,
      insert_mappings = true, -- Whether or not the open mapping applies in insert mode
      terminal_mappings = true, -- Whether or not the open mapping applies in the opened terminals
      persist_size = true,
      persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
      direction = 'horizontal', -- Default direction: 'horizontal', 'vertical', 'float', 'tab'
      close_on_exit = true, -- Close the terminal window when the process exits
      shell = vim.o.shell, -- Change the default shell
      auto_scroll = true, -- Autoscroll to bottom of terminal
      -- This function runs when the terminal window is opened
      on_open = function(term)
        vim.cmd("setlocal nonumber norelativenumber")
        vim.cmd("setlocal signcolumn=no") -- No signcolumn in terminal
        -- Example: Go to insert mode automatically
        -- if vim.fn.mode() ~= "i" then
        --   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>i", true, false, true), "n", false)
        -- end

        -- Custom keymap to close terminal with <Esc> in Terminal mode
        -- This is a common convenience.
        -- Note: This might interfere if you use <Esc> for other things in terminal mode (e.g. with tmux prefix)
        vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { buffer = term.bufnr, silent = true, desc = "Exit Terminal Mode" })
        -- Or, to close the terminal window itself with <Esc><Esc>
        -- vim.keymap.set('t', '<Esc><Esc>', function()
        --   require('toggleterm').close(term.id)
        -- end, { buffer = term.bufnr, silent = true, desc = "Close Terminal" })
      end,
      -- This function runs when the terminal window is closed
      -- on_close = function(term)
      -- end,
      float_opts = {
        -- Options for floating window, see vim.api.nvim_open_win
        border = 'curved', -- 'single', 'double', 'rounded', 'solid', 'shadow', 'curved'
        -- width = <value>,
        -- height = <value>,
        winblend = 0, -- Makes the float window opaque
        highlights = {
          border = "Normal",
          background = "Normal",
        }
      }
    })

    -- You can also define custom terminals here if needed
    -- function _G.set_terminal_keymaps()
    --   local opts = {buffer = 0}
    --   vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    --   vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts) -- Example: jk to exit terminal mode
    --   vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    --   vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    --   vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    --   vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    -- end
    --
    -- -- When a terminal is opened, call the function from above to set keymaps.
    -- vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

    -- More specific keymaps (can be defined here or in your main keymap file)
    -- These are often preferred in a central keymap file (e.g., lua/akm/remap.lua)
    -- local map = vim.keymap.set
    -- map('n', '<leader>tl', '<cmd>ToggleTerm direction=float<cr>', { desc = "ToggleTerm Float" })
    -- map('n', '<leader>th', '<cmd>ToggleTerm direction=horizontal<cr>', { desc = "ToggleTerm Horizontal" })
    -- map('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical<cr>', { desc = "ToggleTerm Vertical" })
    -- map('n', '<leader>tn', '<cmd>ToggleTerm direction=tab<cr>', { desc = "ToggleTerm Tab" })
    --
    -- -- Lazygit terminal
    -- local Terminal = require('toggleterm.terminal').Terminal
    -- local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
    -- function _LAZYGIT_TOGGLE()
    --   lazygit:toggle()
    -- end
    -- map("n", "<leader>lg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { desc = "ToggleTerm Lazygit" })
  end,
}
