return {
  {
    "rgroli/other.nvim",
    main = "other-nvim",
    cmd = {
      "Other",
      "OtherSplit",
      "OtherVSplit",
    },
    keys = {
      {
        "<leader>rf",
        "<cmd>OtherVSplit<cr>",
        desc = "Open other.nvim for vertical split",
      },
    },
    opts = {
      mappings = {
        "golang",
        "rust",
        -- TODO: generalise this, maybe with a transformer?
        {
          context = "Python go to source file",
          pattern = "(.*)_test.py$",
          target = "%1.py",
        },
        {
          context = "Python go to test file",
          pattern = function(filename)
            -- If filename is a test file, return nil so this rule is skipped.
            local test_match = vim.fn.matchlist(filename, "\\v.*_test.py$")
            if #test_match > 0 then
              return nil
            end

            -- Is this a non-test Python file?
            local match = vim.fn.matchlist(filename, "\\v(.*).py$")
            if #match > 0 then
              -- The first element is the full matching string, and subsequent
              -- elements are the captured groups, so remove the first element.
              table.remove(match, 1)
              return match
            end

            -- No match.
            return nil
          end,
          target = "%1_test.py",
        },
        {
          context = "CPP go to source file",
          pattern = "(.*)_test.cc$",
          target = "%1.cc",
        },
        {
          context = "CPP go to test file",
          pattern = function(filename)
            -- If filename is a test file, return nil so this rule is skipped.
            local test_match = vim.fn.matchlist(filename, "\\v.*_test.cc$")
            if #test_match > 0 then
              return nil
            end

            -- Is this a non-test CPP file?
            local match = vim.fn.matchlist(filename, "\\v(.*).cc$")
            if #match > 0 then
              -- The first element is the full matching string, and subsequent
              -- elements are the captured groups, so remove the first element.
              table.remove(match, 1)
              return match
            end

            -- No match.
            return nil
          end,
          target = "%1_test.cc",
        },
      },
    },
  },
}
