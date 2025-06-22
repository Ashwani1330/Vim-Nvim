vim.g.mapleader = " "
vim.g.maplocalleader = " "

local g = vim.g
local o = vim.o
local fn = vim.fn

-- Performance Tweaks
o.ttyfast = true -- Should be set for modern terminals
o.lazyredraw = true -- Don't redraw while executing macros, etc.
vim.g.loaded_netrw = 1       -- Disable netrw
vim.g.loaded_netrwPlugin = 1 -- Disable netrw plugin

-- Better editing experience
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.errorbells = false
o.wrap = false
o.scrolloff = 8
o.clipboard = 'unnamedplus'
o.mouse = 'a'  -- enable mouse 
o.smartindent = true

-- Better editor UI
o.termguicolors = true
o.nu = true
o.relativenumber = true
o.guicursor = ""
o.cursorline = true
o.colorcolumn = '80'  -- To check if you are indenting the code a little too much and to re-thing and refactor thecode
o.signcolumn = 'yes'
o.encoding = 'utf-8'
o.laststatus = 3
g.WinSeparator_guibg = 'None'
o.breakindent = true
o.completeopt = 'menuone,noselect'

-- Better search experience
o.hlsearch = false
o.incsearch = true
o.ignorecase = true
o.smartcase = true

-- Undo and backup options
o.swapfile = false
o.backup = false
-- o.undodir = os.getenv("HOME") .. '/.nvim/undodir'
o.undofile = true
-- o.hidden = true -- It keeps any buffer we have been editing in the background. If we don't save it, we can navigate away from it without saving it. Its still open in the memomry. Allows fast swapping b/w files without worry.
o.exrc = true  -- enable automatic sourcing of custom vimrc that one needs in particualar projects

-- Ensure ShaDa path exists and set it
local shada_path = fn.stdpath("data") .. "/shada"
fn.mkdir(shada_path, "p")  -- 'p' creates parent dirs if needed
o.shadafile = shada_path .. "/main.shada"

-- Better buffer splitting
o.splitright = true
o.splitbelow = true

-- Better folds
o.foldmethod = 'indent'
o.foldlevel = 99

o.updatetime = 100

-- g.mapleader = " "

-- Autocommands for language-specific settings
local langSettingsGroup = vim.api.nvim_create_augroup("LanguageSpecificSettings", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = langSettingsGroup,
  pattern = "lua",
  callback = function(args)
    -- For Lua files, set indent to 2 spaces
    vim.bo[args.buf].shiftwidth = 2
    vim.bo[args.buf].tabstop = 2
    vim.bo[args.buf].softtabstop = 2
    -- expandtab is likely already true globally, but can be set buffer-locally if needed:
    -- vim.bo[args.buf].expandtab = true 
    -- vim.notify("Set Lua indent to 2 spaces for buffer " .. args.buf, vim.log.levels.INFO, {title = "Indent Settings"})
  end,
})
