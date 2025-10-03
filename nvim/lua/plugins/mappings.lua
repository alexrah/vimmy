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

          ["<Leader>gf"] = { ":DiffviewOpen<Enter>", desc = "Open a Diffview" },
          ["<Leader>gD"] = { ":DiffviewClose<Enter>", desc = "Close a Diffview" },

          ["<Leader>;t"] = { function() vim.cmd "Codeium Toggle" end, desc = "Enable/Disable Codeium" },
          ["<Leader>;v"] = { virtual_text_toggle, desc = virtual_text_label() },

          ["zO"] = { function () return require('fold-cycle').open_all() end, desc = "Open all folds" },
          ["zC"] = { function () return require('fold-cycle').close_all() end, desc = "Close all folds" },

          ["<C-Tab>"] = { function() require("snacks").picker.buffers() end, desc = "Find buffers" },

          -- remap default delete byndings to m (move) and change default delete to not override yank
          ["m"] = { 'd' },
          -- ["M"] = { 'D' },
          ["d"] = { '"_d' },
          ["mm"] = { 'dd' },
          ["c"] = { '"_c' },

          ["<Leader>uW"] = { ":ASToggle<CR>", desc = "Toggle AutoSave" },
        },
        v = {
          ["<C-c>"] = { '"+y<Esc>i', desc = "Copy using standard shortcut" },
          ["<C-x>"] = { '"+d<Esc>i', desc = "Cut using standard shortcut" },
          ["<S-Up>"] = { "<Up>" },
          ["<S-Down>"] = { "<Down>" },
          ["<S-Left>"] = { "<Left>" },
          ["<S-Right>"] = { "<Right>" },

          ["m"] = { 'd' },
          ["d"] = { '"_d' },
          ["c"] = { '"_c' },

        },
        i = {
          ["<C-v>"] = { "<Esc>pi", desc = "Paste using standard shortcut" },
          [",,"] = { virtual_text_toggle, desc = virtual_text_label() },
        },
      },
    },
  },
}
