local M = {}

M.tools = {
  -- keep-sorted start block=true by_regex=".*"
  {
    -- keep-sorted start block=true
    filetype = "awk",
    linter = "awk",
    parser = "awk",
    -- keep-sorted end
  },
  {
    -- keep-sorted start block=true
    lsp_executable = "bash-language-server",
    lsp_server = "bashls",
    mason_installer = "npm",
    mason_package = { "bash-debug-adapter", "bash-language-server" },
    -- keep-sorted end
  },
  {
    -- keep-sorted start block=true
    parser = "css",
    -- keep-sorted end
  },
  {
    -- keep-sorted start block=true
    parser = "gitcommit",
    -- keep-sorted end
  },
  {
    -- keep-sorted start block=true
    compiler = "go",
    filetype = "go",
    linter = { "golangcilint", "staticcheck" },
    linter_executable = { "golangci-lint", "staticcheck" },
    lsp_server = "gopls",
    mason_installer = "go",
    mason_package = { "delve", "golangci-lint", "gopls", "staticcheck" },
    parser = "go",
    -- keep-sorted end
  },
  {
    -- keep-sorted start block=true
    parser = "html",
    -- keep-sorted end
  },
  {
    -- keep-sorted start block=true
    filetype = "javascript",
    linter = "eslint",
    -- keep-sorted end
  },
  {
    -- keep-sorted start block=true
    parser = "jjdescription",
    -- keep-sorted end
  },
  {
    -- keep-sorted start block=true
    filetype = "json",
    linter = "jsonlint",
    mason_installer = "npm",
    mason_package = "jsonlint",
    -- keep-sorted end
  },
  {
    -- keep-sorted start block=true
    filetype = "lua",
    -- linter = "luacheck",
    lsp_executable = "lua-language-server",
    lsp_options = {
      root_markers = {
        -- This is copied from nvim-lspconfig/lsp/lua_ls.lua and extended with
        -- .exercism so that when working on Exercism exercises I only load the
        -- current exercise not the entire set. I would prefer to load the base
        -- list from nvim-lspconfig, but that means either I require that module
        -- which will break bootstrapping, or I make this opts a function and
        -- multiple opts functions can be tricky to manage.
        --
        -- keep-sorted start
        ".exercism",
        ".luacheckrc",
        ".luarc.json",
        ".luarc.jsonc",
        ".stylua.toml",
        "selene.toml",
        "selene.yml",
        "stylua.toml",
        -- keep-sorted end
        -- Keep .git to the end because the others are more specific.
        ".git",
      },
      settings = {
        Lua = {
          diagnostics = {
            -- Get the language server to recognize the `vim` global and busted
            -- functions.
            globals = {
              -- keep-sorted start
              "after_each",
              "before_each",
              "describe",
              "it",
              "pending",
              "setup",
              "teardown",
              "vim",
              -- keep-sorted end
            },
          },
          workspace = {
            library = vim.list_extend(
              vim.fn.split(vim.fn.glob("~/.local/share/nvim/lazy/*/lua"), "\n"),
              { vim.env.VIMRUNTIME }
            ),
            userThirdParty = {
              vim.fn.expand("~/.local/share/nvim/lazy/busted"),
            },
          },
        },
      },
    },
    lsp_server = "lua_ls",
    mason_package = "lua-language-server",
    parser = "lua",
    -- keep-sorted end
  },
  {
    -- keep-sorted start block=true
    parser = "luadoc",
    -- keep-sorted end
  },
  {
    -- keep-sorted start block=true
    filetype = "markdown",
    linter = "markdownlint",
    mason_installer = "npm",
    mason_package = "markdownlint",
    parser = "markdown",
    -- keep-sorted end
  },
  {
    -- keep-sorted start block=true
    filetype = "markdown",
    linter = "vale",
    mason_package = "vale",
    -- keep-sorted end
  },
  {
    -- keep-sorted start block=true
    filetype = "markdown",
    lsp_server = "vale-ls",
    mason_package = "vale-ls",
    -- keep-sorted end
  },
  {
    -- keep-sorted start block=true
    parser = "markdown_inline",
    -- keep-sorted end
  },
  {
    -- keep-sorted start block=true
    compiler = "php",
    filetype = "php",
    linter = "phpstan",
    lsp_server = "intelephense",
    mason_installer = "php",
    mason_package = { "intelephense", "php-debug-adapter", "phpstan", },
    parser = "php",
    -- keep-sorted end
  },
  {
    -- keep-sorted start block=true
    parser = "printf",
    -- keep-sorted end
  },
  {
    -- keep-sorted start block=true
    compiler = "python3",
    filetype = "python",
    linter = { "pyrefly", "ruff" },
    lsp_server = { "basedpyright", "pyrefly", "ruff" },
    mason_installer = "python3",
    mason_package = { "basedpyright", "black", "debugpy", "mypy", "pyrefly", "ruff", },
    parser = "python",
    -- keep-sorted end
  },
  {
    -- keep-sorted start block=true
    parser = "regex",
    -- keep-sorted end
  },
  {
    -- keep-sorted start block=true
    compiler = "rustc",
    filetype = "rust",
    linter = "clippy",
    linter_executable = "cargo-clippy",
    mason_installer = "rustc",
    mason_package = "codelldb",
    parser = "rust",
    -- keep-sorted end
  },
  {
    -- keep-sorted start block=true
    filetype = "sh",
    linter = "shellcheck",
    mason_package = "shellcheck",
    parser = "bash",
    -- keep-sorted end
  },
  {
    -- keep-sorted start block=true
    filetype = "yaml",
    linter = { "actionlint", "zizmor", },
    mason_package = "actionlint",
    -- keep-sorted end
  },
  -- keep-sorted end
}

