-- Install the tools I use.
-- Map of "install tool" => "list of tools to install", so I only try to install
-- tools where the install tool exists.
local tools = {
  -- Use an install tool that always exists, because I want a noisy error if I
  -- can't install these tools.
  cat = {
    -- keep-sorted start
    "lua-language-server",
    "ruff",
    "vint",
    -- keep-sorted end
  },
  mpm = {
    -- keep-sorted start
    "bash-language-server",
    "jsonlint",
    "markdownlint",
    "vim-language-server",
    -- keep-sorted end
  },
}

local mason_registry = require("mason-registry")
for installer, tool_list in ipairs(tools) do
  if vim.fn.executable(installer) == 1 then
    for tool in tool_list do
      if vim.fn.executable(tool) == 0 and not mason_registry.is_installed(tool) then
        vim.cmd(":MasonInstall " .. tool)
      end
    end
  end
end
