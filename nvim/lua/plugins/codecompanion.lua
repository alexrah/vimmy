-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
--
-- Check if DEEPSEEK_API_KEY is defined and not empty
if not vim.env.DEEPSEEK_API_KEY or vim.env.DEEPSEEK_API_KEY == "" then return {} end

local adapterACP = "claude_code"
local adapterHTTP = { name = "deepseek", model = "deepseek-chat" }

--- @class prompt_opt
--- @field adapter {name: string, model: string} | string Adapter configuration
--- @field alias string? Allows the prompt to be triggered via :CodeCompanion /{alias}
--- @field auto_submit boolean? Automatically submit the prompt to the LLM
--- @field enabled boolean? Enable/disable the prompt without removing it from the library
--- @field ignore_system_prompt boolean? Don't send the default system prompt with the request
--- @field intro_message string? Custom intro message for the chat buffer UI
--- @field is_slash_cmd boolean? Make the prompt available as a slash command in chat
--- @field is_workflow boolean? Treat successive prompts as a workflow
--- @field modes string[]? Only show in specific modes ({ "v" } for visual mode)
--- @field placement string? For inline interaction: new, replace, add, before, chat
--- @field pre_hook function? Function to run before the prompt is executed (Lua only)
--- @field stop_context_insertion boolean? Prevent automatic context insertion
--- @field user_prompt string? Get user input before actioning the response

--- @class prompt_context
--- @field bufnr integer Buffer number
--- @field buftype string Buffer type
--- @field code string Selected code content
--- @field cursor_pos integer[] Cursor position {line, column}
--- @field end_col integer End column of selection
--- @field end_line integer End line of selection
--- @field filetype string File type
--- @field is_normal boolean Whether in normal mode
--- @field is_visual boolean Whether in visual mode
--- @field lines string[] Selected lines
--- @field mode string Current mode (e.g., "V" for visual line mode)
--- @field start_col integer Start column of selection
--- @field start_line integer Start line of selection
--- @field winnr integer Window number

--- @class prompt_definition
--- @field interaction string Type of interaction (e.g., "inline", "chat")
--- @field description string Description of the prompt
--- @field opts prompt_opt? Prompt options
--- @field prompts prompt_message[] Array of prompt messages

--- @class prompt_message
--- @field role string Role of the message (e.g., "system", "user")
--- @field content string|fun(context: prompt_context): string Message content or function returning content


--- @return prompt_definition
local function prompt_documentations()
  --- @type prompt_definition
  local prompt = {
    interaction = "chat",
    description = "Generate Documentation",
    opts = {
      auto_submit = true,
      modes = { "v" },
      placement = "replace",
      adapter = adapterACP
    },
    prompts = {
      {
        role = "system",
        content = [[ You are an expert code reviewer that generates code documentation
        following the standard practices for the given programming language.
        When you generate documentation, you must:
        - Read the content of the current file
        - Get the file context to better understand the code
        - Generate documentation based on the context
        ]],
      },
      {
        role = "user",
        --- @param context prompt_context
        content = function(context)
          return string.format("#{buffer}\n\n Based on the current %s file, insert doc string for the following code:\n %s",
            context.filetype, context.code
          )
        end,
      },
    },
  }
  return prompt
end

return {
  "olimorris/codecompanion.nvim",
  version = "^18.0.0",
  opts = {
    interactions = {
      chat = {
        adapter = adapterACP,
      },
      inline = {
        adapter = adapterHTTP,
        keymaps = {
          accept_change = {
            modes = { n = "gda" }, -- Remember this as DiffAccept
          },
          reject_change = {
            modes = { n = "gdr" }, -- Remember this as DiffReject
          },
          always_accept = {
          modes = { n = "gdy" }, -- Remember this as DiffYolo
          },
        },
      },
      cmd = {
        adapter = adapterHTTP,
      },
    },
    display = {
      chat = {
        window = {
          position = "right",
          layout = "vertical",
        },
      },
    },
    opts = {
      -- log_level = "DEBUG",
    },
    extensions = {
      history = {
        enabled = true,
        opts = {
          auto_save = true,
        },
      },
    },
    prompt_library = {
      ["DocString"] = prompt_documentations(),
    },
  },
  dependencies = {
    { "nvim-lua/plenary.nvim", branch = "master" },
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/codecompanion-history.nvim",
  },
}

