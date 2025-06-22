return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.6', -- Updated to a more recent stable tag
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  cmd = "Telescope",
  keys = {
    { '<leader>pf', function() require('telescope.builtin').find_files() end, desc = "Find Files" },
    { '<leader>pg', function() require('telescope.builtin').live_grep() end, desc = "Live Grep" },
    { '<leader>pb', function() require('telescope.builtin').buffers() end, desc = "Find Buffers" },
    { '<leader>ph', function() require('telescope.builtin').help_tags() end, desc = "Help Tags" },
    { '<leader>po', function() require('telescope.builtin').oldfiles() end, desc = "Old Files" },
    { '<leader>pc', function() require('telescope.builtin').commands() end, desc = "Commands" },
    { '<C-p>',      function() require('telescope.builtin').git_files() end, desc = "Git Files (Root)" },
    {
      '<leader>ps',
      function()
        require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ") })
      end,
      desc = "Grep String",
    },
  },
  config = function(_, opts)
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    telescope.setup({
      defaults = {
        prompt_prefix = "  ",
        selection_caret = " ",
        path_display = { "truncate" },
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = { preview_width = 0.55, results_width = 0.8 },
          vertical = { mirror = false },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        sorting_strategy = "ascending",
        -- Key performance improvement: ignore large directories
        file_ignore_patterns = {
          "node_modules",
          "%.git/",
          -- Add any other large directories you want to ignore
          -- For Unity projects, this is crucial:
          "[Ll]ibrary/",
          "[Tt]emp/",
          "[Oo]bj/",
          "[Bb]uild/",
          "[Ll]ogs/",
          "%.meta",
          "%.asset"
        },
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<esc>"] = actions.close,
          },
          n = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          }
        }
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        live_grep = {},
        buffers = {
          sort_mru = true,
          ignore_current_buffer = true,
        }
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    pcall(telescope.load_extension, 'fzf')
  end,
}
--[[ return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.5', -- Or a more recent stable tag, or remove for latest
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Optional: for fzf native sorter
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    -- Optional: for other extensions
    -- { 'nvim-telescope/telescope-symbols.nvim' }
  },
  cmd = "Telescope", -- Load when :Telescope command is used
  keys = {
    { '<leader>pf', function() require('telescope.builtin').find_files() end, desc = "Find Files" },
    { '<leader>pg', function() require('telescope.builtin').live_grep() end, desc = "Live Grep" },
    { '<leader>pb', function() require('telescope.builtin').buffers() end, desc = "Find Buffers" },
    { '<leader>ph', function() require('telescope.builtin').help_tags() end, desc = "Help Tags" },
    { '<leader>po', function() require('telescope.builtin').oldfiles() end, desc = "Old Files" },
    { '<leader>pc', function() require('telescope.builtin').commands() end, desc = "Commands" },
    { '<C-p>',      function() require('telescope.builtin').git_files() end, desc = "Git Files (Root)" },
    {
      '<leader>ps',
      function()
        require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ") })
      end,
      desc = "Grep String",
    },
    -- Add more keymaps as needed, e.g., for current_buffer_fuzzy_find, diagnostics, etc.
  },
  config = function(_, opts)
    local telescope = require('telescope')
    telescope.setup({
      defaults = {
        prompt_prefix = "  ", -- Nerd Font icon for search
        selection_caret = " ", -- Nerd Font icon for selection
        path_display = { "truncate" }, -- "smart", "absolute", "relative"
        layout_strategy = 'horizontal', -- 'flex', 'vertical', 'cursor'
        layout_config = {
          horizontal = { preview_width = 0.55, results_width = 0.8 },
          vertical = { mirror = false },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        sorting_strategy = "ascending",
        mappings = {
          i = {
            ["<C-j>"] = require('telescope.actions').move_selection_next,
            ["<C-k>"] = require('telescope.actions').move_selection_previous,
            ["<C-q>"] = require('telescope.actions').send_to_qflist + require('telescope.actions').open_qflist,
            ["<esc>"] = require('telescope.actions').close,
          },
          n = {
            ["<C-j>"] = require('telescope.actions').move_selection_next,
            ["<C-k>"] = require('telescope.actions').move_selection_previous,
            ["<C-q>"] = require('telescope.actions').send_to_qflist + require('telescope.actions').open_qflist,
          }
        }
        -- file_ignore_patterns = {"node_modules", ".git"},
      },
      pickers = {
        -- Configure individual pickers if needed
        find_files = {
          -- theme = "dropdown",
          hidden = true, -- Show hidden files
        },
        live_grep = {
          -- theme = "dropdown",
        },
        buffers = {
          -- theme = "dropdown",
          sort_mru = true,
          ignore_current_buffer = true,
        }
      },
      extensions = {
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case", "respect_case"
        },
        -- symbols = {
        --   -- configure symbols extension
        -- }
      },
    })

    -- To use fzf native, uncomment this if you've installed it as a dependency
    pcall(telescope.load_extension, 'fzf')
    -- pcall(telescope.load_extension, 'symbols')
  end,
} ]]

