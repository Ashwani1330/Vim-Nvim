require("bufferline").setup({
  options = {
    mode = "buffers",
    diagnostics = "nvim-lsp",
    separator_style = "straight",
    show_close_icon = false,
    show_buffer_close_icons = true,
    always_show_bufferline = true,
    indicator = {
      style = "icon",
      icon = "▎", -- thin vertical bar
    },
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        separator = true,
      },
    },
  }
})

-- Custom Highlights (Matches dark theme - auto loaded colors)
-- You can tweak colors if needed
vim.api.nvim_set_hl(0, "BufferLineBufferSelected", {
  fg = "#ffffff",    -- bright text
  bg = "#3b4252",    -- subtle dark background (can tweak per theme)
  bold = true,
})

vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected", {
  fg = "#89dceb",    -- cyan-ish (matching diagnostics or accent color)
  sp = "#89dceb",
  underline = false, -- fallback if underline doesn't render well
})

vim.api.nvim_set_hl(0, "BufferLineBackground", {
  fg = "#888888",    -- dim text for inactive tabs
  bg = "#1e1e2e",
})

-- Buffer Cycling with Tab
vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { silent = true, desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { silent = true, desc = "Previous buffer" })

-- Close Current Buffer
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { silent = true, desc = "Delete current buffer" })

-- Close All Other Buffers (keep current)
vim.keymap.set("n", "<leader>bo", ":%bd|e#|bd#<CR>", {
  silent = true,
  desc = "Close other buffers"

})

-- Close All Buffers
vim.keymap.set("n", "<leader>ba", ":%bd<CR>", {
  silent = true,
  desc = "Close all buffers"
})

-- Lua Function to Close Specific Buffer by Name
local function close_buffer_if_exists(name)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_name(buf):match(name) then
      vim.cmd("bdelete " .. buf)
      vim.notify("Closed buffer: " .. name, vim.log.levels.INFO)
      return
    end
  end
  vim.notify("No buffer matching: " .. name, vim.log.levels.WARN)
end

-- Close README.md if exists
vim.keymap.set("n", "<leader>br", function()
  close_buffer_if_exists("README.md")
end, { desc = "Close README.md buffer if open" })

-- Create a new tab
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "New Tab", silent = true })

-- Close current tab
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "Close Tab", silent = true })

-- Only keep current tab
vim.keymap.set("n", "<leader>to", ":tabonly<CR>", { desc = "Close Other Tabs", silent = true })

-- Go to next/prev tab
vim.keymap.set("n", "<leader>]", ":tabnext<CR>", { desc = "Next Tab", silent = true })
vim.keymap.set("n", "<leader>[", ":tabprevious<CR>", { desc = "Previous Tab", silent = true })

-- Go to tab 1-9
for i = 1, 9 do
  vim.keymap.set("n", "<leader>" .. i, i .. "gt", { desc = "Go to Tab " .. i, silent = true })
end