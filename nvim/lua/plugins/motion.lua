-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  {
    "https://codeberg.org/andyg/leap.nvim", -- motion anywhere in the buffer
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
  },
  {
    "chrisgrieser/nvim-spider", -- word motion with CamelCase, PascalCase, snake_case support
    lazy = true,
    opts = {
      skipInsignificantPunctuation = false,
    },
    keys = {
      { "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
      { "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
      { "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
      { "ge", "<cmd>lua require('spider').motion('ge')<CR>", mode = { "n", "o", "x" } },
    },
  },
}
