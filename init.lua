-- init.lua

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath) -- Now lazypath is defined and this line should work

-- Load your core settings and remaps BEFORE lazy setup
require("akm.set")
require("akm.remap") -- General remaps

-- Setup lazy.nvim to load plugin specs from the "lua/plugins" directory
require("lazy").setup("plugins", {
  -- Optional lazy.nvim configuration options here
  checker = {
    enabled = true, -- Automatically check for plugin updates
    notify = false,
  },
  change_detection = {
    enabled = true,
    notify = false, -- Automatically check for config file changes and reload the ui
  },
  -- ui = { border = "rounded" }, -- Example: customize lazy.nvim UI
})

-- Windows-specific custom diff tool
if vim.fn.has('win32') == 1 then
    -- Set the path to your diff executable from Git for Windows
    vim.g.diffexec = 'C:\\Program Files\\Git\\usr\\bin\\diff.exe'

    -- Set the diff expression to use this custom function
    vim.opt.diffexpr = 'MyDiff()'

    -- Define the actual function to perform the diff
    function MyDiff()
        local fname_in  = vim.v.fname_in
        local fname_new = vim.v.fname_new
        local fname_out = vim.v.fname_out

        -- Use proper escaping and diff command
        local cmd = string.format(
            '"%s" -a --binary %s %s > %s',
            vim.g.diffexec,
            vim.fn.shellescape(fname_in),
            vim.fn.shellescape(fname_new),
            vim.fn.shellescape(fname_out)
        )

        -- Execute the command
        vim.fn.system(cmd)
    end
end
