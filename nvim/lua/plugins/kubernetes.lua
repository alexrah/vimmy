-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

local function command_exists(cmd)
  -- Use 'which' on Unix/Linux/macOS or 'where' on Windows
  local check_cmd = package.config:sub(1, 1) == "\\" and "where" or "which"
  local handle = io.popen(check_cmd .. " " .. cmd .. " 2>/dev/null")
  if not handle then return false end
  local result = handle:read "*a"
  handle:close()
  return result ~= nil and result ~= ""
end

if not command_exists "kubectl" then return {} end

vim.api.nvim_create_autocmd("User", {
  pattern = "K8sContextChanged",
  callback = function(ctx)
    local results =
      require("kubectl.actions.commands").shell_command("kubectl", { "config", "use-context", ctx.data.context })
    if not results then vim.notify(results, vim.log.levels.INFO) end
  end,
})

return {
  {
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
  },
  {
    "Ramilito/kubectl.nvim",
    version = "2.*",
    -- build = "cargo build --release",
    opts = {},
    cmd = { "Kubectl", "Kubectx", "Kubens" },
    dependencies = "saghen/blink.download",
    keys = {
      { "<leader>k", desc = " 󱃾 Kubernetes" },
      { "<leader>kt", function() require("kubectl").toggle { tab = true } end, desc = "Open/Close kubectl" },
      { "g?", "<Plug>(kubectl.help)", ft = "k8s_*", desc = "Help" },
      { "<leader>k?", "<Plug>(kubectl.help)", ft = "k8s_*", desc = "Help" },
      { "gy", "<Plug>(kubectl.yaml)", ft = "k8s_*", desc = "view YAML" },
      { "1", "<Plug>(kubectl.view_deployments)", ft = "k8s_*" },
      { "<leader>k1", "<Plug>(kubectl.view_deployments)", ft = "k8s_*", desc = "Deployments" },
      { "2", "<Plug>(kubectl.view_daemonsets)", ft = "k8s_*" },
      { "<leader>k2", "<Plug>(kubectl.view_daemonsets)", ft = "k8s_*" , desc = "Daemonsets" },
      { "3", "<Plug>(kubectl.view_pods)", ft = "k8s_*" },
      { "<leader>k3", "<Plug>(kubectl.view_pods)", ft = "k8s_*", desc = "Pods" },
      { "4", "<Plug>(kubectl.view_configmaps)", ft = "k8s_*" },
      { "<leader>k4", "<Plug>(kubectl.view_configmaps)", ft = "k8s_*", desc = "Configmaps" },
      { "5", "<Plug>(kubectl.view_secrets)", ft = "k8s_*" },
      { "<leader>k5", "<Plug>(kubectl.view_secrets)", ft = "k8s_*", desc = "Secrets" },
      { "6", "<Plug>(kubectl.view_services)", ft = "k8s_*" },
      { "<leader>k6", "<Plug>(kubectl.view_services)", ft = "k8s_*", desc = "Services" },
      { "7", "<Plug>(kubectl.view_ingresses)", ft = "k8s_*" },
      { "<leader>k7", "<Plug>(kubectl.view_ingresses)", ft = "k8s_*", desc = "Ingresses" },
      { "8", function() vim.cmd "Kubectl view gateways.gateway.networking.k8s.io" end, ft = "k8s_*", desc = "Gateways" },
      { "<leader>k8", function() vim.cmd "Kubectl view gateways.gateway.networking.k8s.io" end, ft = "k8s_*", desc = "Gateways" },
      { "9", "<Plug>(kubectl.view_crds)", ft = "k8s_*" },
      { "<leader>k9", "<Plug>(kubectl.view_crds)", ft = "k8s_*", desc = "CRDs" },
      { "0", "<Plug>(kubectl.view_overview)", ft = "k8s_*" },
      { "<leader>k0", "<Plug>(kubectl.view_overview)", ft = "k8s_*", desc = "Overview" },
      { "<leader>ko", "<Plug>(kubectl.view_nodes)", ft = "k8s_*", desc = "Nodes" },
      { "<C-t>", "<Plug>(kubectl.view_top)", ft = "k8s_*" },
      { "<C-a>", "<Plug>(kubectl.alias_view)", ft = "k8s_*", desc = "Aliases" },
      { "<leader>ka", "<Plug>(kubectl.alias_view)", ft = "k8s_*", desc = "Aliases <C-a>" },
      { "<C-p>", "<Plug>(kubectl.picker_view)", ft = "k8s_*", desc = "Pickers" },
      { "<leader>kp", "<Plug>(kubectl.picker_view)", ft = "k8s_*", desc = "Pickers <C-p>" },
      { "<C-x>", "<Plug>(kubectl.contexts_view)", ft = "k8s_*", desc = "Contexts" },
      { "<leader>kx", "<Plug>(kubectl.contexts_view)", ft = "k8s_*", desc = "Contexts <C-x>" },
      { "<C-f>", "<Plug>(kubectl.filter_view)", ft = "k8s_*", desc = "Filter" },
      { "<leader>kf", "<Plug>(kubectl.filter_view)", ft = "k8s_*", desc = "Filter <C-f>" },
      { "<C-n>", "<Plug>(kubectl.namespace_view)", ft = "k8s_*", desc = "Namespaces" },
      { "<leader>kn", "<Plug>(kubectl.namespace_view)", ft = "k8s_*", desc = "Namespaces <C-n>" },
      { "<C-b>", "<Plug>(kubectl.filter_label)", ft = "k8s_*", desc = "Filter labels" },
      { "<leader>kb", "<Plug>(kubectl.filter_label)", ft = "k8s_*", desc = "Filter labels <C-b>" },
      { "<C-r>", "<Plug>(kubectl.view_drift)", ft = "k8s_*", desc = "Drift" },
      { "<leader>kr", "<Plug>(kubectl.view_drift)", ft = "k8s_*", desc = "Drift" },
    },
    config = function() require("kubectl").setup() end,
  },
}
