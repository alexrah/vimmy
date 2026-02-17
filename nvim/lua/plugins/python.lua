-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE


-- change the configuration when editing a python file
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.py",
  callback = function(e)
    if string.match(e.file, ".otter.") then
      return
    end
    if require("molten.status").initialized() == "Molten" then -- this is kinda a hack...
      vim.fn.MoltenUpdateOption("virt_lines_off_by_1", false)
      vim.fn.MoltenUpdateOption("virt_text_output", false)
    else
      vim.g.molten_virt_lines_off_by_1 = false
      vim.g.molten_virt_text_output = false
    end
  end,
})

-- Undo those config changes when we go back to a markdown or quarto file
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.qmd", "*.md", "*.ipynb" },
  callback = function(e)
    if string.match(e.file, ".otter.") then
      return
    end
    if require("molten.status").initialized() == "Molten" then
      vim.fn.MoltenUpdateOption("virt_lines_off_by_1", true)
      vim.fn.MoltenUpdateOption("virt_text_output", true)
    else
      vim.g.molten_virt_lines_off_by_1 = true
      vim.g.molten_virt_text_output = true
    end
  end,
})

return {
  {
    "benlubas/molten-nvim", -- Jupyter based code execution
    ft = { "python", "quarto" },
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      -- these are examples, not defaults. Please see the readme
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      -- vim.g.molten_virt_text_output = true
    end,
    specs = {
      {
        -- see the image.nvim readme for more information about configuring this plugin
        "3rd/image.nvim",
        optional = true,
        opts = {
          max_width = 100,
          max_height = 12,
          max_height_window_percentage = math.huge,
          max_width_window_percentage = math.huge,
          window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
          window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        },
      },
    },
    keys = {
      {"<leader>iv", '<cmd>MoltenEvaluateVisual<cr>' , ft = {"python" }, mode = "v",  desc = "Molten Evaluate Visual"},
      {"<leader>ir", '<cmd>MoltenReevaluateCell<cr>' , ft = {"python" }, desc = "Molten ReEvaluate"},
      {"<leader>id", '<cmd>MoltenDelete<cr>' , ft = {"python" }, desc = "Molten Delete"},
    }
  },
  {
    "quarto-dev/quarto-nvim", -- Quarto Markdown support
    ft = { "quarto", "markdown" },
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      lspFeatures = {
        -- NOTE: put whatever languages you want here:
        languages = { "r", "python", "rust" },
        chunks = "all",
        diagnostics = {
          enabled = true,
          triggers = { "BufWritePost" },
        },
        completion = {
          enabled = true,
        },
      },
      codeRunner = {
        enabled = true,
        default_method = "molten", -- "molten", "slime", "iron" or <function>
        ft_runners = {}, -- filetype to runner, ie. `{ python = "molten" }`.
        -- Takes precedence over `default_method`
        never_run = { "yaml" }, -- filetypes which are never sent to a code runner
      },
    },
    keys = {
      {"<leader>ip", '<cmd>QuartoPreview<cr>' , ft = {"quarto" },  desc = "Quarto Preview"},
      {"<leader>ic", '<cmd>QuartoSend<cr>' , ft = {"quarto" },  desc = "Quarto Run Cell"},
      {"<leader>ia", '<cmd>QuartoSendAll<cr>' , ft = {"quarto" },  desc = "Quarto Run All"},
    }
  },
}
