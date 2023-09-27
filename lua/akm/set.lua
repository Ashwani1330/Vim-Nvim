local g = vim.g
local o = vim.o


-- Better editing experience
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.errorbells = false
o.wrap = false
o.scrolloff = 8
o.clipboard = 'unnamedplus'
o.mouse = 'a'  -- enable mouse o.smartindent = true

-- Better editor UI
o.termguicolors = true
o.nu = true
o.relativenumber = true
o.guicursor= ""
o.cursorline = true
o.colorcolumn = '80'  -- To check if you are indenting the code a little too much and to re-thing and refactor thecode
o.signcolumn = 'yes'
o.encoding = 'utf-8'
o.laststatus = 3
g.WinSeparator_guibg = 'None'

-- Better search experience
o.hlsearch = false
o.incsearch = true

-- Undo and backup options
o.swapfile = false
o.backup = false
o.undodir = os.getenv("HOME") .. '/.nvim/undodir'
o.undofile = true
o.hidden = true -- It keeps any buffer we have been editing in the background. If we don't save it, we can navigate away from it without saving it. Its still open in the memomry. Allows fast swapping b/w files without worry.
o.exrc = true  -- enable automatic sourcing of custom vimrc that one needs in particualar projects

-- Better buffer splitting
o.splitright = true
o.splitbelow = true

-- Better folds
o.foldmethod = 'indent'
o.foldlevel = 99

o.updatetime = 50

g.mapleader = " "
