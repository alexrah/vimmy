-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

local adapterACP = "claude_code"
local adapterHTTP = { name = "deepseek", model = "deepseek-chat" }

return {
  "olimorris/codecompanion.nvim",
  version = "^18.0.0",
  opts = {
    interactions = {
      chat = {
        adapter = adapterACP,
      },
      inline = {
        adapter = adapterHTTP,
        keymaps = {
          accept_change = {
            modes = { n = "gda" }, -- Remember this as DiffAccept
          },
          reject_change = {
            modes = { n = "gdr" }, -- Remember this as DiffReject
          },
          always_accept = {
            modes = { n = "gdy" }, -- Remember this as DiffYolo
          },
        },
      },
      cmd = {
        adapter = adapterHTTP,
      },
    },
    display = {
      chat = {
        window = {
          position = "bottom",
          layout = "horizontal",
        },
      },
    },
  },
  dependencies = {
    { "nvim-lua/plenary.nvim", branch = "master" },
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/codecompanion-history.nvim",
  },
}
