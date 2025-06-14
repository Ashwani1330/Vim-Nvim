vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n","<leader>nw", ":vs<cr>:Ex<cr>")
vim.keymap.set("n","<leader>px", ":Telescope<cr>")
-- vim.keymap.set("n","<leader>nn", ":Ex<cr>")

-- move selected text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- smart cursor positioning
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- split navigations
vim.keymap.set("n","<C-J>", "<C-W><C-J>")
vim.keymap.set("n","<C-K>", "<C-W><C-K>")
vim.keymap.set("n","<C-L>", "<C-W><C-L>")
vim.keymap.set("n","<C-H>", "<C-W><C-H>")

-- vim.keymap.set("i","kj", "<esc>")
-- vim.keymap.set("v","kj", "<esc>")

-- paste over something without losing the yanked buffer
vim.keymap.set("x", "<leader>p", "\"_dp")

-- next greatest remap ever : asbjornHaland
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

--[[  vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz") ]]--

-- Run python commands remaps
vim.keymap.set("n","<F5>", "<Esc>:w <CR>:vs<CR>:term python3 %<CR>")
vim.keymap.set("n","<F9>", "<Esc>:w <CR>:sp<CR>:term python3 %<CR>")

-- NvimTreeToggle
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<F6>", ":NvimTreeToggle<CR>", opts)
-- <F7> to toggle NvimTree and reveal the current file
-- vim.keymap.set("n", "<F7>", ":NvimTreeFindFileToggle<CR>", opts)

-- Run C/C++ commands remaps
vim.keymap.set("n","<F8>", "<Esc>:w <CR>:vs<CR>:term g++ -std=c++20 % -Wall -g -o %.out && ./%.out <CR>")
vim.keymap.set("n","<F10>", "<Esc>:w <CR>:sp<CR>:term g++ -std=c++20 % -Wall -g -o %.out && ./%.out <CR>")

--[[ Run Kotlin commands remaps
vim.keymap.set("n","<F3>", "<Esc>:w <CR>:sp<CR>:term kotlinc % -d %<.jar<CR>")
vim.keymap.set("n","<F6>", "<Esc>:w <CR>:sp<CR>:term java -jar %<.jar<CR>")
]]--

vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>") -- renames
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true }) -- makes executables


vim.keymap.set("x", "<leader>a", "<Plug>(coc-codeaction-selected)")
vim.keymap.set("n", "<leader>a", "<Plug>(coc-codeaction-selected)")

