-- Automatic installation and configuration of LSP servers, linters, and more.
-- Required setup order from :h mason-lspconfig-quickstart:
-- - mason
-- - mason-lspconfig
-- - configure LSP servers.
-- I have configured dependencies in lsp.lua to do this.

local paths = require("johntobin.paths")

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
    -- Don't install tooling for other users.
    cond = vim.fn.getenv("USER") == "johntobin",
    dependencies = {
      "mason.nvim",
      -- Configured in lsp.lua.
      "mason-lspconfig.nvim",
      -- Configured in debugging.lua.
      "jay-babu/mason-nvim-dap.nvim",
    },
    opts = {
      auto_update = true,
      -- Wait 24 hours between installation checks.
      -- Delete ~/.local/share/nvim/mason-tool-installer-debounce
      debounce_hours = 24,
      ensure_installed = {
        -- TODO: can I move this to a separate file and generate config for
        -- lint.lua and lsp.lua from it?
        -- NOTE: linters need to be enabled in lint.lua, and LSP servers need to
        -- be enabled in lsp.lua.
        -- Always want these installed.
        -- keep-sorted start
        "lua-language-server",
        "marksman",
        "phpstan",
        "shellcheck",
        "vint",
        -- keep-sorted end
        -- Install these if the installer is available, skip if not.
        -- Note: I install debugpy separately so that other modules are
        -- available with it.
        -- keep-sorted start by_regex=['paths.installer_is_available_function."(\w+)"', '"(\w+)"']
        { "delve",                condition = paths.installer_is_available_function("go"), },
        { "golangci-lint",        condition = paths.installer_is_available_function("go"), },
        { "gopls",                condition = paths.installer_is_available_function("go"), },
        { "staticcheck",          condition = paths.installer_is_available_function("go"), },
        { "luacheck",             condition = paths.installer_is_available_function("luarocks"), },
        { "jsonlint",             condition = paths.installer_is_available_function("npm"), },
        { "markdownlint",         condition = paths.installer_is_available_function("npm"), },
        { "bash-debug-adapter",   condition = paths.installer_is_available_function("npm"), },
        { "bash-language-server", condition = paths.installer_is_available_function("npm"), },
        { "vim-language-server",  condition = paths.installer_is_available_function("npm"), },
        { "intelephense",         condition = paths.installer_is_available_function("php"), },
        { "php-debug-adapter",    condition = paths.installer_is_available_function("php"), },
        { "basedpyright",         condition = paths.installer_is_available_function("python3"), },
        { "ruff",                 condition = paths.installer_is_available_function("python3"), },
        { "codelldb",             condition = paths.installer_is_available_function("rustc"), },
        -- keep-sorted end
      },
    },
  },
}
