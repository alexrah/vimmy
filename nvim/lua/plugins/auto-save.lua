-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

local is_linux = require("utils").is_linux()

---@type LazySpec[]
return {
  "okuuva/auto-save.nvim",
  event = "VeryLazy",
  opts = {
    enabled = not is_linux,
  },
  config = is_linux and function(_, opts)
    local autosave = require "auto-save"
    autosave.setup(opts)

    require("snacks.toggle")
      .new({
        name = "Auto Save",
        get = function() return autosave.enabled() end,
        set = function(state)
          if state then
            autosave.on()
          else
            autosave.off()
          end
        end,
      })
      :map "<leader>uW"
  end or nil,
  keys = not is_linux and {
    { "<leader>uW", "<cmd>ASToggle<CR>", desc = "Toggle auto-save" },
  } or nil,
}
