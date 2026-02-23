-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

local is_kitty = vim.env.TERM == "xterm-kitty"

return {
  "3rd/image.nvim",
  enabled = is_kitty,
  version = "1.4.0",
  build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
  opts = {
    processor = "magick_cli",
    backend = "kitty", -- whatever backend you would like to use
  },
}
