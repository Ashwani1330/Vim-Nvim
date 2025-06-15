return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        -- Your existing parsers
        "bash", "c", "cpp", "css", "diff", "dockerfile", "go", "graphql", "html",
        "javascript", "json", "jsonc", "kotlin", "lua", "luadoc", "luap",
        "make", "markdown", "markdown_inline", "python", "query", "regex", "rust",
        "sql", "svelte", "tsx", "typescript", "vim", "vimdoc", "yaml", "java", "dart",

        -- Add C# and related web parsers
        "c_sharp",
        "xml", -- For .csproj, Unity XML files
        -- "html", "css", "json" are already there, which is good.
        -- "bicep", -- If you choose to use bicep-lsp
      },
      sync_install = false,
      auto_install = true,
      ignore_install = { "" },
      highlight = {
        enable = true,
        disable = function(lang, buf)
            local max_filesize = 100 * 1024
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
        disable = { "yaml" },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<CR>',
          node_incremental = '<CR>',
          scope_incremental = '<TAB>',
          node_decremental = '<S-CR>',
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
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
    }
  end,
}
