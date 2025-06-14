return {
  "windwp/nvim-autopairs",
  event = { "InsertEnter" }, -- Load when you enter insert mode
  -- Alternatively, for very early loading:
  -- event = { "BufReadPre", "BufNewFile" },
  config = function()
    local npairs = require("nvim-autopairs")
    npairs.setup({
      check_ts = true, -- Check with treesitter
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false, -- Disable for java (if you prefer jdtls to handle it or it causes issues)
      },
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      fast_wrap = {
        map = "<M-e>",
        chars = { "{", "[", "(", '"', "'" },
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        offset = 0, -- Offset from pattern match
        end_key = "$",
        keys = "qwertyuiopzxcvbnmasdfghjkl;",
        check_comma = true,
        highlight = "PmenuSel",
        highlight_grey = "LineNr",
      },
      -- You can add more nvim-autopairs configurations here if needed
      -- Example: rule for custom pairs
      -- npairs.add_rules({
      --   require('nvim-autopairs.rules.lua'),
      --   require('nvim-autopairs.rules.json'),
      -- })
    })

    -- If you want to integrate with nvim-cmp for completion-based autopairing
    local cmp_autopairs_ok, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
    if cmp_autopairs_ok then
      local cmp_ok, cmp = pcall(require, "cmp")
      if cmp_ok then
        cmp.event:on(
          'confirm_done',
          cmp_autopairs.on_confirm_done()
        )
      end
    end
  end,
}
