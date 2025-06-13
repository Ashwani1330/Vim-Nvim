require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = {"python", "c", "cpp", "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

 
   
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    -- additional_vim_regex_highlighting = false,
  },
} 


-- Config in Windows due to TreeSitter Isses
--[[
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = {},

  -- I first installed these and then disabled ensure_installed
--[[  ensure_installed = {
      "c",
      "cpp",
      "c_sharp",
      "kotlin",
      "java",
      "lua",
      "python",
      "bash",
      "json",
      "yaml",
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",        -- if using React
      "sql",
      "toml",
      "vim",
      "vimdoc",     -- helpful for :help docs
      "query",      -- required for highlighting queries in Treesitter
  },  -- kindly insert end of the block comment here (before ensure_installed one)

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    disable = {"markdown", "markdown_inline"},
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    -- additional_vim_regex_highlighting = false,
  },
}
]]--