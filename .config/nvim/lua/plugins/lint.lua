local tools = require("johntobin.tools")

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

      -- Remove disabled linters.
      for ft, disabled in pairs(opts.disabled_linters_by_ft) do
        lint.linters_by_ft[ft] = vim.tbl_filter(function(linter)
          return not vim.tbl_contains(disabled, linter)
        end, lint.linters_by_ft[ft])
      end

      -- Ensure that no_op is used for filetypes that don't have any linters.
      for ft, linters in pairs(lint.linters_by_ft) do
        if #linters == 0 then
          lint.linters_by_ft[ft] = { "no_op" }
        end
      end

      -- When modifying this remember to modify .pre-commit-config.yaml too.
      lint.linters.luacheck.args = {
        "--globals",
        "vim",
        "--std",
        "+lua51",
        "--std",
        -- Might not be needed, based on `luacheck --help`?
        "+busted",
        table.unpack(lint.linters.luacheck.args),
      }

      lint.linters.no_op = {
        name = 'no_op',
        cmd = 'true',
        append_fname = true,
        -- Thre won't be anything to parse but this is required, so use a simple
        -- built-in parser.
        parser = require("lint.parser").from_errorformat("%f:%l: %m", {}),
      }

      -- Wrap the zizmor linter so that it only triggers for specific files.
      local orig_zizmor = lint.linters.zizmor
      lint.linters.zizmor = function()
        local fname = vim.api.nvim_buf_get_name(0)
        if fname:match("%.github/workflows/") then
          ---@diagnostic disable-next-line: return-type-mismatch
          return orig_zizmor
        end
        if fname:match("/bin/python/.*.yml") then
          ---@diagnostic disable-next-line: return-type-mismatch
          return orig_zizmor
        end
        ---@diagnostic disable-next-line: return-type-mismatch
        return lint.linters.no_op
      end

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
      linters_by_ft = tools.make_linters_by_ft(),
      disabled_linters_by_ft = {},
    }
  }
}
