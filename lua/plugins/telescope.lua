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
