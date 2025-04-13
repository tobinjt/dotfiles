-- Install the tools I use.
-- Map of "install tool" => "list of tools to install", so I only try to install
-- tools where the install tool exists.
local tools = {
  -- keep-sorted start block=yes
  -- Use an install tool that always exists, because I want a noisy error if I
  -- can't install these tools.
  cat = {
    -- keep-sorted start
    "bash-debug-adapter",
    "lua-language-server",
    "vint",
    -- keep-sorted end
  },
  luarocks = {
    "luacheck",
  },
  mpm = {
    -- keep-sorted start
    "bash-language-server",
    "jsonlint",
    "markdownlint",
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
    "python-lsp-server",
    "ruff",
    -- keep-sorted end
  },
  rustc = {
    "codelldb",
  }
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
  end
end
