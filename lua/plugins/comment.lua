return {
  'numToStr/Comment.nvim',
  event = { "BufReadPre", "BufNewFile" }, -- Load it early enough for commenting needs
  -- Or, if you prefer to load it even later and rely on keymaps to trigger loading:
  -- keys = {
  --   -- Default mappings are 'gc' and 'gb' in normal and visual mode
  --   -- If you set up custom mappings, list the LHS of one of them here.
  --   -- Example:
  --   -- { "gcc", mode = "n", desc = "Comment toggle current line" },
  --   -- { "gc", mode = { "n", "v" }, desc = "Comment toggle" },
  -- },
  config = function()
    require('Comment').setup({
      -- Add any custom configuration options here if needed
      -- For example, to add custom commentstring for a filetype:
      -- pre_hook = function(ctx)
      --   local U = require('Comment.utils')
      --   local type = U.get_region_type(ctx) -- 'line' | 'block'
      --
      --   -- For example, for `.foo` files, use `;;` for line comments
      --   if vim.bo[ctx.buf].filetype == 'foo' then
      --     if type == 'line' then
      --       ctx.cmode = U.cmode.LINE
      --       ctx.commentstring = ';;%s'
      --     elseif type == 'block' then
      --       ctx.cmode = U.cmode.BLOCK
      --       ctx.commentstring = { ';;{', ';;}' } -- Example block comment
      --     end
      --   end
      -- end,
      -- For more options, see the Comment.nvim documentation:
      -- https://github.com/numToStr/Comment.nvim#configuration
    })
  end,
}
