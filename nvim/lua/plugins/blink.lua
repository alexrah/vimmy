-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  "saghen/blink.cmp",
  dependencies = {
    {
      "Exafunction/codeium.nvim",
    },
  },
  opts = function(plugin, opts)
    -- kubectl.nvim integration
    if vim.bo.filetype:match "^k8s_" then
      vim.notify('filetype'..vim.bo.filetype, 2)
      -- Return true if filetype starts with "k8s_"
      opts.enabled = function() return true end

      -- set icons for blink.cmp results
      opts.completion.menu.draw.components.kind_icon.text = function(ctx)
        if ctx.kind == "Namespace" then return "󰘧" end
        if ctx.kind == "History" then return "󰋚" end
        if ctx.kind == "Context" then return "" end
        if ctx.kind == "View" then return "" end
        return "󱃾"
      end
    end

    -- Codeium integration
    table.insert(opts.sources.default, "codeium")
    opts.sources.providers.codeium = { name = "Codeium", module = "codeium.blink", async = true }
  end,
}
