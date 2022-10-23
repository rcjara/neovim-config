local utils = require('utils')

local luasnip = require("luasnip")
luasnip.config.set_config({update_events = 'TextChanged,TextChangedI',})
require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip.loaders.from_lua').lazy_load()

utils.setup_au_reload_command()
utils.print_filename_on_reload()
