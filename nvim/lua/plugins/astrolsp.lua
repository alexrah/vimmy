-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = false, -- enable or disable format on save globally
      },
      timeout_ms = 2000, -- default format timeout
    },
    mappings = {
      n = {
        ["<leader>lb"] = { function() vim.lsp.buf.definition() end, desc = "Go to definition" },
        ["<Leader>lB"] = { function() vim.lsp.buf.declaration() end, desc = "Go to declaration" },
        ["grd"] = { function() vim.lsp.buf.definition() end, desc = "vim.lsp.buf.definition()" },
        ["grD"] = { function() vim.lsp.buf.declaration() end, desc = "vim.lsp.buf.declaration()" },
        ["gd"] = { function() vim.lsp.buf.definition() end, desc = "vim.lsp.buf.declaration()" },
        ["gb"] = { function() vim.lsp.buf.references() end, desc = "vim.lsp.buf.references()" },
        ["<C-b>"] = { function() require("snacks.picker").lsp_references({auto_confirm = false}) end, desc = "vim.lsp.buf.references()" },
        ["<C-d>"] = { function() require("snacks.picker").lsp_definitions({auto_confirm = false}) end, desc = "vim.lsp.buf.definition()" },
        ["<C-y>"] = { function () require("snacks.picker").lsp_type_definitions({auto_confirm = false}) end, desc = "vim.lsp.buf.type_definition()" }
      },
    },
  },
}
