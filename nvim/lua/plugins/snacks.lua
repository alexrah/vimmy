-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    picker = {
      -- n.your picker configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      win = {
        input = {
          keys = {
            ["<S-Down>"] = { "history_forward", mode = { "i", "n" } },
            ["<S-Up>"] = { "history_back", mode = { "i", "n" } },
          },
        },
      },
    },
  },
}
