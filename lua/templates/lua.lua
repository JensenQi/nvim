local utils = require("new-file-template.utils")

local function plugin_template(relative_path, filename)
    return [[
--
local keymap = require("keymap")
local util = require("util")

return {
    {
        os.getenv("ghproxy") .. "|cursor|",
        version = "*",
        config = function()
            require("").setup({
            })
        end
    }
}]]
end

local function snippet_template(relative_path, filename)
    return [[
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
        snip("trigger", { text("Wow! Text!") })
    })
end

return M]]
end

return function(opts)
    local template = {
        { pattern = "lua/plugins/.*",  content = plugin_template },
        { pattern = "lua/snippets/.*", content = snippet_template },
    }

    return utils.find_entry(template, opts)
end
