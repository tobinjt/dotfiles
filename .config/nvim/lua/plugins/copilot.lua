local paths = require("johntobin.paths")
-- Don't remap tab.
vim.g.copilot_no_tab_map = true

return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      "github/copilot.vim",      -- or zbirenbaum/copilot.lua
      {
        "nvim-lua/plenary.nvim", -- for curl, log and async functions
        branch = "master",
      },
    },
    lazy = false,
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
    },
    keys = {
      -- :help copilot-maps
      {
        "<C-J>",
        'copilot#Accept("\\<CR>")',
        mode = "i",
        desc = "accept Copilot suggestion",
        expr = true,
        replace_keycodes = false,
      },
    },
    -- Only enable Copilot on machines I've logged into Copilot from.
    -- Prefer Avante and Gemini if available.
    cond = paths.exists(paths.copilot_config)
        and not paths.exists(paths.gemini_api_key),
  },
}
