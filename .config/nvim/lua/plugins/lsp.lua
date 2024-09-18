-- Note: some plugin configs also contain LSP config, e.g. lua.lua.
return {
  {
    "neovim/nvim-lspconfig",
    -- Dependencies are not necessary in other configs, setting them once is
    -- enough.
    dependencies = {
      "mason.nvim",
      "mason-lspconfig.nvim",
    },
    -- config() is an empty function because you can't call
    -- require("lspconfig").start(), it's not a function.
    config = function(_, _)
    end,
    -- This doesn't change opts, it runs code with side effects to configure
    -- LSP.  This allows us to separate config for some languages, because
    -- opts is evaluated and merged for every stanza, unlike config where the
    -- last definition wins and the others are overwritten.
    opts = function(_, opts)
      local lspconfig = require("lspconfig")
      -- keep-sorted start
      lspconfig.bashls.setup {}
      lspconfig.gopls.setup {}
      lspconfig.pylsp.setup {}
      lspconfig.ruff.setup {}
      lspconfig.rust_analyzer.setup {}
      lspconfig.vimls.setup {}
      -- keep-sorted end
      return opts
    end
  },
}
