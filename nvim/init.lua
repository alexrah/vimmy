-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  local result = vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
  if vim.v.shell_error ~= 0 then
    -- stylua: ignore
    vim.api.nvim_echo({ { ("Error cloning lazy.nvim:\n%s\n"):format(result), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
    vim.fn.getchar()
    vim.cmd.quit()
  end
end

vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

-- disable default keymaps
vim.keymap.set("n", "<C-y>", "<nop>")

-- vim.o.guifont = "0xProto Nerd Font Mono:h15"
vim.o.guifont = "JetBrainsMono Nerd Font:h13"

-- NeoVide
-- alt key on macos
vim.g.neovide_input_macos_option_key_is_meta = 'both'
-- auto theme switch
vim.g.neovide_theme = 'auto'

local python3_venv_path = '~/.virtualenvs/neovim-python3'

-- Check if Python virtual environment folder exists and set python3_host_prog
if vim.fn.isdirectory(vim.fn.expand(python3_venv_path)) == 1 then
  vim.g.python3_host_prog = vim.fn.expand(python3_venv_path .. '/bin/python')
end

require "lazy_setup"
require "polish"

