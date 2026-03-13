local builtin = require('telescope.builtin')
local telescope = require('telescope')

telescope.load_extension('fzf')
telescope.load_extension('ui-select')

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
