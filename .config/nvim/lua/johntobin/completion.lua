-- 1. Define the "Smart Tab" logic
local function smart_buffer_complete()
  local col = vim.fn.col('.') - 1
  local line = vim.fn.getline('.')

  -- Check if at start of line or if the character before cursor is whitespace
  if col == 0 or line:sub(col, col):match('%s') then
    -- Insert a real Tab character (or spaces, honoring 'expandtab')
    return vim.api.nvim_replace_termcodes('<Tab>', true, true, true)
  else
    -- Trigger Buffer Word Completion (Generic Keyword)
    return vim.api.nvim_replace_termcodes('<C-n>', true, true, true)
  end
end

-- 2. Map <Tab> to the smart function
vim.keymap.set('i', '<Tab>', smart_buffer_complete, { expr = true })

-- 3. Map <S-Tab> (Shift+Tab) to LSP Completion
-- <C-x><C-o> is the native key for "Omni completion" (LSP)
vim.keymap.set('i', '<S-Tab>', '<C-x><C-o>')

-- Configure completion options for a better UI experience
vim.opt.completeopt = {
  -- TODO: I haven't tested fuzzy much.
  'fuzzy',    -- enable fuzzy-matching for better matching experience.
  'longest',  -- auto-insert the longest common prefix of matches.
  'menu',     -- display a completion menu.
  'menuone',  -- display the menu even when there is only one match.
  'noselect', -- do not automatically select the first item
  'preview',  -- show extra info about the currently selected match.
}
