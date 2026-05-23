-- Delete without clobbering the unnamed register/clipboard.
vim.keymap.set("n", "d", '"_d')
vim.keymap.set("n", "dd", '"_dd')
vim.keymap.set("n", "D", '"_D')
vim.keymap.set("x", "d", '"_d')
