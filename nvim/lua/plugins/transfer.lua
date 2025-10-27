-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- NOTE: useful commands for diffing files:
-- 1. do - Get changes from other window into the current window
-- 2. dp - Put the changes from current window into the other window.
-- 3. ]c - Jump to the next change.
-- 4. [c - Jump to the previous change.

require("which-key").add {
  { "<Leader>y", group = "Upload / Download", icon = "" },
  {
    "<Leader>yd",
    "<cmd>TransferDownload<cr>",
    desc = "Download from remote server (scp)",
    icon = { color = "green", icon = "󰇚" },
  },
  {
    "<Leader>yf",
    "<cmd>DiffRemote<cr>",
    desc = "Diff file with remote server (scp)",
    icon = { color = "green", icon = "" },
  },
  {
    "<Leader>yi",
    "<cmd>TransferInit<cr>",
    desc = "Init/Edit Deployment config",
    icon = { color = "green", icon = "" },
  },
  {
    "<Leader>yr",
    "<cmd>TransferRepeat<cr>",
    desc = "Repeat transfer command",
    icon = { color = "green", icon = "󰑖" },
  },
  {
    "<Leader>yu",
    "<cmd>TransferUpload<cr>",
    desc = "Upload to remote server (scp)",
    icon = { color = "green", icon = "󰕒" },
  },
}

return {
  "coffebar/transfer.nvim",
  lazy = true,
  dev = false,
  cmd = { "TransferInit", "DiffRemote", "TransferUpload", "TransferDownload", "TransferDirDiff", "TransferRepeat" },
  opts = {
    close_diffview_mapping = "<Leader>yc",
    config_template = [[
return {
  ["server1"] = {
    host = "server1",
    username = "user",
    mappings = {
      {
        ["local"] = "domains/example.com",
        ["remote"] = "/var/www/example.com",
      },
    },
    -- excludedPaths = {
    --   "src", -- local path relative to project root
    -- },
    -- upload_on_save = false
  },
}
]],
  },
}
