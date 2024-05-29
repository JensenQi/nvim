-- 命令 & 查找 popup 插件
return {
    {
        os.getenv("ghproxy") .. "https://github.com/gelguy/wilder.nvim.git",
        version = "*",
        config = function()
            local wilder = require('wilder')
            wilder.setup({ modes = { ':', '/', '?' } })

            wilder.set_option('pipeline', {
                wilder.branch(wilder.cmdline_pipeline({ language = 'vim', fuzzy = 1 }))      -- 忽略大小写模糊查询
            })

            wilder.set_option('renderer',
                wilder.renderer_mux({
                    ['/'] = wilder.popupmenu_renderer(
                        wilder.popupmenu_palette_theme({
                            border = 'rounded',
                            max_height = '75%',
                            min_height = 0,
                            prompt_position = 'top',
                            reverse = 0,
                            highlighter = wilder.basic_highlighter(),
                        })),
                    [':'] = wilder.popupmenu_renderer({
                        highlighter = wilder.basic_highlighter()
                    })
                })
            )
        end
    }
}
