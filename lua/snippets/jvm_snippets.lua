local M = {}

function M.setup()
    local ls = require "luasnip"
    local snip = ls.snippet
    local node = ls.snippet_node
    local indent = ls.indent_snippet_node
    local text = ls.text_node
    local insert = ls.insert_node
    local func = ls.function_node
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

    ls.add_snippets("java", {
        snip("sout", { text("System.out.println("), insert(1), text(");") }),
        snip("souf", { text("System.out.printf("), insert(1), text(");") }),
        snip("psvm", {
            text({ "public static void main(String[] args) {", "    " }),
            insert(1),
            text({ "", "}" })
        }),

        snip("if", {
            text({ "if (" }),
            insert(1),
            text({ ") {", "    " }),
            insert(2),
            text({ "", "}" }),
        }),

        snip("ifelse", {
            text({ "if (" }),
            insert(1),
            text({ ") {", "    " }),
            insert(2),
            text({ "", "} else {", "    " }),
            insert(3),
            text({ "", "}" }),
        }),

        postfix(".if", {
            func(function(_, parent) return "if (" .. parent.snippet.env.POSTFIX_MATCH .. "" end, {}),
            insert(1),
            text({ ") {", "    " }),
            insert(2),
            text({ "", "}" })
        }),
        postfix(".ifnull", {
            func(function(_, parent) return "if (" .. parent.snippet.env.POSTFIX_MATCH .. " == null) {" end, {}),
            text({ "", "    " }),
            insert(1),
            text({ "", "}" })
        }),
        postfix(".ifnotnull", {
            func(function(_, parent) return "if (" .. parent.snippet.env.POSTFIX_MATCH .. " != null) {" end, {}),
            text({ "", "    " }),
            insert(1),
            text({ "", "}" })
        }),

        postfix("fori", {
            text({ "for (int i = 0; i < " }),
            insert(1),
            text({ "; i++) {", "    " }),
            insert(2),
            text({ "", "}" })
        }),


        postfix(".fori", {
            func(function(_, parent)
                local token = parent.snippet.env.POSTFIX_MATCH
                local is_number = token:match("^%-?%d+$")
                if is_number then
                    return "for (int i = 0; i < " .. token .. "; i++) {"
                else
                    return {
                        "for (int i = 0; i < " .. token .. ".size(); i++) {",
                        "    var item = " .. token .. ".get(i);"
                    }
                end
            end, {}),
            text({ "", "    " }),
            insert(1),
            text({ "", "}" })
        }),

        postfix(".for", {
            func(function(_, parent)
                local token = parent.snippet.env.POSTFIX_MATCH
                local is_number = token:match("^%-?%d+$")
                if is_number then
                    return "for (int i = 0; i < " .. token .. "; i++) {"
                else
                    return "for (var i : " .. parent.snippet.env.POSTFIX_MATCH .. ") {"
                end
            end, {}),
            text({ "", "    " }),
            insert(1),
            text({ "", "}" })
        }),


        snip("ifret", {
            text({ "if (" }), insert(1), text({ ") {", "    return;" }),
            text({ "", "}" })
        }),

        snip("const", { text("private static final "), insert(1), text(";") }),
        snip("thr", { text("throw new "), insert(1), text(";") }),

        snip("logger.get", {
            text({ "private static final Logger logger = Logger.getLogger(" }),
            func(function() return { require("util").filename() } end, {}),
            text({ ".class);" }),
        }),
        snip("info", { text("logger.info("), insert(1), text(");") }),
        snip("warn", { text("logger.warn("), insert(1), text(");") }),


    })
end

return M
