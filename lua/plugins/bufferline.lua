return {
  'akinsho/bufferline.nvim',
  version = "*", -- Or a specific tag/branch
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = "VeryLazy", -- Or "BufEnter" if you want it sooner
  keys = {
    { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
    { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
    { "<leader>bd", "<Cmd>bdelete<CR>", desc = "Delete current buffer" },
    { "<leader>bo", "<Cmd>%bd|e#|bd#<CR>", desc = "Close other buffers" },
    { "<leader>ba", "<Cmd>%bd<CR>", desc = "Close all buffers" },
    {
      "<leader>br",
      function()
        -- Lua Function to Close Specific Buffer by Name
        local function close_buffer_if_exists(name_pattern)
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_name(buf):match(name_pattern) then
              vim.cmd("bdelete " .. buf)
              vim.notify("Closed buffer matching: " .. name_pattern, vim.log.levels.INFO)
              return
            end
          end
          vim.notify("No buffer matching: " .. name_pattern, vim.log.levels.WARN)
        end
        close_buffer_if_exists("README.md")
      end,
      desc = "Close README.md buffer if open",
    },

    -- General Tab navigation: Consider moving to a general keymap file (e.g., lua/akm/remap.lua)
    { "<leader>tn", "<Cmd>tabnew<CR>", desc = "New Tab" },
    { "<leader>tc", "<Cmd>tabclose<CR>", desc = "Close Tab" },
    { "<leader>to", "<Cmd>tabonly<CR>", desc = "Close Other Tabs" },
    { "<leader>]", "<Cmd>tabnext<CR>", desc = "Next Tab" },
    { "<leader>[", "<Cmd>tabprevious<CR>", desc = "Previous Tab" },
    -- Tab switching by number (1-9)
    -- These can also be in a general keymap file
    unpack((function()
      local maps = {}
      for i = 1, 9 do
        table.insert(maps, { "<leader>" .. i, i .. "gt", desc = "Go to Tab " .. i })
      end
      return maps
    end)()),
  },

  config = function(_, opts)
    require("bufferline").setup({
      options = {
        mode = "buffers",
        diagnostics = "nvim-lsp", -- Can also be "coc"
        separator_style = "straight", -- "slant", "padded_slant", "padded_slope", "slope", "wave"
        show_close_icon = false,
        show_buffer_close_icons = true,
        always_show_bufferline = true,
        indicator = {
          style = "icon",
          icon = "▎",
        },
        offsets = {
          {
            filetype = "NvimTree", -- Updated from NvimTree if you use neo-tree
            text = "File Explorer",
            highlight = "Directory",
            separator = true,
          },
          {
            filetype = "NvimTree", -- Kept for NvimTree if you still use it or switch
            text = "File Explorer",
            highlight = "Directory",
            separator = true,
          },
        },
        -- Add other options from opts if you prefer to pass them via lazy.nvim's opts table
      },
    })

    -- Custom Highlights (can be defined here or in your theme file)
    -- These might be overridden by your colorscheme if it has bufferline support.
    -- Consider defining them in the on_highlights callback of your theme if it supports it.
    vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { fg = "#ffffff", bg = "#3b4252", bold = true })
    vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected", { fg = "#89dceb", sp = "#89dceb", underline = false })
    vim.api.nvim_set_hl(0, "BufferLineBackground", { fg = "#888888", bg = "#1e1e2e" })
  end,
}
