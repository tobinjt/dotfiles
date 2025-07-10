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
        "<cmd>OtherVSplit",
        desc = "Open other.nvim for vertical split",
      },
    },
    opts = {
      mappings = {
        "golang",
        "python",
        "rust",
      },
    },
  },
}
