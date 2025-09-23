-- Only enable ruff if the executable exists.  I'll need to generalise this if I
-- do it for more linters.
local make_linters_by_ft = function()
  local linters = {
    -- keep-sorted start
    awk = { "awk" },
    go = { "golangcilint" },
    javascript = { "eslint" },
    lua = { "luacheck" },
    markdown = { "markdownlint" },
    php = { "phpstan" },
    rust = { "clippy" },
    sh = { "shellcheck" },
    vim = { "vint" },
    -- keep-sorted end
  }
  if vim.fn.executable("ruff") == 1 then
    linters["python"] = { "ruff" }
  end
  return linters
end

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
      linters_by_ft = make_linters_by_ft(),
    }
  }
}
