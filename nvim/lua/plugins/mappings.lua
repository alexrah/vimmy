local function virtual_text_toggle()
  local virtual_text = require("codeium.config").options.virtual_text
  virtual_text.manual = not virtual_text.manual
end

local function virtual_text_label()
  -- local virtual_text_manual = require("codeium.config").options.virtual_text.manual and "Off" or "On"
  -- local status = virtual_text_manual and "Off" or "On"
  -- return "Toggle Codeium Virtual Text (,,) [" .. status .. "]"
  return "Toggle Codeium Virtual Text (,,)"
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
          ["<S-Up>"] = { "v<Up>" },
          ["<S-Down>"] = { "v<Down>" },
          ["<S-Left>"] = { "v<Left>" },
          ["<S-Right>"] = { "v<Right>" },
          ["<Leader>bm"] = { ":Maximize<Enter>", desc = "Toggle maximizing the current window" },
          ["<Leader>fB"] = { function() require("snacks").picker.grep_buffers() end, desc = "Grep Open Buffers" },
          ["<Leader>gd"] = { ":DiffviewOpen<Enter>", desc = "Open a Diffview" },
          ["<Leader>gD"] = { ":DiffviewClose<Enter>", desc = "Close a Diffview" },
          ["<Leader>;e"] = { function() vim.cmd "Codeium Toggle" end, desc = "Enable/Disable Codeium" },
          ["<Leader>;v"] = { virtual_text_toggle, desc = virtual_text_label() },
        },
        v = {
          ["<C-c>"] = { '"+y<Esc>i', desc = "Copy using standard shortcut" },
          ["<C-x>"] = { '"+d<Esc>i', desc = "Cut using standard shortcut" },
          ["<S-Up>"] = { "<Up>" },
          ["<S-Down>"] = { "<Down>" },
          ["<S-Left>"] = { "<Left>" },
          ["<S-Right>"] = { "<Right>" },
        },
        i = {
          ["<C-v>"] = { "<Esc>pi", desc = "Paste using standard shortcut" },
          [",,"] = { virtual_text_toggle, desc = virtual_text_label() },
        },
      },
    },
  },
}
