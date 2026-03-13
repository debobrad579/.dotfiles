require('nvim-treesitter').setup {
  ensure_installed = { 'lua', 'javascript', 'typescript', 'tsx', 'html', 'css', 'python', 'go' },
  auto_install = true,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
}
