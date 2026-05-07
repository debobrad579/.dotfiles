return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		branch = "main",
		config = function()
			local parsers = {
				"javascript",
				"typescript",
				"tsx",
				"html",
				"css",
				"go",
				"rust",
				"c",
				"lua",
				"python",
				"ocaml",
				"bash",
				"diff",
				"sql",
				"dockerfile",
				"make",
				"json",
				"yaml",
				"toml",
				"vim",
				"vimdoc",
				"tmux",
				"markdown",
				"markdown_inline",
				"query",
			}
			require("nvim-treesitter").install(parsers)

			local available_parsers = require("nvim-treesitter").get_available()

			local function treesitter_try_attach(buf, language)
				if not vim.treesitter.language.add(language) then
					return
				end
				vim.treesitter.start(buf, language)
				local has_indent_query = vim.treesitter.query.get(language, "indents") ~= nil
				if has_indent_query then
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					local buf, filetype = args.buf, args.match
					local language = vim.treesitter.language.get_lang(filetype)
					if not language then
						return
					end
					local installed_parsers = require("nvim-treesitter").get_installed("parsers")
					if vim.tbl_contains(installed_parsers, language) then
						treesitter_try_attach(buf, language)
					elseif vim.tbl_contains(available_parsers, language) then
						require("nvim-treesitter").install(language):await(function()
							treesitter_try_attach(buf, language)
						end)
					else
						treesitter_try_attach(buf, language)
					end
				end,
			})
		end,
	},
}
