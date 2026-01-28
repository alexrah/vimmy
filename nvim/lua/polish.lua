-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- INFO: add a border to clearly see the split separators
local WinSeparatorFg = "#5A616B"

local function set_win_separator() vim.api.nvim_set_hl(0, "WinSeparator", { fg = WinSeparatorFg }) end

-- set colors for split separators on colorscheme change
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = set_win_separator,
})

-- Set color on startup
set_win_separator()

-- INFO: set 4 spaces indent for php as per PHP Coding Standards
--
-- https://github.com/neovim/neovim/issues/22768#issuecomment-1482750463
local function set_ft_option(ft, option, value)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = ft,
    group = vim.api.nvim_create_augroup("FtOptions", {}),
    desc = ('set option "%s" to "%s" for this filetype'):format(option, value),
    callback = function() vim.opt_local[option] = value end,
  })
end

set_ft_option({ "php" }, "shiftwidth", 4)
set_ft_option({ "php" }, "tabstop", 4)

local function llm_ui_config()
  local llm_apply_dynamic_config = require("llm_ui").code_companion_apply_dynamic_config

  -- Set up autocommand to trigger on window resize
  vim.api.nvim_create_autocmd("VimResized", {
    group = vim.api.nvim_create_augroup("DynamicConfig", { clear = true }),
    callback = llm_apply_dynamic_config,
  })

  -- Also trigger on startup
  vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("DynamicConfigStartup", { clear = true }),
    callback = llm_apply_dynamic_config,
  })

  -- Optional: Also trigger when switching windows if needed
  vim.api.nvim_create_autocmd("WinEnter", {
    group = vim.api.nvim_create_augroup("DynamicConfigWinEnter", { clear = true }),
    callback = llm_apply_dynamic_config,
  })

  -- Apply configuration immediately on load
  llm_apply_dynamic_config()
end

llm_ui_config()
