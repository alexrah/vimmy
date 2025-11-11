-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  "gbprod/yanky.nvim",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    ring = {
      history_length = 20,
    },
    highlight = {
      on_put = false,
      on_yank = false,
      timer = 200,
    },
  },
}
