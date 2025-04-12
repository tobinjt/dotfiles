return {
  -- Syntax highlighting and more.
  {
    "nvim-treesitter/nvim-treesitter",
    -- Based on https://www.lazyvim.org/plugins/treesitter#nvim-treesitter
    -- treesitter.setup() doesn't install parsers, instead we need
    -- treesitter.config.setup(opts).
    -- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation#lazynvim
    -- documents all this.

    main = "nvim-treesitter.configs",

    opts = {
      -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
      ensure_installed = {
        -- keep-sorted start
        "awk",
        "bash",
        "css",
        "gitcommit",
        "go",
        "html",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "php",
        "printf",
        "python",
        "regex",
        "rust",
        "vim",
        "vimdoc",
        -- keep-sorted end
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      -- :help nvim-treesitter-incremental-selection-mod
      -- Consider "nvim-treesitter/nvim-treesitter-textobjects" ?
    },
  },
}
