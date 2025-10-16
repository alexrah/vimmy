-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

local function command_exists(cmd)
    -- Use 'which' on Unix/Linux/macOS or 'where' on Windows
    local check_cmd = package.config:sub(1,1) == '\\' and 'where' or 'which'
    local handle = io.popen(check_cmd .. ' ' .. cmd .. ' 2>/dev/null')
    if not handle then
        return false
    end
    local result = handle:read("*a")
    handle:close()
    return result ~= nil and result ~= ""
end


if not command_exists("kubectl") then
  return {}
end

return {
  "diogo464/kubernetes.nvim",
  opts = {
    -- this can help with autocomplete. it sets the `additionalProperties` field on type definitions to false if it is not already present.
    schema_strict = true,
    -- true:  generate the schema every time the plugin starts
    -- false: only generate the schema if the files don't already exists. run `:KubernetesGenerateSchema` manually to generate the schema if needed.
    schema_generate_always = true,
    -- Patch yaml-language-server's validation.js file.
    patch = true,
    -- root path of the yamlls language server. by default it is assumed you are using mason but if not this option allows changing that path.
    yamlls_root = function() return vim.fs.joinpath(vim.fn.stdpath "data", "/mason/packages/yaml-language-server/") end,
  },
}
