local paths = require("johntobin.paths")

return {
  "milanglacier/minuet-ai.nvim",
  cond = paths.exists(paths.gemini_api_key_path),
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  opts = {
    -- :help minuet-ai.nvim-gemini - gemini-2.0-flash, the default, is
    -- recommended over gemini-2.5-flash for better speed but comparable
    -- results.
    provider = "gemini",
    -- minuet-ai.nvim-virtual-text - the defaults do nothing.
    virtualtext = {
      auto_trigger_ft = {
        "lua",
        "python",
      },
      -- <A-A> is Option-A, <A-a> is Option-a.
      -- TODO: should I change the keymappings?
      keymap = {
        -- accept whole completion
        accept = "<A-A>",
        -- accept one line
        accept_line = "<A-a>",
        -- accept n lines (prompts for number)
        -- e.g. "A-z 2 CR" will accept 2 lines
        accept_n_lines = "<A-z>",
        -- Cycle to prev completion item, or manually invoke completion
        prev = "<A-[>",
        -- Cycle to next completion item, or manually invoke completion
        next = "<A-]>",
        dismiss = "<A-e>",
      },
    },
  },
}
