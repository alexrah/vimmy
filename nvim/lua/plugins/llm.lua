-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  "Kurama622/llm.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", "echasnovski/mini.diff" },
  cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
  config = function()
    local tools = require "llm.tools"
    require("llm").setup {
      url = "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions",
      model = "gemini-2.5-pro",
      api_type = "openai",
      max_tokens = 8192,
      temperature = 0.3,
      top_p = 0.7,
      fetch_key = function() return vim.env.GEMINI_API_KEY end,

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

      -- history_path = "/tmp/llm-history",
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
            -- fetch_key = function() return vim.env.CHAT_ANYWHERE_KEY end,

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
            enter_flexible_window = true,
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
      },
    }
  end,
  keys = {
    { "<leader>;c", mode = "n", "<cmd>LLMSessionToggle<cr>", desc = "Chat with GEMINI-2.5-pro" },
    { "<leader>;a", mode = { "x", "n" }, "<cmd>LLMAppHandler Ask<cr>", desc = "Ask GEMINI-2.5-pro" },
    { "<leader>;e", mode = { "x" }, "<cmd>LLMAppHandler CodeExplain<cr>", desc = "Explain Code" },
    { "<leader>;d", mode = { "x" }, "<cmd>LLMAppHandler DocString<cr>", desc = "Write Docstring" },
  },
}
