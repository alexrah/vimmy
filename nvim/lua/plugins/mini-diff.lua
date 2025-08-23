-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  "echasnovski/mini.diff",
  version = false,
  config = function()
    require("mini.diff").setup()
  end,
}
