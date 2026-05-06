return {
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
  },
  {
    'aca/emmet-ls',
    ft = { 'html', 'css', 'typescriptreact', 'javascriptreact' },
  },
  {
    'j-hui/fidget.nvim',
    opts = {},
  },
  "b0o/schemastore.nvim",
}
