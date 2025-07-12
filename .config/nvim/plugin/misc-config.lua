-- Contains misc config where there isn't enough config to justify a separate
-- file.

-- Assume shell scripts are really using bash, so that we get bash-enhanced
-- syntax.
vim.g.is_bash = 1

-- Run cargo on tests too.
vim.g.rust_cargo_check_tests = 1

-- Fold JavaScript.
vim.g.javaScript_fold = 1
