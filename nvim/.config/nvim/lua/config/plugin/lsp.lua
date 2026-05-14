return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf })
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf })
					vim.keymap.set("n", "grn", vim.lsp.buf.rename, { buffer = args.buf })
					vim.keymap.set("n", "gra", vim.lsp.buf.code_action, { buffer = args.buf })
					vim.keymap.set("n", "grr", vim.lsp.buf.references, { buffer = args.buf })
					vim.keymap.set("n", "gri", vim.lsp.buf.implementation, { buffer = args.buf })
					vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { buffer = args.buf })
					vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { buffer = args.buf })
				end,
			})

			local servers = {
				pyright = {
					settings = {
						python = {
							analysis = {
								autoSearchPaths = true,
								useLibraryCodeForTypes = true,
								diagnosticMode = "workspace",
							},
						},
					},
				},
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
							runtime = { version = "LuaJIT" },
							workspace = { library = vim.api.nvim_get_runtime_file("", true) },
							telemetry = { enable = false },
						},
					},
				},
				ts_ls = {
					on_attach = function(client)
						client.server_capabilities.documentFormattingProvider = false
					end,
					settings = {
						typescript = {
							preferences = {
								preferTypeOnlyAutoImports = true,
							},
						},
					},
				},
				astro = {
					init_options = {
						typescript = {
							tsdk = "/usr/lib/node_modules/typescript/lib",
						},
					},
				},
				jsonls = {
					settings = {
						json = {
							validate = { enable = true },
							schemas = require("schemastore").json.schemas(),
						},
					},
				},
				html = {},
				cssls = {},
				sqls = {},
				clangd = {},
				ocamllsp = {},
				gopls = {},
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true,
							},
							check = {
								command = "clippy",
								extraArgs = {
									"--",
									"-Aclippy::needless_return",
								},
							},
						},
					},
				},
			}

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			for server, config in pairs(servers) do
				config.capabilities = capabilities
				vim.lsp.config(server, config)
				vim.lsp.enable(server)
			end
		end,
	},
	"j-hui/fidget.nvim",
	"b0o/schemastore.nvim",
}
