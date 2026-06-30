-- Format comments with internal formatting, use LSP for everything else.
local function is_cursor_in_comment_treesitter()
  -- Fetch the standard highlight query for this filetype
  local query = vim.treesitter.query.get(vim.bo.filetype, "highlights")
  if not query then
    vim.notify("vim.treesitter.query.get failed", vim.log.levels.DEBUG)
    return false
  end
  local parser = vim.treesitter.get_parser()
  if parser == nil then
    vim.notify("vim.treesitter.get_parser failed", vim.log.levels.DEBUG)
    return
  end

  local root = parser:parse()[1]:root()
  local buf = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  -- The row positioning is weird: this *looks* like it's checking two rows, but
  -- it's not.
  local row = cursor[1] - 1
  for id, _ in query:iter_captures(root, buf, row, row + 1) do
    if query.captures[id]:lower():match("comment") then
      vim.notify("this is a comment", vim.log.levels.DEBUG)
      return true
    end
  end
  vim.notify("this is NOT a comment", vim.log.levels.DEBUG)
  return false
end

local function smart_comment_format_syntax()
  local line = vim.fn.line('.')
  -- The first character in the line is often not a comment, so check the last
  -- character. The number returned is past the end of the line, so subtract 1
  -- otherwise no syntax will be found.
  local col = vim.fn.col('$') - 1
  local syntax_id = vim.fn.synID(line, col, 1)
  -- Get the name of the syntax group (e.g., "vimComment", "luaComment")
  local syntax_name = vim.fn.synIDattr(syntax_id, 'name'):lower()

  if syntax_name:find("comment") then
    -- Return 1 to tell Neovim to use internal formatting.
    return 1
  else
    return vim.lsp.formatexpr()
  end
end

local function smart_comment_format_treesitter()
  if is_cursor_in_comment_treesitter() then
    -- Return 1 to tell Neovim to use internal formatting.
    return 1
  end
  -- Fall back to LSP formatting
  return vim.lsp.formatexpr()
end

local function smart_comment_format()
  if vim.treesitter.get_node() then
    return smart_comment_format_treesitter()
  else
    return smart_comment_format_syntax()
  end
end


-- Apply this to buffers when LSP attaches
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.bo[args.buf].formatexpr = "v:lua.smart_comment_format()"
  end,
})

-- Make the function globally accessible to the expression
_G.smart_comment_format = smart_comment_format
