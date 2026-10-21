-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
--
---@type LazySpec
return {
  "pocco81/auto-save.nvim",
  opts = {
    enabled = not require("utils").is_linux(), -- don't autosave on linux
  },
}
