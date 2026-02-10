-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

local function codeium_virtual_text_toggle()
  local virtual_text = require("codeium.config").options.virtual_text
  virtual_text.manual = not virtual_text.manual
end

local function codeium_virtual_text_label()
  -- local virtual_text_manual = require("codeium.config").options.virtual_text.manual and "Off" or "On"
  -- local status = virtual_text_manual and "Off" or "On"
  -- return "Toggle Codeium Virtual Text (,,) [" .. status .. "]"
  return "Toggle Codeium Virtual Text (,,)"
end

local function codeium_toggle() vim.cmd "Codeium Toggle" end

local function codeium_label() return "Enable/Disable Codeium" end

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
          ["<Leader>gx"] = { ":DiffviewClose<Enter>", desc = "Close a Diffview" },

          ["<Leader>;t"] = { codeium_toggle, desc = codeium_label() },
          ["<Leader>;v"] = { codeium_virtual_text_toggle, desc = codeium_virtual_text_label() },
          ["<Leader>;a"] = { "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanionActions <C-a>" },
          ["<C-a>"] = { "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanionActions" },
          ["<Leader>;;"] = { "<cmd>CodeCompanionChat Toggle<cr>", desc = "CodeCompanionChat Toggle <C-;>" },
          ["<C-;>"] = { "<cmd>CodeCompanionChat Toggle<cr>", desc = "CodeCompanionChat Toggle" },
          ["<Leader>;h"] = { "<cmd>CodeCompanionHistory<cr>", desc = "CodeCompanionHistory" },
          -- ["<C-'>"] = { function() require("codecompanion").toggle({ window_opts = { layout = "horizontal", width = 0.4, position = 'bottom'}}) end, desc = "CodeCompanionChat Toggle" },

          ["zO"] = { function() return require("fold-cycle").open_all() end, desc = "Open all folds" },
          ["zC"] = { function() return require("fold-cycle").close_all() end, desc = "Close all folds" },

          ["<C-Tab>"] = { function() require("snacks").picker.buffers() end, desc = "Find buffers" },

          -- remap default delete byndings to m (move) and change default delete to not override yank
          ["m"] = { "d" },
          -- ["M"] = { 'D' },
          ["d"] = { '"_d' },
          ["mm"] = { "dd" },
          ["c"] = { '"_c' },
          ["x"] = { '"_x' },

          ["<Leader>uW"] = { ":ASToggle<CR>", desc = "Toggle AutoSave" },

          ["<leader>i"] = {desc = " Python"} -- disable default Toggle Explorer Focus
        },
        v = {
          ["<C-c>"] = { '"+y<Esc>i', desc = "Copy using standard shortcut" },
          ["<C-x>"] = { '"+d<Esc>i', desc = "Cut using standard shortcut" },
          ["<S-Up>"] = { "<Up>" },
          ["<S-Down>"] = { "<Down>" },
          ["<S-Left>"] = { "<Left>" },
          ["<S-Right>"] = { "<Right>" },

          ["m"] = { "d" },
          ["d"] = { '"_d' },
          ["c"] = { '"_c' },
          ["x"] = { '"_x' },

          ["<C-a>"] = { "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanionActions" },
          ["<C-;>"] = { "<cmd>CodeCompanionChat Toggle<cr>", desc = "CodeCompanionChat Toggle" },
          ["<Leader>;a"] = { "<cmd>CodeCompanionChat Add<cr>", desc = "Add visually selected to chat <C-a><C-a>" },
          ["<C-a><C-a>"] = { "<cmd>CodeCompanionChat Add<cr>", desc = "Add visually selected to chat" },
        },
        i = {
          ["<C-v>"] = { "<Esc>pi", desc = "Paste using standard shortcut" },
          [",,"] = { codeium_virtual_text_toggle, desc = codeium_virtual_text_label() },
          [",."] = { codeium_toggle, desc = codeium_label() },

          ["<C-a>"] = { "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanionActions" },
          ["<C-;>"] = { "<cmd>CodeCompanionChat Toggle<cr>", desc = "CodeCompanionChat Toggle" },
        },
      },
    },
  },
}
