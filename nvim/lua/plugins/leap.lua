-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  "https://codeberg.org/andyg/leap.nvim",
  dependencies = {
    "tpope/vim-repeat",
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["s"] = { "<Plug>(leap)", desc = "Leap" },
          },
          x = {
            ["s"] = { "<Plug>(leap)", desc = "Leap" },
          },
          o = {
            ["s"] = { "<Plug>(leap)", desc = "Leap" },
          },
        },
      },
    },
  },
  specs = {
    {
      "catppuccin",
      optional = true,
      ---@type CatppuccinOptions
      opts = { integrations = { leap = true } },
    },
  },
  opts = {},
}
