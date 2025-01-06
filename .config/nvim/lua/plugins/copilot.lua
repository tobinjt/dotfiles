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
    cond = vim.fn.filereadable(vim.fn.expand('~/.config/github-copilot/apps.json')) == 1,
    -- Only load Copilot when I try to use it.
    cmd = {
      "CopilotChat",
    },
  },
}
