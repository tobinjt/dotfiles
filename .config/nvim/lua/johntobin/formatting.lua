-- Format comments with internal formatting, use LSP for everything else.
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
  -- List of node types to treat as comments
  local comment_types = { "comment", "line_comment", "block_comment" }
  -- Check if current node or its parent is a comment
  local cur = vim.treesitter.get_node()
  while cur do
    if vim.tbl_contains(comment_types, cur:type()) then
      -- Return 1 to tell Neovim to use internal formatting.
      return 1
    end
    cur = cur:parent()
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
