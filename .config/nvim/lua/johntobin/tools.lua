local paths = require("johntobin.paths")

local M = {}

M.tools = {
  -- keep-sorted start block=true by_regex=filetype.*|mason_installer.*|mason_package.*
  {
    filetype = "awk",
    linter = "awk",
    parser = "awk",
  },
  {
    compiler = "go",
    filetype = "go",
    linter = { "golangcilint", "staticcheck" },
    linter_executable = { "golangci-lint", "staticcheck" },
    lsp_server = "gopls",
    mason_installer = "go",
    mason_package = { "delve", "golangci-lint", "gopls", "staticcheck" },
    parser = "go",
  },
  {
    filetype = "javascript",
    linter = "eslint",
  },
  {
    filetype = "json",
    linter = "jsonlint",
    mason_installer = "npm",
    mason_package = "jsonlint",
  },
  {
    filetype = "lua",
    linter = "luacheck",
    mason_installer = "luarocks",
    mason_package = "luacheck",
    parser = "luadoc",
  },
  {
    filetype = "markdown",
    linter = "markdownlint",
    mason_installer = "npm",
    mason_package = "marksman",
    parser = "markdown",
  },
  {
    compiler = "php",
    filetype = "php",
    linter = "phpstan",
    lsp_server = "intelephense",
    mason_installer = "php",
    mason_package = { "intelephense", "php-debug-adapter", "phpstan", },
    parser = "php",
  },
  {
    compiler = "python3",
    filetype = "python",
    linter = "ruff",
    lsp_server = { "basedpyright", "ruff" },
    mason_installer = "python3",
    mason_package = { "basedpyright", "ruff", },
    parser = "python",
  },
  {
    compiler = "rustc",
    filetype = "rust",
    linter = "clippy",
    linter_executable = "cargo-clippy",
    mason_installer = "rustc",
    mason_package = "codelldb",
    parser = "rust",
  },
  {
    filetype = "sh",
    linter = "shellcheck",
    mason_package = "shellcheck",
    parser = "bash",
  },
  {
    lsp_server = "bashls",
    lsp_executable = "bash-language-server",
    mason_installer = "npm",
    mason_package = { "bash-debug-adapter", "bash-language-server" },
  },
  {
    mason_package = "lua-language-server",
    parser = "lua",
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

--- Returns true if a program isn't specified or it's specified and executable.
--- @param program string?: the name of the program to check
--- @return boolean: True if the program is executable (or not specified), false
---                         otherwise.
M.check_executable = function(program)
  if program == nil or program == "" then
    return true
  end
  return vim.fn.executable(program) == 1
end

--- Returns a table of installed linters by filetype.
M.make_linters_by_ft = function()
  local linters = {}
  for _, tool_config in ipairs(M.tools) do
    if tool_config.linter ~= nil and tool_config.filetype == nil then
      vim.notify("Linter is " .. tool_config.linter .. " but filetype is nil",
        vim.log.levels.WARN)
    end

    if tool_config.filetype ~= nil then
      if linters[tool_config.filetype] == nil then
        linters[tool_config.filetype] = {}
      end
      if M.check_executable(tool_config.compiler) then
        local linter_names = M.get_as_list(tool_config, 'linter')
        local linter_executables = M.get_as_list(tool_config, 'linter_executable')
        if #linter_executables == 0 then
          linter_executables = linter_names
        end
        for i, linter in ipairs(linter_names) do
          if vim.fn.executable(linter_executables[i]) == 1 then
            table.insert(linters[tool_config.filetype], linter)
          end
        end
      end
    end
  end

  for key, value in pairs(linters) do
    if #value == 0 then
      -- This is a custom linter I defined in lint.lua.
      linters[key] = { "no_op" }
    end
  end

  table.sort(linters)
  return linters
end

--- Returns a list of LSP servers whose executables are installed.
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

  table.sort(enabled_servers)
  return enabled_servers
end

--- Returns a list of Mason packages with mason_installers available.
M.make_mason_package_install_list = function()
  local packages_to_install = {}
  for _, tool_config in ipairs(M.tools) do
    if M.check_executable(tool_config.compiler)
        and M.check_executable(tool_config.mason_installer)
        -- TODO: remove when the imac is decomissioned.
        and paths.not_exists_function("/usr/local/Cellar")
    then
      for _, package in ipairs(M.get_as_list(tool_config, 'mason_package')) do
        table.insert(packages_to_install, { package })
      end
    end
  end

  table.sort(packages_to_install, function(a, b) return a[1] < b[1] end)
  return packages_to_install
end

--- Returns a list of Treesitter parsers to install.
M.make_treesitter_parsers_to_install = function()
  local parsers = {}
  for _, tool_config in ipairs(M.tools) do
    local install = true
    if tool_config.parser == nil then
      install = false
    end
    if install and tool_config.compiler ~= nil then
      if vim.fn.executable(tool_config.compiler) == 0 then
        install = false
      end
    end
    if install then
      table.insert(parsers, tool_config.parser)
    end
  end

  table.sort(parsers)
  return parsers
end

return M
