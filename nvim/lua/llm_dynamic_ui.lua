
local function llm_get_dynamic_config()
  -- Get current window dimensions
  local width = vim.api.nvim_win_get_width(0)
  vim.notify('win width: '..width, 2)

  -- Define the minimum width threshold
  local min_width = 130 -- You can adjust this value as needed

  -- Only return the configuration if window is wide enough
  if width > min_width then
    return {
      style = "right", -- right | left | top | bottom
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
    }
  else
    -- Return nil or empty table when window is too narrow
    return nil
  end
end

local function llm_apply_dynamic_config()
  local config = llm_get_dynamic_config()

  -- If you need to merge with existing config
  local existing_config = require("llm").config or {}
  if config then
    require("llm").setup(vim.tbl_extend("force", existing_config, config))
  else
    -- Remove the dynamic parts if they exist
    require("llm").setup(existing_config)
  end

  -- For demonstration, let's just print the current state
  if config then
    vim.notify("Window is wide enough - applying full configuration", 2)
  else
    vim.notify("Window is too narrow - using minimal configuration", 2)
  end
end

return {
  llm_apply_dynamic_config = llm_apply_dynamic_config
}
