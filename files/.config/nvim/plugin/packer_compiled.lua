-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/user/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/user/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/user/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/user/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/user/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\nu\0\0\6\0\5\0\r6\0\0\0'\2\1\0B\0\2\0024\1\0\0006\2\2\0\18\4\1\0'\5\3\0B\2\3\2\18\1\2\0009\2\4\0\18\4\1\0B\2\2\1K\0\1\0\nsetup\26numToStr/Comment.nvim\18load_override\fComment\frequire\0" },
    keys = { { "", "gc" }, { "", "gb" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/user/.local/share/nvim/site/pack/packer/opt/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  ["alpha-nvim"] = {
    config = { "\27LJ\2\n�\1\0\0\6\1\6\0\0196\0\0\0009\0\1\0009\0\2\0-\2\0\0+\3\2\0+\4\1\0+\5\2\0B\0\5\2\14\0\0\0X\1\1�'\0\3\0006\1\0\0009\1\1\0019\1\4\1\18\3\0\0'\4\5\0+\5\1\0B\1\4\1K\0\1\0\3�\vnormal\18nvim_feedkeys\5\27nvim_replace_termcodes\bapi\bvim�\2\1\3\b\0\16\0\28\18\5\0\0009\3\0\0'\6\1\0'\a\2\0B\3\4\2\18\5\3\0009\3\0\3'\6\3\0'\a\4\0B\3\4\0025\4\5\0=\1\6\4=\0\a\4\15\0\2\0X\5\6�5\5\t\0>\3\2\5>\2\3\0055\6\n\0>\6\4\5=\5\b\0045\5\v\0=\1\f\0053\6\r\0=\6\14\5=\4\15\0052\0\0�L\5\2\0\topts\ron_press\0\bval\1\0\1\ttype\vbutton\1\0\2\vsilent\2\fnoremap\2\1\2\0\0\6n\vkeymap\rshortcut\ttext\1\0\5\vcursor\3\5\nwidth\3$\rposition\vcenter\ahl\17AlphaButtons\19align_shortcut\nright\r<leader>\bSPC\5\a%s\tgsub�\14\1\0\r\0001\3e6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\1'\3\1\0B\1\2\0013\1\4\0006\2\5\0009\2\6\2*\3\0\0009\4\a\0025\6\b\0009\a\t\0029\t\n\2)\v\0\0B\t\2\2\"\t\3\tB\a\2\0?\a\1\0B\4\2\0025\5\16\0005\6\v\0005\a\f\0=\a\r\0065\a\14\0=\a\15\6=\6\17\0055\6\18\0004\a\a\0\18\b\1\0'\n\19\0'\v\20\0'\f\21\0B\b\4\2>\b\1\a\18\b\1\0'\n\22\0'\v\23\0'\f\24\0B\b\4\2>\b\2\a\18\b\1\0'\n\25\0'\v\26\0'\f\27\0B\b\4\2>\b\3\a\18\b\1\0'\n\28\0'\v\29\0'\f\30\0B\b\4\2>\b\4\a\18\b\1\0'\n\31\0'\v \0'\f!\0B\b\4\2>\b\5\a\18\b\1\0'\n\"\0'\v#\0'\f$\0B\b\4\0?\b\2\0=\a\r\0065\a%\0=\a\15\6=\6&\0055\6'\0=\4\r\6=\6(\0055\6)\0=\6*\0056\6\0\0'\b+\0B\6\2\0029\6,\6\18\b\5\0'\t-\0B\6\3\2\18\5\6\0009\6.\0005\b/\0004\t\5\0009\n(\5>\n\1\t9\n\17\5>\n\2\t9\n*\5>\n\3\t9\n&\5>\n\4\t=\t0\b4\t\0\0=\t\15\bB\6\2\1K\0\1\0\vlayout\1\0\0\nsetup\23goolord/alpha-nvim\18load_override\15core.utils\24headerPaddingBottom\1\0\2\ttype\fpadding\bval\3\2\21headerPaddingTop\1\0\1\ttype\fpadding\fbuttons\1\0\1\fspacing\3\1!:e $MYVIMRC | :cd %:p:h <CR>\18  Settings\fSPC e s\26:Telescope themes<CR>\18  Themes  \fSPC t h\25:Telescope marks<CR>\21  Bookmarks  \fSPC b m\29:Telescope live_grep<CR>\21  Find Word  \fSPC f w\28:Telescope oldfiles<CR>\23  Recent File  \fSPC f o\30:Telescope find_files<CR>\21  Find File  \fSPC f f\1\0\1\ttype\ngroup\vheader\1\0\0\topts\1\0\2\ahl\16AlphaHeader\rposition\vcenter\bval\1\f\0\0J   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          X    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       F          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     N           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    L          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ^   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  X  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   b ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  \\ ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ P      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     V       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     \1\0\1\ttype\ttext\14winheight\nfloor\1\2\0\0\3\2\bmax\afn\bvim\0\19load_highlight\vbase46\nalpha\frequire�̙�\6����\3\5����\4\r����\4\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/user/.local/share/nvim/site/pack/packer/opt/alpha-nvim",
    url = "https://github.com/goolord/alpha-nvim"
  },
  base46 = {
    after = { "ui", "alpha-nvim" },
    config = { "\27LJ\2\n9\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\15load_theme\vbase46\frequire\0" },
    loaded = true,
    only_config = true,
    path = "/home/user/.local/share/nvim/site/pack/packer/start/base46",
    url = "https://github.com/NvChad/base46"
  },
  ["cmp-buffer"] = {
    after = { "cmp-path" },
    after_files = { "/home/user/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/user/.local/share/nvim/site/pack/packer/opt/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/user/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    after_files = { "/home/user/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/user/.local/share/nvim/site/pack/packer/opt/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  extensions = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/user/.local/share/nvim/site/pack/packer/opt/extensions",
    url = "https://github.com/NvChad/extensions"
  },
  ["friendly-snippets"] = {
    after = { "nvim-cmp" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/user/.local/share/nvim/site/pack/packer/opt/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n_\0\1\5\0\6\0\t6\1\0\0'\3\1\0B\1\2\0029\1\2\1'\3\3\0005\4\4\0=\0\5\4B\1\3\1K\0\1\0\vbuffer\1\0\0\rgitsigns\18load_mappings\15core.utils\frequire�\3\1\0\5\0\21\0\0286\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\1'\3\4\0B\1\2\0015\1\16\0005\2\6\0005\3\5\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\0025\3\f\0=\3\r\0025\3\14\0=\3\15\2=\2\17\0013\2\18\0=\2\19\0019\2\20\0\18\4\1\0B\2\2\1K\0\1\0\nsetup\14on_attach\0\nsigns\1\0\0\17changedelete\1\0\3\nnumhl\21GitSignsChangeNr\ahl\21DiffChangeDelete\ttext\6~\14topdelete\1\0\3\nnumhl\21GitSignsDeleteNr\ahl\15DiffDelete\ttext\b‾\vdelete\1\0\3\nnumhl\21GitSignsDeleteNr\ahl\15DiffDelete\ttext\b\vchange\1\0\3\nnumhl\21GitSignsChangeNr\ahl\15DiffChange\ttext\b│\badd\1\0\0\1\0\3\nnumhl\18GitSignsAddNr\ahl\fDiffAdd\ttext\b│\bgit\19load_highlight\vbase46\rgitsigns\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/user/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/user/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\n�\3\0\0\4\0\v\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\0016\0\0\0'\2\4\0B\0\2\0029\0\5\0005\2\6\0005\3\a\0=\3\b\0025\3\t\0=\3\n\2B\0\2\1K\0\1\0\20buftype_exclude\1\2\0\0\rterminal\21filetype_exclude\1\n\0\0\thelp\rterminal\nalpha\vpacker\flspinfo\20TelescopePrompt\21TelescopeResults\nmason\5\1\0\5\23indentLine_enabled\3\1\31show_current_context_start\2\25show_current_context\2\28show_first_indent_level\1#show_trailing_blankline_indent\1\nsetup\21indent_blankline\14blankline\19load_highlight\vbase46\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/user/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["mason.nvim"] = {
    commands = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    config = { "\27LJ\2\nG\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\nmason\19load_highlight\vbase46\frequireo\0\0\a\1\a\0\f6\0\0\0009\0\1\0'\2\2\0006\3\3\0009\3\4\3-\5\0\0009\5\5\5'\6\6\0B\3\3\2&\2\3\2B\0\2\1K\0\1\0\1�\6 \21ensure_installed\vconcat\ntable\18MasonInstall \bcmd\bvim�\5\1\0\a\0\25\0&6\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0019\1\4\1'\3\5\0005\4\6\0B\1\3\0016\1\2\0009\1\3\0019\1\a\1'\3\b\0005\4\t\0003\5\n\0=\5\v\4B\1\3\0015\1\r\0005\2\f\0=\2\14\0015\2\16\0005\3\15\0=\3\17\0025\3\18\0=\3\19\2=\2\20\0016\2\2\0009\2\3\0029\2\21\2'\4\22\0003\5\23\0004\6\0\0B\2\4\0019\2\24\0\18\4\1\0B\2\2\0012\0\0�K\0\1\0\nsetup\0\20MasonInstallAll\29nvim_create_user_command\aui\fkeymaps\1\0\b\27check_outdated_servers\6C\21uninstall_server\6X\23update_all_servers\6U\25check_server_version\6c\18update_server\6u\19install_server\6i\25toggle_server_expand\t<CR>\24cancel_installation\n<C-c>\nicons\1\0\0\1\0\3\24package_uninstalled\t ﮊ\20package_pending\t \22package_installed\t \21ensure_installed\1\0\1\30max_concurrent_installers\3\n\1\2\0\0\24lua-language-server\rcallback\0\1\0\2\fpattern\nmason\ngroup\v_mason\rFiletype\24nvim_create_autocmd\1\0\1\nclear\2\v_mason\24nvim_create_augroup\bapi\bvim\nmason\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/user/.local/share/nvim/site/pack/packer/opt/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n�\2\0\0\n\0\r\0\0256\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0025\2\3\0004\3\0\0=\3\4\0025\3\5\0=\3\6\0029\3\a\0\18\5\2\0B\3\2\0016\3\0\0'\5\b\0B\3\2\0029\4\t\1\18\6\4\0009\4\n\4'\a\v\0009\b\f\3B\b\1\0A\4\2\1K\0\1\0\20on_confirm_done\17confirm_done\aon\nevent\"nvim-autopairs.completion.cmp\nsetup\21disable_filetype\1\3\0\0\20TelescopePrompt\bvim\14fast_wrap\1\0\0\bcmp\19nvim-autopairs\frequire\0" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/user/.local/share/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    after = { "nvim-autopairs" },
    config = { "\27LJ\2\n�\1\0\1\3\0\b\0\0264\1\t\0005\2\0\0>\0\2\2>\2\1\0015\2\1\0>\0\2\2>\2\2\0015\2\2\0>\0\2\2>\2\3\0015\2\3\0>\0\2\2>\2\4\0015\2\4\0>\0\2\2>\2\5\0015\2\5\0>\0\2\2>\2\6\0015\2\6\0>\0\2\2>\2\a\0015\2\a\0>\0\2\2>\2\b\1L\1\2\0\1\2\0\0\b│\1\2\0\0\b╰\1\2\0\0\b─\1\2\0\0\b╯\1\2\0\0\b│\1\2\0\0\b╮\1\2\0\0\b─\1\2\0\0\b╭0\0\1\4\0\2\0\6\18\3\0\0009\1\0\0B\1\2\2+\2\1\0=\2\1\1L\1\2\0\15scrollable\ninfo_t\0\2\b\0\a\0\r6\2\0\0'\4\1\0B\2\2\0029\2\2\0026\3\4\0009\3\5\3'\5\6\0009\6\3\0018\6\6\0029\a\3\1B\3\4\2=\3\3\1L\1\2\0\n%s %s\vformat\vstring\tkind\flspkind\20nvchad_ui.icons\frequireR\0\1\3\1\2\0\f-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4�-\1\0\0009\1\1\1B\1\1\1X\1\2�\18\1\0\0B\1\1\1K\0\1\0\2�\21select_next_item\fvisibleR\0\1\3\1\2\0\f-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4�-\1\0\0009\1\1\1B\1\1\1X\1\2�\18\1\0\0B\1\1\1K\0\1\0\2�\21select_prev_item\fvisible�\a\1\0\v\0:\0d6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\0016\0\4\0009\0\5\0'\1\a\0=\1\6\0003\0\b\0006\1\0\0'\3\t\0B\1\2\0029\2\v\1=\2\n\0013\2\f\0=\2\v\0016\2\0\0'\4\3\0B\2\2\0029\3\r\0025\5\22\0005\6\17\0005\a\15\0\18\b\0\0'\n\14\0B\b\2\2=\b\16\a=\a\18\0065\a\20\0\18\b\0\0'\n\19\0B\b\2\2=\b\16\a=\a\21\6=\6\23\0055\6\25\0003\a\24\0=\a\26\6=\6\27\0055\6\30\0009\a\28\0029\a\29\aB\a\1\2=\a\31\0069\a\28\0029\a \aB\a\1\2=\a!\0069\a\28\0029\a\"\a)\t��B\a\2\2=\a#\0069\a\28\0029\a\"\a)\t\4\0B\a\2\2=\a$\0069\a\28\0029\a%\aB\a\1\2=\a&\0069\a\28\0029\a'\aB\a\1\2=\a(\0069\a\28\0029\a)\a5\t,\0009\n*\0029\n+\n=\n-\tB\a\2\2=\a.\0069\a\28\0023\t/\0005\n0\0B\a\3\2=\a1\0069\a\28\0023\t2\0005\n3\0B\a\3\2=\a4\6=\6\28\0054\6\5\0005\a5\0>\a\1\0065\a6\0>\a\2\0065\a7\0>\a\3\0065\a8\0>\a\4\6=\0069\5B\3\2\0012\0\0�K\0\1\0\fsources\1\0\1\tname\tpath\1\0\1\tname\rnvim_lua\1\0\1\tname\vbuffer\1\0\1\tname\rnvim_lsp\f<S-Tab>\1\3\0\0\6i\6s\0\n<Tab>\1\3\0\0\6i\6s\0\t<CR>\rbehavior\1\0\1\vselect\1\fReplace\20ConfirmBehavior\fconfirm\n<C-e>\nclose\14<C-Space>\rcomplete\n<C-f>\n<C-d>\16scroll_docs\n<C-n>\21select_next_item\n<C-p>\1\0\0\21select_prev_item\fmapping\15formatting\vformat\1\0\0\0\vwindow\1\0\0\18documentation\1\0\0\17CmpDocBorder\15completion\1\0\0\vborder\1\0\1\17winhighlight4Normal:CmpPmenu,CursorLine:PmenuSel,Search:None\14CmpBorder\nsetup\0\tinfo\ninfo_\21cmp.utils.window\0\26menu,menuone,noselect\16completeopt\6o\bvim\bcmp\19load_highlight\vbase46\frequire\0" },
    load_after = {
      ["friendly-snippets"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/user/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\nF\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0)\2\0\0B\0\2\1K\0\1\0\21attach_to_buffer\14colorizer\frequire�\1\1\0\6\0\v\0\0176\0\0\0'\2\1\0B\0\2\0025\1\3\0005\2\2\0=\2\4\0015\2\5\0=\2\6\0019\2\a\0\18\4\1\0B\2\2\0016\2\b\0009\2\t\0023\4\n\0)\5\0\0B\2\3\1K\0\1\0\0\rdefer_fn\bvim\nsetup\25user_default_options\1\0\t\bcss\1\vhsl_fn\1\vrgb_fn\1\rRRGGBBAA\1\nnames\1\vRRGGBB\2\bRGB\2\tmode\15background\vcss_fn\1\14filetypes\1\0\0\1\2\0\0\6*\14colorizer\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/user/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua",
    url = "https://github.com/NvChad/nvim-colorizer.lua"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\n�\2\0\2\6\1\v\0\0239\2\0\0+\3\1\0=\3\1\0029\2\0\0+\3\1\0=\3\2\2-\2\0\0009\2\3\2'\4\4\0005\5\5\0=\1\6\5B\2\3\0019\2\0\0009\2\a\2\15\0\2\0X\3\6�6\2\b\0'\4\t\0B\2\2\0029\2\n\2\18\4\0\0B\2\2\1K\0\1\0\2�\nsetup\24nvchad_ui.signature\frequire\26signatureHelpProvider\vbuffer\1\0\0\14lspconfig\18load_mappings$documentRangeFormattingProvider\31documentFormattingProvider\24server_capabilities�\a\1\0\r\0-\0K6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\1'\3\4\0B\1\2\0016\1\0\0'\3\5\0B\1\2\0014\1\0\0006\2\0\0'\4\6\0B\2\2\0023\3\b\0=\3\a\0016\3\n\0009\3\4\0039\3\v\0039\3\f\3B\3\1\2=\3\t\0019\3\t\0019\3\r\0039\3\14\0035\4\17\0005\5\16\0=\5\18\0045\5\20\0005\6\19\0=\6\21\5=\5\22\0045\5\24\0005\6\23\0=\6\25\5=\5\26\4=\4\15\0039\3\27\0009\3\28\0035\5\29\0009\6\a\1=\6\a\0059\6\t\1=\6\t\0055\6*\0005\a!\0005\b\31\0005\t\30\0=\t \b=\b\"\a5\b'\0004\t\0\b6\n\n\0009\n#\n9\n$\n'\f%\0B\n\2\2+\v\2\0<\v\n\t6\n\n\0009\n#\n9\n$\n'\f&\0B\n\2\2+\v\2\0<\v\n\t=\t(\b=\b)\a=\a+\6=\6,\5B\3\2\0012\0\0�L\1\2\0\rsettings\bLua\1\0\0\14workspace\flibrary\1\0\2\15maxPreload\3��\6\20preloadFileSize\3�N\28$VIMRUNTIME/lua/vim/lsp\20$VIMRUNTIME/lua\vexpand\afn\16diagnostics\1\0\0\fglobals\1\0\0\1\2\0\0\bvim\1\0\0\nsetup\vlua_ls\19resolveSupport\15properties\1\0\0\1\4\0\0\18documentation\vdetail\24additionalTextEdits\15tagSupport\rvalueSet\1\0\0\1\2\0\0\3\1\24documentationFormat\1\0\6\28commitCharactersSupport\2\22deprecatedSupport\2\24labelDetailsSupport\2\25insertReplaceSupport\2\21preselectSupport\2\19snippetSupport\2\1\3\0\0\rmarkdown\14plaintext\19completionItem\15completion\17textDocument\29make_client_capabilities\rprotocol\bvim\17capabilities\0\14on_attach\15core.utils\18nvchad_ui.lsp\blsp\19load_highlight\vbase46\14lspconfig\frequire\0" },
    loaded = false,
    needs_bufread = false,
    path = "/home/user/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    commands = { "NvimTreeToggle", "NvimTreeFocus" },
    config = { "\27LJ\2\n�\b\0\0\a\0+\00096\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\1'\3\4\0B\1\2\0015\1\f\0005\2\5\0004\3\3\0006\4\6\0009\4\a\0049\4\b\4'\6\t\0B\4\2\2'\5\n\0&\4\5\4>\4\1\3=\3\v\2=\2\r\0015\2\14\0=\2\15\0015\2\16\0=\2\17\0015\2\18\0=\2\19\0015\2\20\0=\2\21\0015\2\23\0005\3\22\0=\3\24\2=\2\25\0015\2\26\0005\3\27\0=\3\28\0025\3\30\0005\4\29\0=\4\31\0035\4 \0005\5!\0=\5\"\0045\5#\0=\5\19\4=\4$\3=\3%\2=\2&\0016\2\6\0009\2'\0029\3\17\0019\3)\3=\3(\0029\2*\0\18\4\1\0B\2\2\1K\0\1\0\nsetup\tside\18nvimtree_side\6g\rrenderer\nicons\vglyphs\1\0\a\fdeleted\b\runmerged\b\vstaged\b✓\runstaged\b✗\fignored\b◌\14untracked\b★\frenamed\b➜\vfolder\1\0\b\nempty\b\topen\b\fdefault\b\17symlink_open\b\15empty_open\b\17arrow_closed\b\15arrow_open\b\fsymlink\b\1\0\2\fdefault\b\fsymlink\b\tshow\1\0\0\1\0\4\tfile\2\bgit\1\17folder_arrow\2\vfolder\2\19indent_markers\1\0\1\venable\1\1\0\2\18highlight_git\1\27highlight_opened_files\tnone\factions\14open_file\1\0\0\1\0\1\18resize_window\2\24filesystem_watchers\1\0\1\venable\2\bgit\1\0\2\vignore\2\venable\1\tview\1\0\4\tside\tleft\18adaptive_size\2\nwidth\3\25\21hide_root_folder\2\24update_focused_file\1\0\2\15update_cwd\1\venable\2\ffilters\1\0\5\15update_cwd\2'hijack_unnamed_buffer_when_opening\1\18hijack_cursor\2\17hijack_netrw\2\18disable_netrw\2\fexclude\16/lua/custom\vconfig\fstdpath\afn\bvim\1\0\1\rdotfiles\1\rnvimtree\19load_highlight\vbase46\14nvim-tree\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/user/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua",
    url = "https://github.com/nvim-tree/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    commands = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSEnable", "TSDisable", "TSModuleInfo" },
    config = { "\27LJ\2\n�\1\0\0\4\0\r\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\0016\0\0\0'\2\4\0B\0\2\0029\0\5\0005\2\a\0005\3\6\0=\3\b\0025\3\t\0=\3\n\0025\3\v\0=\3\f\2B\0\2\1K\0\1\0\vindent\1\0\1\venable\2\14highlight\1\0\2\21use_languagetree\2\venable\2\21ensure_installed\1\0\0\1\2\0\0\blua\nsetup\28nvim-treesitter.configs\15treesitter\19load_highlight\vbase46\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/user/.local/share/nvim/site/pack/packer/opt/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\2\n�\1\0\0\6\0\t\0\0186\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\0016\0\0\0'\2\4\0B\0\2\0029\0\5\0005\2\a\0006\3\0\0'\5\6\0B\3\2\0029\3\3\3=\3\b\2B\0\2\1K\0\1\0\roverride\1\0\0\20nvchad_ui.icons\nsetup\22nvim-web-devicons\rdevicons\19load_highlight\vbase46\frequire\0" },
    load_after = {},
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/user/.local/share/nvim/site/pack/packer/opt/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  nvterm = {
    config = { "\27LJ\2\n�\3\0\0\6\0\18\0\0246\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\0029\0\3\0005\2\14\0005\3\4\0004\4\0\0=\4\5\0035\4\a\0005\5\6\0=\5\b\0045\5\t\0=\5\n\0045\5\v\0=\5\f\4=\4\r\3=\3\15\0025\3\16\0=\3\17\2B\0\2\1K\0\1\0\rbehavior\1\0\2\16auto_insert\2\18close_on_exit\2\14terminals\1\0\1\24enable_new_mappings\2\14type_opts\rvertical\1\0\2\rlocation\15rightbelow\16split_ratio\4\0����\3\15horizontal\1\0\2\rlocation\15rightbelow\16split_ratio\4��̙\3����\3\nfloat\1\0\0\1\0\6\brow\4��̙\3����\3\nwidth\4\0����\3\bcol\4\0����\3\vheight\4����\t����\3\rrelative\veditor\vborder\vsingle\tlist\1\0\0\nsetup\vnvterm\16base46.term\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/user/.local/share/nvim/site/pack/packer/opt/nvterm",
    url = "https://github.com/NvChad/nvterm"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/user/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/user/.local/share/nvim/site/pack/packer/opt/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["telescope.nvim"] = {
    commands = { "Telescope" },
    config = { "\27LJ\2\na\0\0\b\2\3\0\f6\0\0\0-\2\0\0009\2\1\2B\0\2\4X\3\4�-\5\1\0009\5\2\5\18\a\4\0B\5\2\1E\3\3\3R\3�\127K\0\1\0\1�\0�\19load_extension\20extensions_list\vipairs�\n\1\0\b\0005\0V6\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\1+\2\2\0=\2\4\0016\1\0\0'\3\5\0B\1\2\0029\1\6\1'\3\1\0B\1\2\0015\1.\0005\2\b\0005\3\a\0=\3\t\0025\3\v\0005\4\n\0=\4\f\0035\4\r\0=\4\14\3=\3\15\0026\3\0\0'\5\16\0B\3\2\0029\3\17\3=\3\18\0025\3\19\0=\3\20\0026\3\0\0'\5\16\0B\3\2\0029\3\21\3=\3\22\0025\3\23\0=\3\24\0024\3\0\0=\3\25\0025\3\26\0=\3\27\0025\3\28\0=\3\29\0026\3\0\0'\5\30\0B\3\2\0029\3\31\0039\3 \3=\3!\0026\3\0\0'\5\30\0B\3\2\0029\3\"\0039\3 \3=\3#\0026\3\0\0'\5\30\0B\3\2\0029\3$\0039\3 \3=\3%\0026\3\0\0'\5\30\0B\3\2\0029\3&\3=\3&\0025\3+\0005\4)\0006\5\0\0'\a'\0B\5\2\0029\5(\5=\5*\4=\4,\3=\3-\2=\2/\0015\0020\0=\0021\0019\0022\0\18\4\1\0B\2\2\0016\0023\0003\0044\0B\2\2\0012\0\0�K\0\1\0\0\npcall\nsetup\20extensions_list\1\3\0\0\vthemes\nterms\rdefaults\1\0\0\rmappings\6n\1\0\0\6q\1\0\0\nclose\22telescope.actions\27buffer_previewer_maker\21qflist_previewer\22vim_buffer_qflist\19grep_previewer\23vim_buffer_vimgrep\19file_previewer\bnew\19vim_buffer_cat\25telescope.previewers\fset_env\1\0\1\14COLORTERM\14truecolor\16borderchars\1\t\0\0\b─\b│\b─\b│\b╭\b╮\b╯\b╰\vborder\17path_display\1\2\0\0\rtruncate\19generic_sorter\29get_generic_fuzzy_sorter\25file_ignore_patterns\1\2\0\0\17node_modules\16file_sorter\19get_fuzzy_file\22telescope.sorters\18layout_config\rvertical\1\0\1\vmirror\1\15horizontal\1\0\3\vheight\4����\t����\3\nwidth\4����\3����\3\19preview_cutoff\3x\1\0\3\18preview_width\4����\t����\3\20prompt_position\btop\18results_width\4����\t����\3\22vimgrep_arguments\1\0\t\20layout_strategy\15horizontal\21sorting_strategy\14ascending\23selection_strategy\nreset\17initial_mode\vinsert\17entry_prefix\a  \20selection_caret\a  \18prompt_prefix\v   \19color_devicons\2\rwinblend\3\0\1\t\0\0\arg\a-L\18--color=never\17--no-heading\20--with-filename\18--line-number\r--column\17--smart-case\19load_highlight\vbase46\26theme_switcher_loaded\6g\bvim\14telescope\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/user/.local/share/nvim/site/pack/packer/opt/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ui = {
    after = { "nvim-web-devicons" },
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14nvchad_ui\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/user/.local/share/nvim/site/pack/packer/opt/ui",
    url = "https://github.com/NvChad/ui"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "/home/user/.local/share/nvim/site/pack/packer/start/vim-sleuth",
    url = "https://github.com/tpope/vim-sleuth"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n�\3\0\0\5\0\23\0\0316\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\1'\3\1\0B\1\2\0015\1\5\0005\2\4\0=\2\6\0015\2\a\0=\2\b\0015\2\t\0=\2\n\0015\2\v\0=\2\f\0015\2\r\0=\2\14\0015\2\16\0005\3\15\0=\3\17\0025\3\18\0=\3\19\2=\2\20\0016\2\21\0009\2\22\2\18\4\1\0B\2\2\1K\0\1\0\nsetup\awk\23triggers_blacklist\6v\1\3\0\0\6j\6k\6i\1\0\0\1\3\0\0\6j\6k\vhidden\1\t\0\0\r<silent>\n<cmd>\n<Cmd>\t<CR>\tcall\blua\a^:\a^ \vlayout\1\0\1\fspacing\3\6\vwindow\1\0\1\vborder\tnone\19popup_mappings\1\0\2\16scroll_down\n<c-d>\14scroll_up\n<c-u>\nicons\1\0\0\1\0\3\14separator\n  \ngroup\6+\15breadcrumb\a»\19load_highlight\vbase46\rwhichkey\frequire\0" },
    keys = { { "", "<leader>" }, { "", '"' }, { "", "'" }, { "", "`" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/user/.local/share/nvim/site/pack/packer/opt/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^Comment"] = "Comment.nvim",
  ["^cmp"] = "friendly-snippets",
  ["^cmp_nvim_lsp"] = "friendly-snippets",
  ["^nvchad"] = "extensions",
  ["^nvim%-treesitter"] = "nvim-treesitter",
  ["^nvim%-web%-devicons"] = "nvim-web-devicons",
  ["^nvterm"] = "nvterm",
  ["^plenary"] = "plenary.nvim",
  ["^telescope"] = "extensions",
  ["^which%-key"] = "which-key.nvim"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Setup for: nvim-treesitter
time([[Setup for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nW\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\20nvim-treesitter\17on_file_open\19core.lazy_load\frequire\0", "setup", "nvim-treesitter")
time([[Setup for nvim-treesitter]], false)
-- Setup for: indent-blankline.nvim
time([[Setup for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\n�\1\0\0\3\0\a\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\0016\0\0\0'\2\4\0B\0\2\0029\0\5\0'\2\6\0B\0\2\1K\0\1\0\14blankline\18load_mappings\15core.utils\26indent-blankline.nvim\17on_file_open\19core.lazy_load\frequire\0", "setup", "indent-blankline.nvim")
time([[Setup for indent-blankline.nvim]], false)
-- Setup for: nvim-colorizer.lua
time([[Setup for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\nZ\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\23nvim-colorizer.lua\17on_file_open\19core.lazy_load\frequire\0", "setup", "nvim-colorizer.lua")
time([[Setup for nvim-colorizer.lua]], false)
-- Setup for: which-key.nvim
time([[Setup for which-key.nvim]], true)
try_loadstring("\27LJ\2\nM\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\rwhichkey\18load_mappings\15core.utils\frequire\0", "setup", "which-key.nvim")
time([[Setup for which-key.nvim]], false)
-- Setup for: nvim-lspconfig
time([[Setup for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\nV\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\19nvim-lspconfig\17on_file_open\19core.lazy_load\frequire\0", "setup", "nvim-lspconfig")
time([[Setup for nvim-lspconfig]], false)
-- Setup for: nvterm
time([[Setup for nvterm]], true)
try_loadstring("\27LJ\2\nK\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\vnvterm\18load_mappings\15core.utils\frequire\0", "setup", "nvterm")
time([[Setup for nvterm]], false)
-- Setup for: nvim-tree.lua
time([[Setup for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\nM\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\rnvimtree\18load_mappings\15core.utils\frequire\0", "setup", "nvim-tree.lua")
time([[Setup for nvim-tree.lua]], false)
-- Setup for: telescope.nvim
time([[Setup for telescope.nvim]], true)
try_loadstring("\27LJ\2\nN\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\14telescope\18load_mappings\15core.utils\frequire\0", "setup", "telescope.nvim")
time([[Setup for telescope.nvim]], false)
-- Setup for: gitsigns.nvim
time([[Setup for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\rgitsigns\19core.lazy_load\frequire\0", "setup", "gitsigns.nvim")
time([[Setup for gitsigns.nvim]], false)
-- Setup for: Comment.nvim
time([[Setup for Comment.nvim]], true)
try_loadstring("\27LJ\2\nL\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\fcomment\18load_mappings\15core.utils\frequire\0", "setup", "Comment.nvim")
time([[Setup for Comment.nvim]], false)
-- Config for: base46
time([[Config for base46]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\15load_theme\vbase46\frequire\0", "config", "base46")
time([[Config for base46]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd cmp-nvim-lsp ]]
vim.cmd [[ packadd cmp-buffer ]]
vim.cmd [[ packadd cmp-path ]]
vim.cmd [[ packadd alpha-nvim ]]

-- Config for: alpha-nvim
try_loadstring("\27LJ\2\n�\1\0\0\6\1\6\0\0196\0\0\0009\0\1\0009\0\2\0-\2\0\0+\3\2\0+\4\1\0+\5\2\0B\0\5\2\14\0\0\0X\1\1�'\0\3\0006\1\0\0009\1\1\0019\1\4\1\18\3\0\0'\4\5\0+\5\1\0B\1\4\1K\0\1\0\3�\vnormal\18nvim_feedkeys\5\27nvim_replace_termcodes\bapi\bvim�\2\1\3\b\0\16\0\28\18\5\0\0009\3\0\0'\6\1\0'\a\2\0B\3\4\2\18\5\3\0009\3\0\3'\6\3\0'\a\4\0B\3\4\0025\4\5\0=\1\6\4=\0\a\4\15\0\2\0X\5\6�5\5\t\0>\3\2\5>\2\3\0055\6\n\0>\6\4\5=\5\b\0045\5\v\0=\1\f\0053\6\r\0=\6\14\5=\4\15\0052\0\0�L\5\2\0\topts\ron_press\0\bval\1\0\1\ttype\vbutton\1\0\2\vsilent\2\fnoremap\2\1\2\0\0\6n\vkeymap\rshortcut\ttext\1\0\5\vcursor\3\5\nwidth\3$\rposition\vcenter\ahl\17AlphaButtons\19align_shortcut\nright\r<leader>\bSPC\5\a%s\tgsub�\14\1\0\r\0001\3e6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0029\1\3\1'\3\1\0B\1\2\0013\1\4\0006\2\5\0009\2\6\2*\3\0\0009\4\a\0025\6\b\0009\a\t\0029\t\n\2)\v\0\0B\t\2\2\"\t\3\tB\a\2\0?\a\1\0B\4\2\0025\5\16\0005\6\v\0005\a\f\0=\a\r\0065\a\14\0=\a\15\6=\6\17\0055\6\18\0004\a\a\0\18\b\1\0'\n\19\0'\v\20\0'\f\21\0B\b\4\2>\b\1\a\18\b\1\0'\n\22\0'\v\23\0'\f\24\0B\b\4\2>\b\2\a\18\b\1\0'\n\25\0'\v\26\0'\f\27\0B\b\4\2>\b\3\a\18\b\1\0'\n\28\0'\v\29\0'\f\30\0B\b\4\2>\b\4\a\18\b\1\0'\n\31\0'\v \0'\f!\0B\b\4\2>\b\5\a\18\b\1\0'\n\"\0'\v#\0'\f$\0B\b\4\0?\b\2\0=\a\r\0065\a%\0=\a\15\6=\6&\0055\6'\0=\4\r\6=\6(\0055\6)\0=\6*\0056\6\0\0'\b+\0B\6\2\0029\6,\6\18\b\5\0'\t-\0B\6\3\2\18\5\6\0009\6.\0005\b/\0004\t\5\0009\n(\5>\n\1\t9\n\17\5>\n\2\t9\n*\5>\n\3\t9\n&\5>\n\4\t=\t0\b4\t\0\0=\t\15\bB\6\2\1K\0\1\0\vlayout\1\0\0\nsetup\23goolord/alpha-nvim\18load_override\15core.utils\24headerPaddingBottom\1\0\2\ttype\fpadding\bval\3\2\21headerPaddingTop\1\0\1\ttype\fpadding\fbuttons\1\0\1\fspacing\3\1!:e $MYVIMRC | :cd %:p:h <CR>\18  Settings\fSPC e s\26:Telescope themes<CR>\18  Themes  \fSPC t h\25:Telescope marks<CR>\21  Bookmarks  \fSPC b m\29:Telescope live_grep<CR>\21  Find Word  \fSPC f w\28:Telescope oldfiles<CR>\23  Recent File  \fSPC f o\30:Telescope find_files<CR>\21  Find File  \fSPC f f\1\0\1\ttype\ngroup\vheader\1\0\0\topts\1\0\2\ahl\16AlphaHeader\rposition\vcenter\bval\1\f\0\0J   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          X    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       F          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     N           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    L          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ^   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  X  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   b ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  \\ ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ P      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     V       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     \1\0\1\ttype\ttext\14winheight\nfloor\1\2\0\0\3\2\bmax\afn\bvim\0\19load_highlight\vbase46\nalpha\frequire�̙�\6����\3\5����\4\r����\4\0", "config", "alpha-nvim")

vim.cmd [[ packadd ui ]]

-- Config for: ui
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14nvchad_ui\frequire\0", "config", "ui")

time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.api.nvim_create_user_command, 'TSBufEnable', function(cmdargs)
          require('packer.load')({'nvim-treesitter'}, { cmd = 'TSBufEnable', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-treesitter'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TSBufEnable ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'TSBufDisable', function(cmdargs)
          require('packer.load')({'nvim-treesitter'}, { cmd = 'TSBufDisable', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-treesitter'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TSBufDisable ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'TSEnable', function(cmdargs)
          require('packer.load')({'nvim-treesitter'}, { cmd = 'TSEnable', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-treesitter'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TSEnable ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'TSDisable', function(cmdargs)
          require('packer.load')({'nvim-treesitter'}, { cmd = 'TSDisable', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-treesitter'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TSDisable ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'TSModuleInfo', function(cmdargs)
          require('packer.load')({'nvim-treesitter'}, { cmd = 'TSModuleInfo', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-treesitter'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TSModuleInfo ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'Mason', function(cmdargs)
          require('packer.load')({'mason.nvim'}, { cmd = 'Mason', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'mason.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Mason ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'MasonInstall', function(cmdargs)
          require('packer.load')({'mason.nvim'}, { cmd = 'MasonInstall', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'mason.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('MasonInstall ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'MasonUninstall', function(cmdargs)
          require('packer.load')({'mason.nvim'}, { cmd = 'MasonUninstall', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'mason.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('MasonUninstall ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'MasonUninstallAll', function(cmdargs)
          require('packer.load')({'mason.nvim'}, { cmd = 'MasonUninstallAll', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'mason.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('MasonUninstallAll ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'MasonLog', function(cmdargs)
          require('packer.load')({'mason.nvim'}, { cmd = 'MasonLog', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'mason.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('MasonLog ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'Telescope', function(cmdargs)
          require('packer.load')({'telescope.nvim'}, { cmd = 'Telescope', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'telescope.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Telescope ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'NvimTreeFocus', function(cmdargs)
          require('packer.load')({'nvim-tree.lua'}, { cmd = 'NvimTreeFocus', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-tree.lua'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('NvimTreeFocus ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'TSInstall', function(cmdargs)
          require('packer.load')({'nvim-treesitter'}, { cmd = 'TSInstall', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-treesitter'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('TSInstall ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'MasonInstallAll', function(cmdargs)
          require('packer.load')({'mason.nvim'}, { cmd = 'MasonInstallAll', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'mason.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('MasonInstallAll ', 'cmdline')
      end})
pcall(vim.api.nvim_create_user_command, 'NvimTreeToggle', function(cmdargs)
          require('packer.load')({'nvim-tree.lua'}, { cmd = 'NvimTreeToggle', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-tree.lua'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('NvimTreeToggle ', 'cmdline')
      end})
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> ` <cmd>lua require("packer.load")({'which-key.nvim'}, { keys = "`", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gc <cmd>lua require("packer.load")({'Comment.nvim'}, { keys = "gc", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gb <cmd>lua require("packer.load")({'Comment.nvim'}, { keys = "gb", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <leader> <cmd>lua require("packer.load")({'which-key.nvim'}, { keys = "<lt>leader>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> ' <cmd>lua require("packer.load")({'which-key.nvim'}, { keys = "'", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> " <cmd>lua require("packer.load")({'which-key.nvim'}, { keys = "\"", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType alpha ++once lua require("packer.load")({'nvim-tree.lua'}, { ft = "alpha" }, _G.packer_plugins)]]
vim.cmd [[au FileType gitcommit ++once lua require("packer.load")({'gitsigns.nvim'}, { ft = "gitcommit" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'friendly-snippets'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
