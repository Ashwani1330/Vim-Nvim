return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate', -- Or function() vim.cmd('TSUpdate') end
  event = { "BufReadPre", "BufNewFile" }, -- Load early for highlighting and other features
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects', -- Optional, for more text objects
    -- 'nvim-treesitter/playground', -- If you use the playground
  },
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = { -- A list of parser names, or "all"
        "bash", "c", "cpp", "css", "diff", "dockerfile", "go", "graphql", "html",
        "javascript", "json", "jsonc", "kotlin", "lua", "luadoc", "luap",
        "make", "markdown", "markdown_inline", "python", "query", "regex", "rust",
        "sql", "svelte", "tsx", "typescript", "vim", "vimdoc", "yaml", "java", "dart",
        -- Add any other languages you frequently use
      },
      sync_install = false, -- Install parsers synchronously (only applied to ensure_installed)
      auto_install = true,  -- Automatically install missing parsers when entering buffer
      ignore_install = { "" }, -- List of parsers to ignore installing

      highlight = {
        enable = true,
        disable = function(lang, buf) -- Disable for large files
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
        additional_vim_regex_highlighting = false, -- Or a list of languages
      },
      indent = {
        enable = true,
        disable = { "yaml" }, -- Disable for specific languages if needed
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<CR>',    -- maps in normal mode to init the node/scope selection
          node_incremental = '<CR>',  -- maps in normal mode to increment the node/scope selection
          scope_incremental = '<TAB>', -- maps in normal mode to increment the scope selection
          node_decremental = '<S-CR>', -- maps in normal mode to decrement the node/scope selection
        },
      },
      textobjects = { -- If using nvim-treesitter-textobjects
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            -- Add more as needed
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
      },
      -- Other modules: context_commentstring, playground, etc.
      -- playground = { enable = true },
    }

    -- Add the playground as a separate plugin if you want to toggle it with a command
    -- (already listed in your main packer file, so it can be its own spec)
  end,
}

-- If you use playground often, add this as a separate spec in this file or another
-- return {
--   ... (main treesitter spec above) ...,
--   {
--     'nvim-treesitter/playground',
--     cmd = "TSPlaygroundToggle", -- Load when command is run
--     dependencies = "nvim-treesitter/nvim-treesitter", -- ensure main treesitter is a dep
--   }
-- }
-- To return multiple specs from one file, the file must return a list of tables:
-- return {
--   { main treesitter spec },
--   { playground spec }
-- }
