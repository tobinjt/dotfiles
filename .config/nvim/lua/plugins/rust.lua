return {
  {
    -- Automatically sets up LSP, so lsp.lua doesn't include rust.
    -- Makes debugging work seamlessly.
    "mrcjkb/rustaceanvim",
    version = '^5', -- Recommended by module.
    lazy = false,
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
}
