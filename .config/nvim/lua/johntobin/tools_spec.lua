local tools = require("johntobin.tools")

describe("johntobin.tools", function()
  local original_tools
  local orig_executable
  local orig_notify

  before_each(function()
    original_tools = tools.tools

    orig_executable = vim.fn.executable
    vim.fn.executable = function(prog)
      local execs = {
        go = 1,
        ["golangci-lint"] = 1,
        python3 = 0,
        ruff = 1,
        bashls = 1,
        ["bash-language-server"] = 1,
        npm = 1,
      }
      return execs[prog] or 0
    end

    orig_notify = vim.notify
    vim.notify = function() end

    tools.tools = {
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
        compiler = "python3",
        filetype = "python",
        linter = "ruff",
      },
      {
        lsp_server = "bashls",
        lsp_executable = "bash-language-server",
        mason_installer = "npm",
        mason_package = { "bash-debug-adapter", "bash-language-server" },
      },
      {
        filetype = "custom",
      }
    }
  end)

  after_each(function()
    tools.tools = original_tools
    vim.fn.executable = orig_executable
    vim.notify = orig_notify
  end)

  describe("get_as_list", function()
    it("returns default when key is missing", function()
      assert.are.same({ "def" }, tools.get_as_list({}, "missing", { "def" }))
    end)

    it("returns empty list when key is missing and no default provided", function()
      assert.are.same({}, tools.get_as_list({}, "missing"))
    end)

    it("returns table as is", function()
      assert.are.same({ "val1", "val2" }, tools.get_as_list({ key = { "val1", "val2" } }, "key"))
    end)

    it("wraps string in a table", function()
      assert.are.same({ "val" }, tools.get_as_list({ key = "val" }, "key"))
    end)

    it("returns default for unexpected type", function()
      assert.are.same({ "def" }, tools.get_as_list({ key = 123 }, "key", { "def" }))
    end)
  end)

  describe("check_executable", function()
    it("returns true for nil", function()
      assert.is_true(tools.check_executable(nil))
    end)

    it("returns true for empty string", function()
      assert.is_true(tools.check_executable(""))
    end)

    it("returns true if executable", function()
      assert.is_true(tools.check_executable("go"))
    end)

    it("returns false if not executable", function()
      assert.is_false(tools.check_executable("python3"))
    end)
  end)

  describe("make_linters_by_ft", function()
    it("returns correct linters based on executables", function()
      local linters = tools.make_linters_by_ft()
      assert.are.same({
        custom = { "no_op" },
        go = { "golangcilint" },
        python = { "no_op" }
      }, linters)
    end)
  end)

  describe("make_lsp_enabled_servers", function()
    it("returns enabled LSP servers based on executables", function()
      local servers = tools.make_lsp_enabled_servers()
      assert.are.same({
        bashls = {
          executable = "bash-language-server",
          name = "bashls"
        }
      }, servers)
    end)
  end)

  describe("make_mason_package_install_list", function()
    it("returns mason packages to install if compiler and mason_installer exist", function()
      local packages = tools.make_mason_package_install_list()
      assert.are.same({
        { "bash-debug-adapter" },
        { "bash-language-server" },
        { "delve" },
        { "golangci-lint" },
        { "gopls" },
        { "staticcheck" }
      }, packages)
    end)
  end)

  describe("make_treesitter_parsers_to_install", function()
    it("returns parsers to install if compiler exists or is not specified", function()
      tools.tools = {
        {
          compiler = "go",
          parser = "go",
        },
        {
          compiler = "python3",
          parser = "python",
        },
        {
          parser = "lua",
        }
      }
      local parsers = tools.make_treesitter_parsers_to_install()
      assert.are.same({ "go", "lua" }, parsers)
    end)
  end)
end)
