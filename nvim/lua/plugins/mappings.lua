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
        },
        v = {
          ["<C-c>"] = { '"+y<Esc>i', desc = "Copy using standard shortcut" },
          ["<C-x>"] = { '"+d<Esc>i', desc = "Cut using standard shortcut" },
        },
        i = {
          ["<C-v>"] = { "<Esc>pi", desc = "Paste using standard shortcut" },
        },
      },
    },
  },
}
