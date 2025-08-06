-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here


local WinSeparatorFg = "#5A616B"

-- set colors for split separators
vim.api.nvim_set_hl(0, 'WinSeparator', { fg =  WinSeparatorFg })
