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

--- Normalizes a table value into a list
--- @param tbl table: The table to search in
--- @param key string: The key to look up
--- @return table: A list of values (empty, single-item, or the original table)
M.get_as_list = function(tbl, key)
  local val = tbl[key]
  if val == nil then
    return {}
  end
  if type(val) == "table" then
    return val
  end
  if type(val) == "string" then
    return { val }
  end
  -- Returns empty if the key exists but is an unexpected type
  return {}
end

-- Returns a list of LSP servers whose executables are installed.
M.make_lsp_enabled_servers = function()
  local enabled_servers = {}
  for _, tool_config in ipairs(M.tools) do
    local lsp_servers = M.get_as_list(tool_config, 'lsp_server')
    local lsp_executables = M.get_as_list(tool_config, 'lsp_executable')
    if #lsp_executables == 0 then
      lsp_executables = lsp_servers
    end
    for i, lsp_server in ipairs(lsp_servers) do
      local lsp_executable = lsp_executables[i]
      if vim.fn.executable(lsp_executable) == 1 then
        enabled_servers[lsp_server] = {
          name = lsp_server,
          executable = lsp_executable,
        }
      end
    end
  end

  return enabled_servers
end

return M