--- Normalizes a table value into a list.
--- @param tbl table: The table to search in.
--- @param key string: The key to look up.
--- @param default? table: The default to return if the key isn't found or is
--- nil.
--- @return table: A list of values (empty, single-item, or the original table)
M.get_as_list = function(tbl, key, default)
  default = default or {}
  local val = tbl[key]
  if val == nil then
    return default
  end
  if type(val) == "table" then
    return val
  end
  if type(val) == "string" then
    return { val }
  end
  -- Returns default if the key exists but is an unexpected type.
  return default
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

--- Appends a formatted message to logs if a log table is provided.
--- @param logs table?: Optional list to append log messages to.
--- @param fmt string: Format string (or literal message if no extra args).
local function append_log(logs, fmt, ...)
  if logs ~= nil then
    local msg = select("#", ...) > 0 and string.format(fmt, ...) or fmt
    table.insert(logs, msg)
  end
end

--- Returns a table of installed linters by filetype.
--- @param logs table?: Optional list to append unavailability log messages to.
--- @return table<string, string[]>
M.make_linters_by_ft = function(logs)
  local linters = {}
  for _, tool_config in ipairs(M.tools) do
    local linter_names = M.get_as_list(tool_config, 'linter')

    if tool_config.filetype == nil then
      if #linter_names > 0 then
        vim.notify("Linter is " .. table.concat(linter_names, ", ") .. " but filetype is nil",
          vim.log.levels.WARN)
        for _, linter in ipairs(linter_names) do
          append_log(logs, "Linter '%s' unavailable: filetype is nil", linter)
        end
      end
      goto continue
    end

    if linters[tool_config.filetype] == nil then
      linters[tool_config.filetype] = {}
    end
    if not M.check_executable(tool_config.compiler) then
      for _, linter in ipairs(linter_names) do
        append_log(
          logs,
          "Linter '%s' (filetype '%s') unavailable: compiler '%s' is not executable",
          linter,
          tool_config.filetype,
          tool_config.compiler
        )
      end
      goto continue
    end

    local linter_executables = M.get_as_list(
      tool_config,
      'linter_executable',
      linter_names
    )
    for i, linter in ipairs(linter_names) do
      local linter_executable = linter_executables[i]
      if linter_executable ~= nil and linter_executable ~= "" and vim.fn.executable(linter_executable) == 1 then
        table.insert(linters[tool_config.filetype], linter)
      else
        append_log(
          logs,
          "Linter '%s' (filetype '%s') unavailable: executable '%s' is not executable",
          linter,
          tool_config.filetype,
          tostring(linter_executable)
        )
      end
    end

    ::continue::
  end

  table.sort(linters)
  return linters
