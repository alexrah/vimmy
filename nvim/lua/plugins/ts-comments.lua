if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  "folke/ts-comments.nvim",
  opts = {
    lang = {
      javascript = {
        "/* %s */",
        "// %s", -- default commentstring when no treesitter node matches
        call_expression = "// %s", -- specific commentstring for call_expression
        jsx_attribute = "// %s",
        jsx_element = "{/* %s */}",
        jsx_fragment = "{/* %s */}",
        spread_element = "// %s",
        statement_block = "// %s",
      },
      typescript = { "/* %s */", "// %s" }, -- langs can have multiple commentstrings
    },
  },
  event = "VeryLazy",
  -- enabled = vim.fn.has "nvim-0.10.0" == 1,
}
