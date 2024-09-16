return {
  {
    "mfussenegger/nvim-lint",
    config = function(_, _)
      local lint = require("lint")
      lint.linters_by_ft = {
        -- keep-sorted start
        awk = { "awk" },
        go = { "golangcilint" },
        javascript = { "eslint" },
        lua = { "luacheck" },
        markdown = { "markdownlint" },
        php = { "phpstan" },
        python = { "ruff", "mypy" },
        rust = { "clippy" },
        sh = { "shellcheck" },
        vim = { "vint" },
        -- keep-sorted end
      }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          -- try_lint without arguments runs the linters defined in `linters_by_ft`
          -- for the current filetype
          require("lint").try_lint()
        end,
      })
    end
  }
}
