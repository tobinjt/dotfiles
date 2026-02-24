local make_linters_by_ft = function()
  local potential_linters = {
    -- keep-sorted start
    awk = { "awk" },
    go = { "golangcilint" },
    javascript = { "eslint" },
    json = { "jsonlint" },
    lua = { "luacheck" },
    markdown = { "markdownlint" },
    php = { "phpstan" },
    python = { "ruff" },
    rust = { "clippy" },
    sh = { "shellcheck" },
    -- keep-sorted end
  }

  local linters = {}
  for ft, linter_list in pairs(potential_linters) do
    local enabled = {}
    for _, linter in ipairs(linter_list) do
      if vim.fn.executable(linter) == 1 then
        table.insert(enabled, linter)
      end
    end
    if #enabled > 0 then
      linters[ft] = enabled
    else
      linters[ft] = { "no_op" }
    end
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

      lint.linters.no_op = {
        name = 'no_op',
        cmd = 'true',
        append_fname = true,
        -- Thre won't be anything to parse but this is required, so use a simple
        -- built-in parser.
        parser = require("lint.parser").from_errorformat("%f:%l: %m", {}),
      }

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
