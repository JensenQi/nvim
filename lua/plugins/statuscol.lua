-- 垂直状态栏插件
return {
    {
        os.getenv("ghproxy") .. "https://github.com/luukvbaal/statuscol.nvim.git",
        version = "*",
        opts = function()
            local builtin = require('statuscol.builtin')
            return {
                setopt = true,
                segments = {
                    {
                        sign = { name = { ".*" }, text = { ".*" }, namespace = { ".*" }, },
                        click = 'v:lua.ScSa',
                        condition = { true },
                    },
                    {
                        text = { builtin.lnumfunc, ' ' },
                        condition = { true, builtin.not_empty },
                        click = 'v:lua.ScLa',
                    },
                    { text = { builtin.foldfunc, ' ' }, click = 'v:lua.ScFa' },
                },
            }
        end,
    }
}
