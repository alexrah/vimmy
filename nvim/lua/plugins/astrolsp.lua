-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  dependencies = {
    "diogo464/kubernetes.nvim",
  },
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
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {
      -- clangd = { capabilities = { offsetEncoding = "utf-8" } },
      tailwindcss = {
        settings = {
          tailwindCSS = {
            classAttributes = { "class", "className", "ngClass", "class:list", "containerClassName" },
            classFunctions = { "cn", "clsx", "twMerge" },
          },
        },
      },
      html = {
        filetypes = { "html", "php" },
      },
      emmet_ls = {
        filetypes = {
          "css",
          "html",
          "javascriptreact",
          "scss",
          "typescriptreact",
          "php",
        },
      },
      cssls = {
        filetypes = { "css", "scss", "less", "html" },
      },
      vtsls = {
        settings = {
          vtsls = {
            autoUseWorkspaceTsdk = true,
          },
        },
      },
      intelephense = {
        settings = {
          intelephense = {
            diagnostics = {
              undefinedMethods = true,
              undefinedProperties = true,
            },
          },
        },
      },
      yamlls = {
        filetypes = {
          "yaml",
          "yml",
          "helm",
          "kustomization",
        },
        settings = {
          yaml = {
            schemas = {
              -- use this if you want to match all '*.yaml' files
              [vim.fs.joinpath(vim.fn.stdpath "data", "/kubernetes.nvim/schema.json") ] = "*.yaml",
              -- or this to only match '*.<resource>.yaml' files. ex: 'app.deployment.yaml', 'app.argocd.yaml', ...
              -- [require("kubernetes").yamlls_schema()] = require("kubernetes").yamlls_filetypes(),
            },
          },
        },
      },
    },
    mappings = {
      n = {
        ["<leader>lb"] = { function() vim.lsp.buf.definition() end, desc = "Go to definition" },
        ["<Leader>lB"] = { function() vim.lsp.buf.declaration() end, desc = "Go to declaration" },
        ["grd"] = { function() vim.lsp.buf.definition() end, desc = "vim.lsp.buf.definition()" },
        ["grD"] = { function() vim.lsp.buf.declaration() end, desc = "vim.lsp.buf.declaration()" },
        ["gd"] = { function() vim.lsp.buf.definition() end, desc = "vim.lsp.buf.declaration()" },
        ["gb"] = { function() vim.lsp.buf.references() end, desc = "vim.lsp.buf.references()" },
        ["<C-b>"] = {
          function() require("snacks.picker").lsp_references { auto_confirm = false } end,
          desc = "vim.lsp.buf.references()",
        },
        ["<C-s>"] = {
          function() require("snacks.picker").lsp_definitions { auto_confirm = false } end,
          desc = "vim.lsp.buf.definition()",
        },
        ["<C-y>"] = {
          function() require("snacks.picker").lsp_type_definitions { auto_confirm = false } end,
          desc = "vim.lsp.buf.type_definition()",
        },
        ["<Leader>fy"] = {
          function() require("snacks.picker").lsp_workspace_symbols() end,
          desc = "Workspace Symbols",
        },
      },
    },
  },
}
