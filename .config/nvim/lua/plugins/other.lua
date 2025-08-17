--- Returns the filename without the suffix if it is not a test file.
--
-- This function is used to implement custom pattern matchers for the other.nvim
-- plugin. It ensures that the rule only applies to non-test files.
--
-- @param filename (string) The full filename to check.
-- @param suffix (string) The file suffix (e.g., "py", "cc") to look for.
-- @return (table|nil) A table containing the filename without the suffix if it's
--   a non-test file, otherwise nil. The table is what other.nvim expects.
local dont_match_test_files = function(filename, suffix)
  -- If filename is a test file, return nil so this rule is skipped.
  local test_match = vim.fn.matchlist(filename, "\\v.*_test." .. suffix .. "$")
  if #test_match > 0 then
    return nil
  end

  -- Is this a non-test file?
  local match = vim.fn.matchlist(filename, "\\v(.*)." .. suffix .. "$")
  if #match > 0 then
    -- The first element is the full matching string, and subsequent
    -- elements are the captured groups, so remove the first element.
    table.remove(match, 1)
    return match
  end

  -- No match.
  return nil
end

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
      -- CPP has multiple matches for foo.cc: foo.h and foo_test.cc.  Disable
      -- remembering the selection so that we choose each time.
      rememberBuffers = false,

      mappings = {
        "golang",
        "rust",
        -- keep-sorted start block=yes
        {
          context = "CPP go to header file",
          pattern = function(filename)
            return dont_match_test_files(filename, "cc")
          end,
          target = "%1.h",
        },
        {
          context = "CPP go to source file",
          pattern = "(.*).h$",
          target = "%1.cc",
        },
        {
          context = "CPP go to source file",
          pattern = "(.*)_test.cc$",
          target = "%1.cc",
        },
        {
          context = "CPP go to test file",
          pattern = function(filename)
            return dont_match_test_files(filename, "cc")
          end,
          target = "%1_test.cc",
        },
        {
          context = "Python go to source file",
          pattern = "(.*)_test.py$",
          target = "%1.py",
        },
        {
          context = "Python go to test file",
          pattern = function(filename)
            return dont_match_test_files(filename, "py")
          end,
          target = "%1_test.py",
        },
        -- keep-sorted end
      },
    },
  },
}
