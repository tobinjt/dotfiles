-- Install the tools I use.
-- Map of "install tool" => "list of tools to install", so I only try to install
-- tools where the install tool exists.
local tools = {
  -- keep-sorted start block=yes
  -- Use an install tool that always exists, because I want a noisy error if I
  -- can't install these tools, or they really don't have any installation
  -- dependencies.
  cat = {
    -- keep-sorted start
    "bash-debug-adapter",
    "lua-language-server",
    "marksman",
    "phpstan",
    "shellcheck",
    "vint",
    -- keep-sorted end
  },
  go = {
    -- keep-sorted start
    "delve",
    "golangci-lint",
    "gopls",
    "staticcheck",
    -- keep-sorted end
  },
  luarocks = {
    -- keep-sorted start
    "luacheck",
    -- keep-sorted end
  },
  npm = {
    -- keep-sorted start
    "bash-language-server",
    "jsonlint",
    "markdownlint",
    "prettier",
    "vim-language-server",
    -- keep-sorted end
  },
  php = {
    -- keep-sorted start
    "intelephense",
    "php-debug-adapter",
    -- keep-sorted end
  },
  python3 = {
    -- keep-sorted start
    "debugpy",
    "mdformat",
    "python-lsp-server",
    "ruff",
    -- keep-sorted end
  },
  rustc = {
    -- keep-sorted start
    "codelldb",
    -- keep-sorted end
  },
  -- keep-sorted end
}

local mason_registry = require("mason-registry")
for installer, tool_list in pairs(tools) do
  if vim.fn.executable(installer) == 1 then
    for _, tool in ipairs(tool_list) do
      if vim.fn.executable(tool) == 0 and not mason_registry.is_installed(tool) then
        vim.cmd(":MasonInstall " .. tool)
      end
    end
  else
    vim.print("Installer " .. installer .. " not found, skipping install of "
      .. table.concat(tool_list, ", "))
  end
end
