-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
--
---@type LazySpec
return {
  "okuuva/auto-save.nvim",
  opts = {
    enabled = not require("utils").is_linux(), -- don't autosave on linux
  },
  config = function(_, opts)
    local autosave = require("auto-save")
    autosave.setup(opts)

    require("snacks.toggle").new({
      name = "Auto Save",
      get = function()
         return autosave.enabled()
      end,
      set = function(state)
          if state then
              autosave.on()
          else
              autosave.off()
          end
      end,
    }):map("<leader>uX")
  end
}
