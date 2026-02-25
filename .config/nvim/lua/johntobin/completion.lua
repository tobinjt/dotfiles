-- 1. Define the "Smart Tab" logic
local function smart_buffer_complete()
  -- If the completion menu is ALREADY visible, move to the next item
  if vim.fn.pumvisible() ~= 0 then
    return vim.api.nvim_replace_termcodes('<C-n>', true, true, true)
  end

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

-- 2. Smart Shift+Tab (LSP Complete + Previous Item)
local function smart_shift_tab_complete()
  -- If the completion menu is ALREADY visible, move to the previous item
  if vim.fn.pumvisible() ~= 0 then
    return vim.api.nvim_replace_termcodes('<C-p>', true, true, true)
  end

  -- Trigger LSP Omni Completion
  -- <C-x><C-o> is the native key for "Omni completion" (LSP)
  return vim.api.nvim_replace_termcodes('<C-x><C-o>', true, true, true)
end

-- 2. Map <Tab> to completion or next menu item.
vim.keymap.set('i', '<Tab>', smart_buffer_complete, { expr = true })

-- 3. Map <S-Tab> (Shift+Tab) to LSP Completion or previous menu item.
vim.keymap.set('i', '<S-Tab>', smart_shift_tab_complete, { expr = true })

-- Configure completion options for a better UI experience
vim.opt.completeopt = {
  'longest',  -- auto-insert the longest common prefix of matches.
  'menu',     -- display a completion menu.
  'menuone',  -- display the menu even when there is only one match.
  'noselect', -- do not automatically select the first item
  'preview',  -- show extra info about the currently selected match.
}
