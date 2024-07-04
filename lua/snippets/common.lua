local M = {}

function M.setup()
    local ls = require "luasnip"
    local snip = ls.snippet
    local node = ls.snippet_node
    local indent = ls.indent_snippet_node
    local text = ls.text_node
    local insert = ls.insert_node
    local fun = ls.function_node
    local choice = ls.choice_node
    local dynamic = ls.dynamic_node
    local restore = ls.restore_node
    local events = require "luasnip.util.events"
    local abs_index = require "luasnip.nodes.absolute_indexer"
    local extras = require "luasnip.extras"
    local fmt = extras.fmt
    local m = extras.m
    local l = extras.l
    local postfix = require "luasnip.extras.postfix".postfix

    ls.add_snippets("all", {
        snip("todo:", { text("TODO: ") }),
        snip("note:", { text("NOTE: ") }),
        snip("hack:", { text("HACK: ") }),
        snip("fix:", { text("FIX: ") }),
        snip("bugfix:", { text("FIX: ") }),
        snip("warn:", { text("WARN: ") }),
        snip("perf:", { text("PERF: ") }),
    })
end

return M
