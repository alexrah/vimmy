local function toggle_virtual_text()
  local virtual_text = require("codeium.config").options.virtual_text
  virtual_text.manual = not virtual_text.manual
end

return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["s"] = { "<Plug>(leap)", desc = "Leap" },
          [";"] = { ":" },
          ["<C-v>"] = { "pi", desc = "Paste using standard shortcut" },
          ["<Leader>bm"] = { ":Maximize<Enter>", desc = "Toggle maximizing the current window" },
          ["<Leader>fB"] = { function() require("snacks").picker.grep_buffers() end, desc = "Grep Open Buffers" },
          ["<Leader>gd"] = { ":DiffviewOpen<Enter>", desc = "Open a Diffview" },
          ["<Leader>gD"] = { ":DiffviewClose<Enter>", desc = "Close a Diffview" },
          ["<Leader>;e"] = { function() vim.cmd "Codeium Toggle" end, desc = "Enable/Disable Codeium" },
          ["<Leader>;v"] = { toggle_virtual_text, desc = "Toggle Codeium Virtual Text" },
        },
        v = {
          ["<C-c>"] = { '"+y<Esc>i', desc = "Copy using standard shortcut" },
          ["<C-x>"] = { '"+d<Esc>i', desc = "Cut using standard shortcut" },
        },
        i = {
          ["<C-v>"] = { "<Esc>pi", desc = "Paste using standard shortcut" },
          [",,"] = { toggle_virtual_text, desc = "Toggle Codeium Virtual Text",
          },
        },
      },
    },
  },
}
