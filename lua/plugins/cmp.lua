return {
    {
        os.getenv("ghproxy") .. "https://github.com/hrsh7th/nvim-cmp.git",
        branch = "main",
        dependencies = {
            os.getenv("ghproxy") .. "https://github.com/hrsh7th/cmp-nvim-lsp.git",
            os.getenv("ghproxy") .. "https://github.com/hrsh7th/cmp-buffer.git",
            os.getenv("ghproxy") .. "https://github.com/hrsh7th/cmp-path.git",
            os.getenv("ghproxy") .. "https://github.com/saadparwaiz1/cmp_luasnip.git",
            os.getenv("ghproxy") .. "https://github.com/L3MON4D3/LuaSnip.git",
            os.getenv("ghproxy") .. "https://github.com/rafamadriz/friendly-snippets.git",
            os.getenv("ghproxy") .. "https://github.com/onsails/lspkind.nvim",
        },
        config = function()
            local luasnip = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()

            vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg='NONE', fg='#569CD6' })
            vim.api.nvim_set_hl(0, 'CmpItemKindCodeium', { bg='NONE', fg='#60D5C4'  })

            local cmp = require("cmp")
            vim.keymap.set("i", "<A-enter>", function() cmp.complete() end, {})

            local lspkind = require('lspkind')
            cmp.setup({
                matching = {
                    disallow_prefix_unmatching = true,
                    disallow_symbol_nonprefix_matching = true
                },
                snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
                mapping = cmp.mapping.preset.insert({
                    ['<TAB>'] = cmp.mapping(function (fallback)
                        if cmp.visible() then
                            cmp.confirm({select = true})
                        elseif luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ['<CR>'] = cmp.mapping(function (fallback)
                        if cmp.visible() then
                            cmp.confirm({select = true})
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = lspkind.cmp_format({
                        mode = 'symbol_text',
                        maxwidth = 50,
                        ellipsis_char = '...',
                        show_labelDetails = true,
                        symbol_map = { Codeium = "", },
                        before = function(entry, vim_item)
                            local name = entry.source.name
                            vim_item.menu = ({
					            buffer = '[BUF]',
					            path = '[PATH]',
					            nvim_lsp = '[LSP]',
					            luasnip = '[SNIP]',
                                codeium = '[CDM]',
				            })[name] or ("[" .. string.upper(name) .. "]")
                            vim_item.dup = 0
                            return vim_item
                        end
                    })
                },

                sources = cmp.config.sources({
                    { name = "codeium" },
                    { name = 'nvim_lsp' },
                    { name = 'path' },
                    { name = 'luasnip' },
		            { name = 'buffer' },
                })
            })

            local cmp_autopairs = require('nvim-autopairs.completion.cmp').on_confirm_done()

            cmp.event:on(
                'confirm_done',
                function (event)
                    cmp_autopairs(event)
                end
            )
        end
    }
}

