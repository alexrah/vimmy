-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  "saghen/blink.cmp",
  dependencies = {
    {
      "Exafunction/codeium.nvim",
    },
  },
  opts = function(plugin, opts)
    -- Store original enabled function if it exists
    local original_enabled = opts.enabled

    -- kubectl.nvim integration
    -- Create a new enabled function that checks filetype dynamically
    opts.enabled = function()
      -- First check if we're in a k8s filetype
      if vim.bo.filetype:match "^k8s_" then return true end

      -- If not k8s, use original enabled function if it exists
      if original_enabled then return original_enabled() end

      -- Default to true if no original function
      return true
    end

    -- Custom icons
    local original_kind_icon = opts.completion.menu.draw.components.kind_icon.text
    opts.completion.menu.draw.components.kind_icon.text = function(ctx)
      if vim.bo.filetype:match "^k8s_" then
        if ctx.kind == "Namespace" then return "󰘧" end
        if ctx.kind == "History" then return "󰋚" end
        if ctx.kind == "Context" then return "" end
        if ctx.kind == "View" then return "" end
        return "󱃾"
      end
      if original_kind_icon then return original_kind_icon(ctx) end
      return ""
    end

    -- Codeium integration
    table.insert(opts.sources.default, "codeium")
    opts.sources.providers.codeium = {
      name = "Codeium",
      module = "codeium.blink",
      async = true,
      enabled = function()
        -- Disable Codeium when buffer type is "prompt"
        return vim.bo.buftype ~= "prompt"
      end,
    }
  end,
}
