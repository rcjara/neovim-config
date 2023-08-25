require("mason").setup({
    ui = {
        icons = {
            package_installed = "✅",
            package_pending = "😅",
            package_uninstalled ="❌",
        },
    }
})
require("mason-lspconfig").setup()

local utils = require('utils')
utils.setup_au_reload_command()
utils.print_filename_on_reload()
