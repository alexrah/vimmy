-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  'saghen/blink.cmp',
  dependencies = {
    {
      'Exafunction/codeium.nvim',
    },
  },
  opts = {
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer', 'codeium' },
      providers = {
        codeium = { name = 'Codeium', module = 'codeium.blink', async = true },
      },
    },
  },
}
