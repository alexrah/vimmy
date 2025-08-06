-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here


local WinSeparatorFg = "#5A616B"

local function set_win_separator()
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = WinSeparatorFg })
end

-- set colors for split separators on colorscheme change
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = set_win_separator,
})

-- Set color on startup
set_win_separator()
