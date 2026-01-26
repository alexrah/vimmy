-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.git.diffview-nvim" },
  { import = "astrocommunity.completion.codeium-nvim" },
  { import = "astrocommunity.search.grug-far-nvim" },
  { import = "astrocommunity.recipes.heirline-mode-text-statusline"},
  { import = "astrocommunity.pack.tailwindcss"},
  { import = "astrocommunity.pack.python"}
  -- import/override with your plugins folder
}
