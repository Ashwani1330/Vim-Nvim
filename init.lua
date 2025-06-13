require("akm.set")
require("akm.remap")
require("akm.packer")
require("akm.neovide")

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