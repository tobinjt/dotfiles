return {
  {
    "mfussenegger/nvim-lint",

    config = function(_, opts)
      local lint = require("lint")
      -- Overwrite existing linters if there's a clash, otherwise keep them.
      lint.linters_by_ft = vim.tbl_extend(
        "force",
        lint.linters_by_ft,
        opts.linters_by_ft)

      -- Run lint after every write.
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          -- try_lint without arguments runs the linters defined in
          -- `linters_by_ft` for the current filetype.
          require("lint").try_lint()
        end,
      })
    end,

    opts = {
      linters_by_ft = {
        -- keep-sorted start
        awk = { "awk" },
        go = { "golangcilint" },
        javascript = { "eslint" },
        lua = { "luacheck" },
        markdown = { "markdownlint" },
        php = { "phpstan" },
        python = { "ruff" },
        rust = { "clippy" },
        sh = { "shellcheck" },
        vim = { "vint" },
        -- keep-sorted end
      },
    }
  }
}
