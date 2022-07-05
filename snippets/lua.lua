local utils = require('utils')

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
local i = ls.insert_node
local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
-- local fmt = require("luasnip.extras.fmt").fmt
-- local m = require("luasnip.extras").m
-- local lambda = require("luasnip.extras").l

ls.add_snippets("lua", {
  s("snip", t({
    'local ls = require("luasnip")',
    'local s = ls.snippet',
    'local t = ls.text_node',
    '-- local sn = ls.snippet_node',
    '-- local isn = ls.indent_snippet_node',
    '-- local i = ls.insert_node',
    '-- local f = ls.function_node',
    '-- local c = ls.choice_node',
    '-- local d = ls.dynamic_node',
    '-- local r = ls.restore_node',
    '-- local events = require("luasnip.util.events")',
    '-- local ai = require("luasnip.nodes.absolute_indexer")',
    '-- local fmt = require("luasnip.extras.fmt").fmt',
    '-- local m = require("luasnip.extras").m',
    '-- local lambda = require("luasnip.extras").l',
  })),
  s("req", {
    t('local '),
    f(function(args, _snip, _opts)
      local path = args[1][1]
      if path then
        return utils.path.basename(path)
      else
        return "default"
      end
    end, 1),
    t(' = require("'),
    i(1),
    t('")')
  }),
})
