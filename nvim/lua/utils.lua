local M = {}

function M.is_linux()
  return vim.uv.os_uname().sysname == "Linux"
end

return M
