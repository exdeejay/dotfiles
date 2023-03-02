local M = {}
local merge_tb = vim.tbl_deep_extend

M.load_config = function()
	return {
		ui = {
			hl_add = {},
			hl_override = {},
			changed_themes = {},
			theme_toggle = { 'onedark', 'one_light' },
			theme = 'vscode_dark',
			transparency = false,
		}
	}
end

M.load_mappings = function(section, mapping_opt)
  local function set_section_map(section_values)
    if section_values.plugin then
      return
    end
    section_values.plugin = nil

    for mode, mode_values in pairs(section_values) do
      local default_opts = merge_tb("force", { mode = mode }, mapping_opt or {})
      for keybind, mapping_info in pairs(mode_values) do
        -- merge default + user opts
        local opts = merge_tb("force", default_opts, mapping_info.opts or {})

        mapping_info.opts, opts.mode = nil, nil
        opts.desc = mapping_info[2]

        vim.keymap.set(mode, keybind, mapping_info[1], opts)
      end
    end
  end

  local mappings = require('core.mappings')

  if type(section) == "string" then
    mappings[section]["plugin"] = nil
    mappings = { mappings[section] }
  end

  for _, sect in pairs(mappings) do
    set_section_map(sect)
  end
end

-- merge default/user plugin tables
M.merge_plugins = function(plugins)
  local final_table = {}
  for key, val in pairs(plugins) do
    if val and type(val) == "table" then
      plugins[key][1] = key
      final_table[#final_table + 1] = plugins[key]
    end
  end
  return final_table
end

-- override plugin options table with custom ones
M.load_override = function(options_table, name)
	return options_table
end

return M
