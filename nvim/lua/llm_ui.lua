local function llm_apply_dynamic_config()
  -- INFO: Define the minimum width threshold
  local min_width = 130 -- You can adjust this value as needed

  -- Get current window dimensions
  local width = vim.api.nvim_win_get_width(0)
  -- vim.notify("win width: " .. width, 2)

  local existing_config = require("llm").config or {}

  if width > min_width then
    -- vim.notify("Window is wide enough - Vsplit UI", 2)
    require("llm").setup(vim.tbl_extend("force", existing_config, { style = "right" }))
  else
    -- vim.notify("Window is too narrow - Float UI", 2)
    require("llm").setup(vim.tbl_extend("force", existing_config, { style = "bottom" }))
  end
end

local function code_companion_apply_dynamic_config()
  -- INFO: Define the minimum width threshold
  local min_width = 130 -- You can adjust this value as needed

  -- Get current window di\mensions
  local width = vim.api.nvim_win_get_width(0)
  -- vim.notify("win width: " .. width, 2)

  local existing_config = require("codecompanion").config or {}

  if width > min_width then
    -- vim.notify("Window is wide enough - Vsplit UI", 2)
    require("codecompanion").setup(vim.tbl_extend("force", existing_config, { 
      display = {
        chat = {
          window = {
            position = "right",
            layout = "vertical",
          },
        },
      },
    }))
  else
    -- vim.notify("Window is too narrow - Float UI", 2)
    require("codecompanion").setup(vim.tbl_extend("force", existing_config, {
      display = {
        chat = {
          window = {
            position = "bottom",
            layout = "horizontal",
          },
        },
      },
    }))
  end
end

return {
  llm_apply_dynamic_config = llm_apply_dynamic_config,
  code_companion_apply_dynamic_config = code_companion_apply_dynamic_config,
}
