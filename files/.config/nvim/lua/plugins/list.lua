return {
	'wbthomason/packer.nvim',
	{ "nvim-lua/plenary.nvim", module = "plenary" },
	'lewis6991/impatient.nvim',
	'tpope/vim-sleuth',
	{ "NvChad/extensions", module = { "telescope", "nvchad" } },
	{ "NvChad/base46",
		config = function()
			require('base46').load_theme()
		end,
	},
	{ "NvChad/ui",
		after = "base46",
		config = function()
			require('nvchad_ui').setup()
		end,
	},
	{ "NvChad/nvterm",
		module = "nvterm",
		config = function()
			require "base46.term"
			require('nvterm').setup({
				terminals = {
					list = {},
					type_opts = {
						float = {
							relative = "editor",
							row = 0.3,
							col = 0.25,
							width = 0.5,
							height = 0.4,
							border = "single",
						},
						horizontal = { location = "rightbelow", split_ratio = 0.3 },
						vertical = { location = "rightbelow", split_ratio = 0.5 },
					},
				},
				behavior = {
					close_on_exit = true,
					auto_insert = true,
				},
				enable_new_mappings = true,

			})
		end,
		setup = function()
			require("core.utils").load_mappings "nvterm"
		end,
	},
	{ "nvim-tree/nvim-web-devicons",
		after = "ui",
		module = "nvim-web-devicons",
		config = function()
			require("base46").load_highlight "devicons"
			require('nvim-web-devicons').setup({
				override = require("nvchad_ui.icons").devicons
			})
		end,
	},
	{ "lukas-reineke/indent-blankline.nvim",
		opt = true,
		setup = function()
			require("core.lazy_load").on_file_open "indent-blankline.nvim"
			require("core.utils").load_mappings "blankline"
		end,
		config = function()
			require("base46").load_highlight "blankline"
			require('indent_blankline').setup({
				indentLine_enabled = 1,
				filetype_exclude = {
					"help",
					"terminal",
					"alpha",
					"packer",
					"lspinfo",
					"TelescopePrompt",
					"TelescopeResults",
					"mason",
					"",
				},
				buftype_exclude = { "terminal" },
				show_trailing_blankline_indent = false,
				show_first_indent_level = false,
				show_current_context = true,
				show_current_context_start = true,
			})
		end,
	},

	{ "NvChad/nvim-colorizer.lua",
		opt = true,
		setup = function()
			require("core.lazy_load").on_file_open "nvim-colorizer.lua"
		end,
		config = function()
			local colorizer = require('colorizer')
			local options = {
				filetypes = {
					"*",
				},
				user_default_options = {
					RGB = true, -- #RGB hex codes
					RRGGBB = true, -- #RRGGBB hex codes
					names = false, -- "Name" codes like Blue
					RRGGBBAA = false, -- #RRGGBBAA hex codes
					rgb_fn = false, -- CSS rgb() and rgba() functions
					hsl_fn = false, -- CSS hsl() and hsla() functions
					css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
					css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
					mode = "background", -- Set the display mode.
				},
			}

			colorizer.setup(options)
			-- execute colorizer as soon as possible
			vim.defer_fn(function()
				require("colorizer").attach_to_buffer(0)
			end, 0)

		end,
	},

	{ "nvim-treesitter/nvim-treesitter",
		module = "nvim-treesitter",
		setup = function()
			require("core.lazy_load").on_file_open "nvim-treesitter"
		end,
		cmd = require("core.lazy_load").treesitter_cmds,
		run = ":TSUpdate",
		config = function()
			require("base46").load_highlight "treesitter"
			require('nvim-treesitter.configs').setup({
				ensure_installed = {
					"lua",
				},
				highlight = {
					enable = true,
					use_languagetree = true,
				},
				indent = {
					enable = true,
				},
			})
		end,
	},

	-- git stuff
	{ "lewis6991/gitsigns.nvim",
		ft = "gitcommit",
		setup = function()
			require("core.lazy_load").gitsigns()
		end,
		config = function()
			local gitsigns = require('gitsigns')
			require("base46").load_highlight "git"

			local options = {
				signs = {
					add = { hl = "DiffAdd", text = "│", numhl = "GitSignsAddNr" },
					change = { hl = "DiffChange", text = "│", numhl = "GitSignsChangeNr" },
					delete = { hl = "DiffDelete", text = "", numhl = "GitSignsDeleteNr" },
					topdelete = { hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr" },
					changedelete = { hl = "DiffChangeDelete", text = "~", numhl = "GitSignsChangeNr" },
				},
				on_attach = function (bufnr)
					require('core.utils').load_mappings("gitsigns", { buffer = bufnr })
				end
			}

			gitsigns.setup(options)

		end,
	},

	-- lsp stuff
	{ "williamboman/mason.nvim",
		cmd = require("core.lazy_load").mason_cmds,
		config = function()
			local mason = require('mason')
			vim.api.nvim_create_augroup("_mason", { clear = true })
			vim.api.nvim_create_autocmd("Filetype", {
				pattern = "mason",
				callback = function()
					require("base46").load_highlight "mason"
				end,
				group = "_mason",
			})

			local options = {
				ensure_installed = { "lua-language-server" }, -- not an option from mason.nvim
				ui = {
					icons = {
						package_pending = " ",
						package_installed = " ",
						package_uninstalled = " ﮊ",
					},

					keymaps = {
						toggle_server_expand = "<CR>",
						install_server = "i",
						update_server = "u",
						check_server_version = "c",
						update_all_servers = "U",
						check_outdated_servers = "C",
						uninstall_server = "X",
						cancel_installation = "<C-c>",
					},
				},

				max_concurrent_installers = 10,
			}

			vim.api.nvim_create_user_command("MasonInstallAll", function()
				vim.cmd("MasonInstall " .. table.concat(options.ensure_installed, " "))
			end, {})

			mason.setup(options)
		end,
	},

	{ "neovim/nvim-lspconfig",
		opt = true,
		setup = function()
			require("core.lazy_load").on_file_open "nvim-lspconfig"
		end,
		config = function()
			local lspconfig = require('lspconfig')
			require("base46").load_highlight "lsp"
			require "nvchad_ui.lsp"

			local M = {}
			local utils = require "core.utils"


			M.on_attach = function(client, bufnr)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false

				utils.load_mappings("lspconfig", { buffer = bufnr })

				if client.server_capabilities.signatureHelpProvider then
					require("nvchad_ui.signature").setup(client)
				end
			end

			M.capabilities = vim.lsp.protocol.make_client_capabilities()

			M.capabilities.textDocument.completion.completionItem = {
				documentationFormat = { "markdown", "plaintext" },
				snippetSupport = true,
				preselectSupport = true,
				insertReplaceSupport = true,
				labelDetailsSupport = true,
				deprecatedSupport = true,
				commitCharactersSupport = true,
				tagSupport = { valueSet = { 1 } },
				resolveSupport = {
					properties = {
						"documentation",
						"detail",
						"additionalTextEdits",
					},
				},
			}

			lspconfig.lua_ls.setup {
				on_attach = M.on_attach,
				capabilities = M.capabilities,

				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = {
								[vim.fn.expand "$VIMRUNTIME/lua"] = true,
								[vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
							},
							maxPreload = 100000,
							preloadFileSize = 10000,
						},
					},
				},
			}

			return M
		end,
	},

	{ "rafamadriz/friendly-snippets",
		module = { "cmp", "cmp_nvim_lsp" },
		event = "InsertEnter",
	},

	{ "hrsh7th/nvim-cmp",
		after = "friendly-snippets",
		config = function()
			require("base46").load_highlight "cmp"

			vim.o.completeopt = "menu,menuone,noselect"

			local function border(hl_name)
				return {
					{ "╭", hl_name },
					{ "─", hl_name },
					{ "╮", hl_name },
					{ "│", hl_name },
					{ "╯", hl_name },
					{ "─", hl_name },
					{ "╰", hl_name },
					{ "│", hl_name },
				}
			end

			local cmp_window = require "cmp.utils.window"
			cmp_window.info_ = cmp_window.info
			cmp_window.info = function(self)
				local info = self:info_()
				info.scrollable = false
				return info
			end

			local cmp = require('cmp')
			cmp.setup({
				window = {
					completion = {
						border = border "CmpBorder",
						winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
					},
					documentation = {
						border = border "CmpDocBorder",
					},
				},
				formatting = {
					format = function(_, vim_item)
						local icons = require("nvchad_ui.icons").lspkind
						vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
						return vim_item
					end,
				},
				mapping = {
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm {
						behavior = cmp.ConfirmBehavior.Replace,
						select = false,
					},
					["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
						else
							fallback()
						end
						end, {
							"i",
							"s",
					}),
					["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
						else
							fallback()
						end
						end, {
							"i",
							"s",
					}),
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "nvim_lua" },
					{ name = "path" },
				},

			})
		end,
	},

	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer", after = "cmp-nvim-lsp" },
	{ "hrsh7th/cmp-path", after = "cmp-buffer" },

	-- misc plugins
	{ "windwp/nvim-autopairs",
		after = "nvim-cmp",
		config = function()
			local autopairs = require('nvim-autopairs')
			local cmp = require('cmp')
			local options = {
				fast_wrap = {},
				disable_filetype = { "TelescopePrompt", "vim" },
			}
			autopairs.setup(options)
			local cmp_autopairs = require "nvim-autopairs.completion.cmp"
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

		end,
	},

	{ "goolord/alpha-nvim",
		after = "base46",
		config = function()
			local alpha = require('alpha')
			require("base46").load_highlight "alpha"

			local function button(sc, txt, keybind)
				local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

				local opts = {
					position = "center",
					text = txt,
					shortcut = sc,
					cursor = 5,
					width = 36,
					align_shortcut = "right",
					hl = "AlphaButtons",
				}

				if keybind then
					opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
				end

				return {
					type = "button",
					val = txt,
					on_press = function()
						local key = vim.api.nvim_replace_termcodes(sc_, true, false, true) or ""
						vim.api.nvim_feedkeys(key, "normal", false)
					end,
					opts = opts,
				}
			end

			-- dynamic header padding
			local fn = vim.fn
			local marginTopPercent = 0.3
			local headerPadding = fn.max { 2, fn.floor(fn.winheight(0) * marginTopPercent) }

			local options = {

				header = {
					type = "text",
					val = {
						"   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
						"    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
						"          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
						"           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
						"          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
						"   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
						"  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
						" ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
						" ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
						"      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
						"       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
					},
					opts = {
						position = "center",
						hl = "AlphaHeader",
					},
				},

				buttons = {
					type = "group",
					val = {
						button("SPC f f", "  Find File  ", ":Telescope find_files<CR>"),
						button("SPC f o", "  Recent File  ", ":Telescope oldfiles<CR>"),
						button("SPC f w", "  Find Word  ", ":Telescope live_grep<CR>"),
						button("SPC b m", "  Bookmarks  ", ":Telescope marks<CR>"),
						button("SPC t h", "  Themes  ", ":Telescope themes<CR>"),
						button("SPC e s", "  Settings", ":e $MYVIMRC | :cd %:p:h <CR>"),
					},
					opts = {
						spacing = 1,
					},
				},

				headerPaddingTop = { type = "padding", val = headerPadding },
				headerPaddingBottom = { type = "padding", val = 2 },
			}

			alpha.setup {
				layout = {
					options.headerPaddingTop,
					options.header,
					options.headerPaddingBottom,
					options.buttons,
				},
				opts = {},
			}
		end,
	},

	{ "numToStr/Comment.nvim",
		module = "Comment",
		keys = { "gc", "gb" },
		config = function()
			require('Comment').setup({})
		end,
		setup = function()
			require("core.utils").load_mappings "comment"
		end,
	},

	-- file managing , picker etc
	{ "nvim-tree/nvim-tree.lua",
		ft = "alpha",
		cmd = { "NvimTreeToggle", "NvimTreeFocus" },
		config = function()
			local nvimtree = require('nvim-tree')
			require("base46").load_highlight "nvimtree"

			local options = {
				filters = {
					dotfiles = false,
					exclude = { vim.fn.stdpath "config" .. "/lua/custom" },
				},
				disable_netrw = true,
				hijack_netrw = true,
				hijack_cursor = true,
				hijack_unnamed_buffer_when_opening = false,
				update_cwd = true,
				update_focused_file = {
					enable = true,
					update_cwd = false,
				},
				view = {
					adaptive_size = true,
					side = "left",
					width = 25,
					hide_root_folder = true,
				},
				git = {
					enable = false,
					ignore = true,
				},
				filesystem_watchers = {
					enable = true,
				},
				actions = {
					open_file = {
						resize_window = true,
					},
				},
				renderer = {
					highlight_git = false,
					highlight_opened_files = "none",

					indent_markers = {
						enable = false,
					},

					icons = {
						show = {
							file = true,
							folder = true,
							folder_arrow = true,
							git = false,
						},

						glyphs = {
							default = "",
							symlink = "",
							folder = {
								default = "",
								empty = "",
								empty_open = "",
								open = "",
								symlink = "",
								symlink_open = "",
								arrow_open = "",
								arrow_closed = "",
							},
							git = {
								unstaged = "✗",
								staged = "✓",
								unmerged = "",
								renamed = "➜",
								untracked = "★",
								deleted = "",
								ignored = "◌",
							},
						},
					},
				},
			}

			vim.g.nvimtree_side = options.view.side

			nvimtree.setup(options)
		end,
		setup = function()
			require("core.utils").load_mappings "nvimtree"
		end,
	},

	{ "nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		config = function()
			local telescope = require('telescope')
			vim.g.theme_switcher_loaded = true

			require("base46").load_highlight "telescope"

			local options = {
				defaults = {
					vimgrep_arguments = {
						"rg",
						"-L",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
					},
					prompt_prefix = "   ",
					selection_caret = "  ",
					entry_prefix = "  ",
					initial_mode = "insert",
					selection_strategy = "reset",
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
							results_width = 0.8,
						},
						vertical = {
							mirror = false,
						},
						width = 0.87,
						height = 0.80,
						preview_cutoff = 120,
					},
					file_sorter = require("telescope.sorters").get_fuzzy_file,
					file_ignore_patterns = { "node_modules" },
					generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
					path_display = { "truncate" },
					winblend = 0,
					border = {},
					borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					color_devicons = true,
					set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
					file_previewer = require("telescope.previewers").vim_buffer_cat.new,
					grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
					qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
					-- Developer configurations: Not meant for general override
					buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
					mappings = {
						n = { ["q"] = require("telescope.actions").close },
					},
				},

				extensions_list = { "themes", "terms" },
			}

			telescope.setup(options)

			-- load extensions
			pcall(function()
				for _, ext in ipairs(options.extensions_list) do
					telescope.load_extension(ext)
				end
			end)
		end,
		setup = function()
			require("core.utils").load_mappings "telescope"
		end,
	},

	-- Only load whichkey after all the gui
	{ "folke/which-key.nvim",
		module = "which-key",
		keys = { "<leader>", '"', "'", "`" },
		config = function()
			local whichkey = require('whichkey')
			require("base46").load_highlight "whichkey"

			local options = {

				icons = {
					breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
					separator = "  ", -- symbol used between a key and it's label
					group = "+", -- symbol prepended to a group
				},

				popup_mappings = {
					scroll_down = "<c-d>", -- binding to scroll down inside the popup
					scroll_up = "<c-u>", -- binding to scroll up inside the popup
				},

				window = {
					border = "none", -- none/single/double/shadow
				},

				layout = {
					spacing = 6, -- spacing between columns
				},

				hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },

				triggers_blacklist = {
					-- list of mode / prefixes that should never be hooked by WhichKey
					i = { "j", "k" },
					v = { "j", "k" },
				},
			}

			wk.setup(options)
		end,
		setup = function()
			require("core.utils").load_mappings "whichkey"
		end,
	},
}
