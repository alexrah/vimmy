-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
      },
      -- hijack_netrw_behavior = "disabled"
    },
    default_component_configs = {
      file_size = {
        required_width = 50
      },
      last_modified = {
        required_width = 40
      }

    }
  },
}
