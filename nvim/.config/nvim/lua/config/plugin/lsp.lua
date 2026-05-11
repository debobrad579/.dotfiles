return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufmap = function(mode, lhs, rhs, desc)
						vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc })
					end
					bufmap("n", "gd", vim.lsp.buf.definition, "Go to definition")
					bufmap("n", "<leader>d", vim.lsp.buf.hover, "Hover documentation")
					bufmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
					bufmap("n", "<leader>q", vim.diagnostic.setloclist, "Open diagnostic list")
					bufmap("n", "<leader>e", vim.diagnostic.open_float, "Open diagnostic float")
					bufmap("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
				end,
			})

			local servers = {
				ts_ls = {
					capabilities = capabilities,
					settings = {
						typescript = {
							preferences = {
								preferTypeOnlyAutoImports = true,
							},
						},
					},
				},
				eslint = {
					capabilities = capabilities,
				},
				lua_ls = {
					capabilities = capabilities,
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
							runtime = { version = "LuaJIT" },
							workspace = { library = vim.api.nvim_get_runtime_file("", true) },
							telemetry = { enable = false },
						},
					},
				},
				pyright = {
					capabilities = capabilities,
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
				gopls = {
					capabilities = capabilities,
				},
				html = {
					capabilities = capabilities,
				},
				cssls = {
					capabilities = capabilities,
				},
				sqls = {
					capabilities = capabilities,
				},
				clangd = {
					capabilities = capabilities,
				},
				ocamllsp = {
					capabilities = capabilities,
				},
				jsonls = {
					capabilities = capabilities,
					settings = {
						json = {
							validate = { enable = true },
							schemas = require("schemastore").json.schemas(),
						},
					},
				},
				astro = {
					capabilities = capabilities,
					init_options = {
						typescript = {
							tsdk = "/usr/lib/node_modules/typescript/lib",
						},
					},
				},
				rust_analyzer = {
					capabilities = capabilities,
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

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if client and client.name == "ts_ls" then
						client.server_capabilities.documentFormattingProvider = false
					end
				end,
			})

			for server, config in pairs(servers) do
				vim.lsp.config(server, config)
				vim.lsp.enable(server)
			end
		end,
	},
	{
		"j-hui/fidget.nvim",
		opts = {},
	},
	"b0o/schemastore.nvim",
}
