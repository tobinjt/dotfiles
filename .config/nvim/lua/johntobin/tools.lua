local M = {}

M.tools = {
  -- keep-sorted start block=true
  {
    compiler = "go",
    linter = { "golangcilint", "staticcheck" },
    lsp_server = "gopls",
    mason_package = { "delve", "golangci-lint", "gopls", "staticcheck" },
    parser = "go",
  },
  {
    compiler = "php",
    linter = "phpstan",
    lsp_server = "intelephense",
    mason_package = { "intelephense", "php-debug-adapter", "phpstan", },
    parser = "php",
  },
  {
    compiler = "python3",
    linter = "ruff",
    lsp_server = { "basedpyright", "ruff" },
    mason_package = { "basedpyright", "ruff", },
    parser = "python",
  },
  {
    compiler = "rustc",
    linter = "clippy",
    mason_package = "codelldb",
    parser = "rust",
  },
  {
    installer = "luarocks",
    mason_package = "luacheck",
  },
  {
    installer = "npm",
    linter = "jsonlint",
  },
  {
    installer = "npm",
    linter = "markdownlint",
  },
  {
    installer = "npm",
    lsp_server = "bashls",
    lsp_executable = "bash-language-server",
    mason_package = { "bash-debug-adapter", "bash-language-server" },
  },
  {
    linter = "eslint",
  },
  {
    linter = "jsonlint",
  },
  {
    linter = "markdownlint",
    mason_package = "marksman",
    parser = "markdown",
  },
  {
    linter = "shellcheck",
    mason_package = "shellcheck",
    parser = "bash",
  },
  {
    mason_package = "lua-language-server",
    parser = "lua",
  },
  {
    parser = "awk",
  },
  {
    parser = "css",
  },
  {
    parser = "gitcommit",
  },
  {
    parser = "html",
  },
  {
    parser = "luadoc",
  },
  {
    parser = "markdown_inline",
  },
  {
    parser = "printf",
  },
  {
    parser = "regex",
  },
  -- keep-sorted end
}

return M
