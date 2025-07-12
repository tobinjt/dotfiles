-- Remap £ to # in all modes.
vim.keymap.set({ "c", "i", "l", "o", "v" }, "£", "#", { noremap = true })
vim.keymap.set("c", "cwindow", "botright cwindow", { noremap = true })
vim.keymap.set("c", "copen", "botright copen", { noremap = true })

-- Remap ^W-F to open the file under the cursor in a vertical split.
vim.keymap.set("n", "<C-W>F", "<C-W>vgF", { noremap = true })

-- Define custom command Vhelp to open help in a vertical split.
vim.api.nvim_create_user_command(
  "Vhelp",
  "vertical help <args>",
  { nargs = 1, complete = "help" })
