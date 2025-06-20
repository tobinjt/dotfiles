-- Configure keymaps here.  :help copilot-maps
vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

local paths = require("paths")

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
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
    -- Only enable Copilot on machines I've logged into Copilot from.
    -- Prefer Avante and Gemini if available.
    cond = paths.exists(paths.copilot_config)
        and not paths.exists(paths.gemini_api_key),
  },
}
