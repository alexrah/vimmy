if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- INFO: {style} configuration is defined in llm_ui.lua and loaded in polish.lua to
-- dynamically select UI based on window size:
-- right panel on larger windows & bottom panel on smaller ones 

---@class vim.env
---@field OPENROUTER_API_KEY string|nil
---@field GEMINI_API_KEY string|nil
---@field MISTRAL_API_KEY string|nil
---@field DEEPSEEK_API_KEY string|nil
local env = vim.env

return {
  "Kurama622/llm.nvim",
  dev = false,
  dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", "echasnovski/mini.diff" },
  cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
  config = function()
    local tools = require "llm.tools"
    require("llm").setup {

      models = {
        {
          name = "DeepSeek v3.2",
          url = "https://api.deepseek.com/chat/completions",
          model = "deepseek-chat",
          fetch_key = function() return env.DEEPSEEK_API_KEY end,
          api_type = "openai",
          max_tokens = 4066,
          temperature = 0.3,
          top_p = 0.7,
        },
        -- {
        --   name = "Devstral 2",
        --   url = "https://openrouter.ai/api/v1/chat/completions",
        --   model = "mistralai/devstral-2512:free",
        --   fetch_key = function() return env.OPENROUTER_API_KEY end,
        --   api_type = "openai",
        --   max_tokens = 8192,
        --   temperature = 0.3,
        --   top_p = 0.7,
        -- },
        -- {
        --   name = "GEMINI-2.5-pro",
        --   url = "https://gmenerativelanguage.googleapis.com/v1beta/openai/chat/completions",
        --   model = "gemini-2.5-pro",
        --   fetch_key = function() return env.GEMINI_API_KEY end,
        --   api_type = "openai",
        --   max_tokens = 8192,
        --   temperature = 0.3,
        --   top_p = 0.7,
        -- },
        -- {
        --   url = "https://codestral.mistral.ai/v1/chat/completions",
        --   model = "codestral-2405",
        --   fetch_key = function() return env.MISTRAL_API_KEY end,
        --   api_type = "openai",
        --   max_tokens = 8192,
        --   temperature = 0.3,
        --   top_p = 0.7,
        --
        -- },
      },
      prompt = "You are a helpful programming assistant.",

      spinner = {
        text = {
          "󰧞󰧞",
          "󰧞󰧞",
          "󰧞󰧞",
          "󰧞󰧞",
        },
        hl = "Title",
      },

      prefix = {
        user = { text = "😃 ", hl = "Title" },
        assistant = { text = "  ", hl = "Added" },
      },

      history_path = "/tmp/llm-history",
      save_session = true,
      max_history = 15,
      max_history_name_length = 20,

      keys = {
        -- The keyboard mapping for the input window.
        ["Input:Submit"] = { mode = "n", key = "<cr>" },
        ["Input:Cancel"] = { mode = { "n", "i" }, key = "<C-c>" },
        ["Input:Resend"] = { mode = { "n", "i" }, key = "<C-r>" },

        -- only works when "save_session = true"
        ["Input:HistoryNext"] = { mode = { "n", "i" }, key = "<C-j>" },
        ["Input:HistoryPrev"] = { mode = { "n", "i" }, key = "<C-k>" },

        -- The keyboard mapping for the output window in "split" style.
        ["Output:Ask"] = { mode = "n", key = "i" },
        ["Output:Cancel"] = { mode = "n", key = "<C-c>" },
        ["Output:Resend"] = { mode = "n", key = "<C-r>" },

        -- The keyboard mapping for the output and input windows in "float" style.
        ["Session:Toggle"] = { mode = "n", key = "<leader>;c" },
        ["Session:Close"] = { mode = "n", key = { "<esc>", "Q" } },

        -- float style
        ["Input:ModelsNext"] = { mode = { "n", "i" }, key = "<C-S-J>" },
        ["Input:ModelsPrev"] = { mode = { "n", "i" }, key = "<C-S-K>" },

        -- Applicable to AI tools with split style and UI interfaces
        ["Session:Models"] = { mode = "n", key = { "<C-m>" } },
        ["Session:History"] = { mode = "n", key = { "<C-y>", "<leader>;y>" } },
      },
      -- display diff [require by action_handler]
      display = {
        diff = {
          layout = "vertical", -- vertical|horizontal split for default provider
          opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
          provider = "mini_diff", -- default|mini_diff
          disable_diagnostic = true, -- Whether to show diagnostic information when displaying diff
        },
      },
      chat_ui_opts = {
        input = {
          split = {
            relative = "win",
            position = {
              row = "80%",
              col = "50%",
            },
            border = {
              text = {
                top = "  Enter Your Question ",
                top_align = "center",
              },
            },
            win_options = {
              winblend = 0,
              winhighlight = "Normal:String,FloatBorder:LlmYellowLight,FloatTitle:LlmYellowNormal",
            },
            size = { height = 2, width = "80%" },
          },
        },
        output = {
          split = {
            size = "40%",
          },
        },
        history = {
          split = {
            -- Default: true.
            -- If the window flickers when the cursor moves on macOS, you can set enable_fzf_focus_print = false.
            enable_fzf_focus_print = false,
            size = "60%",
          },
        },
        models = {
          split = {
            relative = "win",
            size = { height = "30%", width = "60%" },
          },
        },
      },
      -- popup window options
      popwin_opts = {
        relative = "cursor",
        enter = true,
        focusable = true,
        zindex = 50,
        position = { row = -7, col = 15 },
        size = { height = 15, width = "50%" },
        border = { style = "single", text = { top = " Explain ", top_align = "center" } },
        win_options = {
          winblend = 0,
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
        },

        -- move popwin
        move = {
          left = {
            mode = "n",
            keys = "<left>",
            distance = 5,
          },
          right = {
            mode = "n",
            keys = "<right>",
            distance = 5,
          },
          up = {
            mode = "n",
            keys = "<up>",
            distance = 2,
          },
          down = {
            mode = "n",
            keys = "<down>",
            distance = 2,
          },
        },
      },
      app_handler = {
        Ask = {
          handler = tools.disposable_ask_handler,
          opts = {
            position = {
              row = 2,
              col = 0,
            },
            title = " Ask ",
            inline_assistant = true,

            -- Whether to use the current buffer as context without selecting any text (the tool is called in normal mode)
            enable_buffer_context = true,
            language = "English",

            -- [optinal] set your llm model
            -- url = "https://api.chatanywhere.tech/v1/chat/completions",
            -- model = "gpt-4o-mini",
            -- api_type = "openai",
            -- fetch_key = function() return env.CHAT_ANYWHERE_KEY end,

            -- display diff
            display = {
              mapping = {
                mode = "n",
                keys = { "d" },
              },
              action = nil,
            },
            -- accept diff
            accept = {
              mapping = {
                mode = "n",
                keys = { "Y", "y" },
              },
              action = nil,
            },
            -- reject diff
            reject = {
              mapping = {
                mode = "n",
                keys = { "N", "n" },
              },
              action = nil,
            },
            -- close diff
            close = {
              mapping = {
                mode = "n",
                keys = { "<esc>" },
              },
              action = nil,
            },
          },
        },
        CodeExplain = {
          handler = tools.flexi_handler,
          prompt = "Explain the following code, please only return the explanation",
          opts = {
            enter_flexible_window = true, -- [optinal] set your llm model

            -- url = "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions",
            -- model = "gemini-2.5-flash",
            -- fetch_key = function() return env.GEMINI_API_KEY end,
            -- api_type = "openai",
            -- max_tokens = 8192,
            -- temperature = 0.3,
            -- top_p = 0.7,
          },
        },
        DocString = {
          prompt = [[ You are an AI programming assistant. You need to write a really good docstring that follows a best practice for the given language.

Your core tasks include:
- parameter and return types (if applicable).
- any errors that might be raised or returned, depending on the language.

You must:
- Place the generated docstring before the start of the code.
- Follow the format of examples carefully if the examples are provided.
- Use Markdown formatting in your answers.
- Include the programming language name at the start of the Markdown code blocks.]],
          handler = tools.action_handler,
          opts = {
            only_display_diff = true,

            -- url = "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions",
            -- model = "gemini-2.5-flash",
            -- fetch_key = function() return env.GEMINI_API_KEY end,
            -- api_type = "openai",
            -- max_tokens = 8192,
            -- temperature = 0.3,
            -- top_p = 0.7,

            templates = {
              lua = [[- For the Lua language, you should use the LDoc style.
- Start all comment lines with "---".
]],
              javascript = [[- For the JavaScript language, you should use the JSDoc style.
- First comment line contains only "/**".
- Start following lines with "*".
- Last line contains only "*/".
]],
            },
          },
        },
        AttachToChat = {
          handler = tools.attach_to_chat_handler,
          opts = {
            is_codeblock = true,
            inline_assistant = true,
            diagnostic = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN },
            language = "English",
            -- display diff
            display = {
              mapping = {
                mode = "n",
                keys = { "d" },
              },
              action = nil,
            },
            -- accept diff
            accept = {
              mapping = {
                mode = "n",
                keys = { "Y", "y" },
              },
              action = nil,
            },
            -- reject diff
            reject = {
              mapping = {
                mode = "n",
                keys = { "N", "n" },
              },
              action = nil,
            },
            -- close diff
            close = {
              mapping = {
                mode = "n",
                keys = { "<esc>" },
              },
              action = nil,
            },
          },
        },
      },
    }
  end,
  keys = {
    { "<leader>;c", mode = "n", "<cmd>LLMSessionToggle<cr>", desc = "Chat" },
    { "<leader>;a", mode = { "x", "n" }, "<cmd>LLMAppHandler Ask<cr>", desc = "Ask" },
    { "<leader>;e", mode = { "x" }, "<cmd>LLMAppHandler CodeExplain<cr>", desc = "Explain Code" },
    { "<leader>;d", mode = { "x" }, "<cmd>LLMAppHandler DocString<cr>", desc = "Write Docstring" },
    { "<leader>;v", mode = { "x" }, "<cmd>LLMAppHandler AttachToChat<cr>", desc = "Chat with selected code" },
  },
}
