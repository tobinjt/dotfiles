return {
  {
    -- Automatically sets up LSP, so lsp.lua doesn't include rust.
    -- Makes debugging work seamlessly.
    "mrcjkb/rustaceanvim",
    version = '^5', -- Recommended by module.
    ft = "rust",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
  },
}
