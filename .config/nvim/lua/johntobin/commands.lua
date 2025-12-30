local toggle_inlay_hints = function()
  local bufnr = vim.api.nvim_get_current_buf()

  -- Check if any attached LSP client supports inlay hints
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  local supports_inlay = false
  for _, client in ipairs(clients) do
    if client:supports_method("textDocument/signatureHelp") then
      supports_inlay = true
      break
    end
  end
  if not supports_inlay then
    vim.notify("No LSP client attached to this buffer supports inlay hints.",
      vim.log.levels.WARN)
    return
  end

  -- Toggle inlay hints for the current buffer
  local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
  vim.lsp.inlay_hint.enable(not is_enabled, { bufnr = bufnr })
  vim.notify("Inlay hints " .. (is_enabled and "disabled" or "enabled"),
    vim.log.levels.INFO)
end

vim.api.nvim_create_user_command('ToggleInlayHints', toggle_inlay_hints,
  { desc = "Toggle LSP inlay hints for the current buffer" })
