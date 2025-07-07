-- Automatic installation and configuration of LSP servers, linters, and more.
-- Required setup order from :h mason-lspconfig-quickstart:
-- - mason
-- - mason-lspconfig
-- - configure LSP servers.
-- I have configured dependencies in lsp.lua to do this.

-- This function returns a function to check whether installer is available.
-- It will be used in the config for mason-tool-installer.
local installer_is_available = function(installer)
  return function()
    return vim.fn.executable(installer) == 1
  end
end

return {
  {
    "mason-org/mason.nvim",
    opts = {
      -- Prepending means I can't write wrappers, so append.
      -- Mason's bin dir is in my PATH already, so this should be a no-op, but
      -- just in case let's append.
      PATH = "append",
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      -- Automatic enabling is problematic when there are multiple servers for
      -- one filetype, so disable it.
      automatic_enable = false,
    },
    dependencies = {
      "mason.nvim",
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "mason.nvim",
      -- Configured in lsp.lua.
      "mason-lspconfig.nvim",
      -- Configured in debugging.lua.
      "jay-babu/mason-nvim-dap.nvim",
    },
    opts = {
      -- Wait 24 hours between installation checks.
      debounce_hours = 24,
      ensure_installed = {
        -- Always want these installed.
        -- keep-sorted start
        "bash-debug-adapter",
        "lua-language-server",
        "marksman",
        "phpstan",
        "shellcheck",
        "vint",
        -- keep-sorted end
        -- Install these if the installer is available, skip if not.
        -- keep-sorted start by_regex=['installer_is_available."(\w+)"', '"(\w+)"']
        { "delve",                condition = installer_is_available("go"), },
        { "golangci-lint",        condition = installer_is_available("go"), },
        { "gopls",                condition = installer_is_available("go"), },
        { "staticcheck",          condition = installer_is_available("go"), },
        { "luacheck",             condition = installer_is_available("luarocks"), },
        { "jsonlint",             condition = installer_is_available("npm"), },
        { "markdownlint",         condition = installer_is_available("npm"), },
        { "bash-debug-adapter",   condition = installer_is_available("npm"), },
        { "bash-language-server", condition = installer_is_available("npm"), },
        { "vim-language-server",  condition = installer_is_available("npm"), },
        { "intelephense",         condition = installer_is_available("php"), },
        { "php-debug-adapter",    condition = installer_is_available("php"), },
        { "debugpy",              condition = installer_is_available("python3"), },
        { "mdformat",             condition = installer_is_available("python3"), },
        { "python-lsp-server",    condition = installer_is_available("python3"), },
        { "ruff",                 condition = installer_is_available("python3"), },
        { "codelldb",             condition = installer_is_available("rustc"), },
        -- keep-sorted end
      },
    },
  },
}
