local onedark = require('onedark')
onedark.setup {
  style = 'dark',
}
onedark.load()

vim.api.nvim_set_hl(0, 'htmlTagName', { fg = '#e06c75' })
vim.api.nvim_set_hl(0, 'htmlTag', { fg = '#abb2bf' })
