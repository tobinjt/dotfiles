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
    linter = "luacheck",
    mason_installer = "luarocks",
    mason_package = "luacheck",
    parser = "luadoc",
    -- keep-sorted end
  },
  {
    -- keep-sorted start block=true
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
    filetype = "markdown",
    linter = "markdownlint",
    mason_installer = "npm",
    mason_package = "markdownlint",
    parser = "markdown",
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
    linter = "ruff",
    lsp_server = { "basedpyright", "ruff" },
    mason_installer = "python3",
    mason_package = { "basedpyright", "ruff", },
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
    linter = "zizmor",
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

--- Returns a table of installed linters by filetype.
M.make_linters_by_ft = function()
  local linters = {}
  for _, tool_config in ipairs(M.tools) do
    if tool_config.filetype == nil then
      if tool_config.linter ~= nil then
        vim.notify("Linter is " .. tool_config.linter .. " but filetype is nil",
          vim.log.levels.WARN)
      end
      goto continue
    end

    if linters[tool_config.filetype] == nil then
      linters[tool_config.filetype] = {}
    end
    if not M.check_executable(tool_config.compiler) then
      goto continue
    end

    local linter_names = M.get_as_list(tool_config, 'linter')
    local linter_executables = M.get_as_list(
      tool_config,
      'linter_executable',
      linter_names
    )
    for i, linter in ipairs(linter_names) do
      if vim.fn.executable(linter_executables[i]) == 1 then
        table.insert(linters[tool_config.filetype], linter)
      end
    end

    ::continue::
  end

  table.sort(linters)
  return linters
end

--- Returns a list of LSP servers whose executables are installed.
M.make_lsp_enabled_servers = function()
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
      if vim.fn.executable(lsp_executable) == 1 then
        enabled_servers[lsp_server] = {
          name = lsp_server,
          executable = lsp_executable,
          server_opts = tool_config.lsp_options,
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
    if tool_config.parser == nil then
      goto continue
    end
    if tool_config.compiler ~= nil and
        vim.fn.executable(tool_config.compiler) == 0 then
      goto continue
    end
    table.insert(parsers, tool_config.parser)

    ::continue::
  end

  table.sort(parsers)
  return parsers
end

return M