end

--- Returns a list of LSP servers whose executables are installed.
--- @param logs table?: Optional list to append unavailability log messages to.
--- @return table<string, table>
M.make_lsp_enabled_servers = function(logs)
  local enabled_servers = {}
  for _, tool_config in ipairs(M.tools) do
    local lsp_servers = M.get_as_list(tool_config, 'lsp_server')
    local lsp_executables = M.get_as_list(
      tool_config,
      'lsp_executable',
      lsp_servers
    )
    for i, lsp_server in ipairs(lsp_servers) do
      local lsp_executable = lsp_executables[i]
      if lsp_executable ~= nil and lsp_executable ~= "" and vim.fn.executable(lsp_executable) == 1 then
        enabled_servers[lsp_server] = {
          name = lsp_server,
          executable = lsp_executable,
          server_opts = tool_config.lsp_options,
        }
      else
        append_log(
          logs,
          "LSP server '%s' unavailable: executable '%s' is not executable",
          lsp_server,
          tostring(lsp_executable)
        )
      end
    end
  end

  table.sort(enabled_servers)
  return enabled_servers
end

--- Returns a list of Mason packages with mason_installers available.
--- @param logs table?: Optional list to append unavailability log messages to.
--- @return table[]
M.make_mason_package_install_list = function(logs)
  local packages_to_install = {}
  for _, tool_config in ipairs(M.tools) do
    local mason_packages = M.get_as_list(tool_config, 'mason_package')
    if #mason_packages > 0 then
      local compiler_ok = M.check_executable(tool_config.compiler)
      local installer_ok = M.check_executable(tool_config.mason_installer)
      if compiler_ok and installer_ok then
        for _, package in ipairs(mason_packages) do
          table.insert(packages_to_install, { package })
        end
      else
        local reasons = {}
        if not compiler_ok then
          table.insert(reasons, string.format("compiler '%s' is not executable", tool_config.compiler))
        end
        if not installer_ok then
          table.insert(reasons, string.format("mason_installer '%s' is not executable", tool_config.mason_installer))
        end
        local reason_str = table.concat(reasons, " and ")
        for _, package in ipairs(mason_packages) do
          append_log(
            logs,
            "Mason package '%s' unavailable: %s",
            package,
            reason_str
          )
        end
      end
    end
  end

  table.sort(packages_to_install, function(a, b) return a[1] < b[1] end)
  return packages_to_install
end

--- Returns a list of Treesitter parsers to install.
--- @param logs table?: Optional list to append unavailability log messages to.
--- @return string[]
M.make_treesitter_parsers_to_install = function(logs)
  local parsers = {}
  for _, tool_config in ipairs(M.tools) do
    if tool_config.parser == nil then
      goto continue
    end
    if not M.check_executable(tool_config.compiler) then
      append_log(
        logs,
        "Treesitter parser '%s' unavailable: compiler '%s' is not executable",
        tool_config.parser,
        tool_config.compiler
      )
      goto continue
    end
    table.insert(parsers, tool_config.parser)

    ::continue::
  end

  table.sort(parsers)
  return parsers
end

--- Debugging function that displays the results of each of the `make_*` functions.
M.debug = function()
  local logs = {}
  local results = {
    linters_by_ft = M.make_linters_by_ft(logs),
    lsp_enabled_servers = M.make_lsp_enabled_servers(logs),
    mason_package_install_list = M.make_mason_package_install_list(logs),
    treesitter_parsers_to_install = M.make_treesitter_parsers_to_install(logs),
    logs = logs,
  }
  vim.print(results)
end

return M
