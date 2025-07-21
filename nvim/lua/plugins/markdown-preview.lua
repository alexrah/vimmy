-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- INFO: needs to manually run :Lazy build markdown-preview.nvim to actually build it

return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  build = function(plugin) vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install") end,
  init = function()
    if vim.fn.executable "npx" then vim.g.mkdp_filetypes = { "markdown" } end
  end,
}
