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

    local util = require("util")

    ls.add_snippets("typescriptreact", {

        -- typescript
        postfix(".fun", {
            dynamic(1, function(_, parent)
                local content_ahead = util.content_before_cursor()
                if util.is_not_blank(content_ahead) then
                    local variable = parent.snippet.env.POSTFIX_MATCH or ""
                    return node(nil, {
                        text("(" .. variable .. ") => { "),
                        insert(1),
                        text(" }")
                    })
                else
                    return node(nil, {
                        text('const '),
                        insert(1),
                        text(' = ('),
                        insert(2),
                        text({ ') => {', '    ' }),
                        insert(3),
                        text({ '', '}' })
                    })
                end
            end, {}),
        }),

        -- react
        postfix(".useState", {
            dynamic(1, function(_, parent)
                local variable = parent.snippet.env.POSTFIX_MATCH
                local Varible = variable:gsub("^%l", string.upper)

                local default_value = ""
                if util.start_with(variable, "is") or util.end_with(variable, "able") or util.start_with(variable, "has") then
                    default_value = "false"
                elseif util.end_with(variable, "Num") or util.end_with(variable, "Count")
                    or util.end_with(variable, "Cnt") or util.end_with(variable, "Number")
                    or util.end_with(variable, "Size") then
                    default_value = "0"
                end


                return node(nil, {
                    text("const [" .. variable .. ", set" .. Varible .. "] = React.useState("),
                    insert(1, default_value),
                    text(")")
                })
            end, {}),
        }),

        -- react native
        snip('.View', { text({ '<View>', '    ' }), insert(1), text({ '', '</View>' }) }),

        --react navigation
        postfix(".Screen", {
            dynamic(1, function(_, parent)
                local prefix = parent.snippet.env.POSTFIX_MATCH
                return node(nil, {
                    text("<" .. prefix .. '.Screen name="'),
                    insert(1),
                    text('" component={'),
                    func(function(args) return args[1][1] end, { 1 }),
                    text('} />'),
                })
            end, {})
        }),

        snip(".useNav", text("const navigation: NavigationProp<ParamListBase> = useNavigation();")),

        snip('.useRoute', dynamic(1, function(_, parent)
            return node(nil, {
                text("const route = useRoute<RouteProp<{ params: { "),
                insert(1),
                text({ " } }, 'params'>>();", "" }),
                func(function(args, _)
                    local inputs = util.split(args[1][1]:gsub("%s", ""), ",")
                    local params = {}
                    for i = 1, #inputs do
                        table.insert(params, util.split(inputs[i], ":")[1])
                    end
                    return "let { " .. table.concat(params, ', ') .. " } = route.params;"
                end, { 1 }),
                text("")
            })
        end, {})),

        -- react native paper
        snip(
            '.Text',
            choice(1, {
                node(nil, { text('<Text variant="displayLarge">'), insert(1), text('</Text>') }),
                node(nil, { text('<Text variant="displayMedium">'), insert(1), text('</Text>') }),
                node(nil, { text('<Text variant="displaySmall">'), insert(1), text('</Text>') }),

                node(nil, { text('<Text variant="headlineLarge">'), insert(1), text('</Text>') }),
                node(nil, { text('<Text variant="headlineMedium">'), insert(1), text('</Text>') }),
                node(nil, { text('<Text variant="headlineSmall">'), insert(1), text('</Text>') }),

                node(nil, { text('<Text variant="titleLarge">'), insert(1), text('</Text>') }),
                node(nil, { text('<Text variant="titleMedium">'), insert(1), text('</Text>') }),
                node(nil, { text('<Text variant="titleSmall">'), insert(1), text('</Text>') }),

                node(nil, { text('<Text variant="bodyLarge">'), insert(1), text('</Text>') }),
                node(nil, { text('<Text variant="bodyMedium">'), insert(1), text('</Text>') }),
                node(nil, { text('<Text variant="bodySmall">'), insert(1), text('</Text>') }),

                node(nil, { text('<Text variant="labelLarge">'), insert(1), text('</Text>') }),
                node(nil, { text('<Text variant="labelMedium">'), insert(1), text('</Text>') }),
                node(nil, { text('<Text variant="labelSmall">'), insert(1), text('</Text>') }),
            })
        ),

        postfix(".Grid", {
            func(function(_, parent)
                if parent.snippet.env.POSTFIX_MATCH == nil then
                    vim.notify(".Table must trigger by ixj.Table")
                    return
                end

                local row_col = util.split(parent.snippet.env.POSTFIX_MATCH, "x")
                local row_num = tonumber(row_col[1])
                local col_num = tonumber(row_col[2])
                local ret = {}
                table.insert(ret, "<View style={{ flexDirection: 'column', rowGap: 10 }}>")
                for i = 1, row_num do
                    table.insert(ret, "    {/* row " .. i .. " */}")
                    table.insert(ret, "    <View style={{ flexDirection: 'row', columnGap: 10 }}>")
                    for j = 1, col_num do
                        table.insert(ret, "        <View style={{ flex: 1 }}>")
                        table.insert(ret, "            {/* column " .. j .. " */}")
                        table.insert(ret, "        </View>")
                    end
                    table.insert(ret, "    </View>")
                    if i ~= row_num then
                        table.insert(ret, "")
                    end
                end
                table.insert(ret, "</View>")

                return ret
            end, {}),
        }),


        snip('.Divider', { text({ '<Divider leftInset={true} horizontalInset={false} bold={false} />', '' }) }),

        snip(
            {
                trig = '.Progress',
                dscr = util.trim_margin([[
                | # 进度条
                |
                | progress=0.35
                | =======-------------
                |
                ]])
            },
            {
                text('<ProgressBar progress={'),
                insert(1),
                text('} color={MD3Colors.error50} />'),
            }
        ),

        snip('.Badge', { text('<Badge>'), insert(1), text('</Badge>') }),
        snip(
            {
                trig = '.Checkbox',
                dscr = util.trim_margin([[
                |# Checkbox.Item
                |
                |Checkbox.Item allows you to press the whole row (item) instead of only the Checkbox.
                |
                ]])
            },
            {
                text('<Checkbox.Item label="'),
                insert(1),
                text('" status="checked" />'),
            }
        ),

        snip('.Avatar.Icon', { text('<Avatar.Icon size={24} icon="'), insert(1), text('" />') }),
        snip('.Avatar.Text', { text('<Avatar.Icon size={24} label="'), insert(1), text('" />') }),
        snip('.Avatar.Image', { text("<Avatar.Image size={24} source={require('../assets/avatar.png')} />") }),

        snip('.Button', choice(1, {
            node(nil, {
                text('<Button mode="text" icon="'), insert(1),
                text({ '" onPress={() => { }}>', '    Press', '</Button>' }),
            }),
            node(nil, {
                text('<Button mode="outlined" icon="'), insert(1),
                text({ '" onPress={() => { }}>', '    Press', '</Button>' }),
            }),
            node(nil, {
                text('<Button mode="contained" icon="'), insert(1),
                text({ '" onPress={() => { }}>', '    Press', '</Button>' }),
            }),
            node(nil, {
                text('<Button mode="elevated" icon="'), insert(1),
                text({ '" onPress={() => { }}>', '    Press', '</Button>' }),
            }),
            node(nil, {
                text('<Button mode="contained-tonal" icon="'), insert(1),
                text({ '" onPress={() => { }}>', '    Press', '</Button>' }),
            }),
        })),

        snip(
            {
                trig = '.Chip',
                dscr = util.trim_margin([[
                | 标签
                |
                |┏━━━━━━━━━━━━━┓
                |┃  SomeTag  ┃
                |┗━━━━━━━━━━━━━┛
                ]])
            },
            {
                text({ '<Chip icon="' }),
                insert(1),
                text({ '" onPress={() => { }}>', '    Message', '</Chip>' }),
            }),

        snip('.Icon', {
            text({ '<Icon source="' }),
            insert(1),
            text({ '" color={MD3Colors.error50} size={20} />' }),
        }),

        snip(
            {
                trig = '.IconButton',
                dscr = util.trim_margin([[
                   |图标式按钮
                   |
                   | mode = default
                   | mode = outlined
                   | mode = contained
                ]])
            },
            {
                text({ '<IconButton icon="' }),
                insert(1),
                text({ '" iconColor={MD3Colors.error50} size={20} onPress={() => { }} />' }),
            }
        ),

        snip(
            {
                trig = '.Appbar',
                dscr = util.trim_margin([[
                    |App 头部导航菜单
                    |
                    |┏━━━━━━━━━━━━━━━┓
                    |┃    TiTle    󰇙┃
                    |┣━━━━━━━━━━━━━━━┫
                    |┃               ┃
                    |┃               ┃
                    |┗━━━━━━━━━━━━━━━┛
                ]]),
            },
            {
                text({
                    '<Appbar.Header>',
                    [[    <Appbar.BackAction onPress={() => { }} />]],
                    [[    <Appbar.Content title="Title" />]],
                    [[    <Appbar.Action icon="dots-vertical" onPress={() => { }} />]],
                    '</Appbar.Header>', ''
                }),
            }
        ),

        snip(
            {
                trig = '.Card',
                dscr = util.trim_margin([[
                    |卡片视图
                    |
                    |┏━━━━━━━━━━━━━━━┓
                    |┃     图片      ┃
                    |┣━━━━━━━━━━━━━━━┫
                    |┃     内容      ┃
                    |┃            󰅺┃
                    |┗━━━━━━━━━━━━━━━┛
                ]])
            },
            {
                text({
                    [[<Card>]],
                    [[    <Card.Title title="Title" subtitle="Subtitle" />]],
                    [[    <Card.Content>]],
                    [[        <Text variant="bodyMedium">Card content</Text>]],
                    [[    </Card.Content>]],
                    [[    <Card.Cover source={{ uri: 'https://picsum.photos/700' }} />]],
                    [[    <Card.Actions>]],
                    [[        <Button>Cancel</Button>]],
                    [[        <Button>Ok</Button>]],
                    [[    </Card.Actions>]],
                    [[</Card>]], ''
                }),
            }
        ),

        snip(
            {
                trig = '.Dialog',
                dscr = util.trim_margin([[
                    |弹出式对话框
                    |
                    |┏━━━━━━━━━━━━━━━┓
                    |┃              ┃
                    |┃     Title     ┃
                    |┃ Conotext Text ┃
                    |┃             ┃
                    |┗━━━━━━━━━━━━━━━┛
                ]])
            },
            {
                text({
                    [[<Portal>]],
                    [[    <Dialog visible={false} onDismiss={() => { }}>]],
                    [[        <Dialog.Icon icon="alert" />]],
                    [[        <Dialog.Title>Title</Dialog.Title>]],
                    [[        <Dialog.Content>]],
                    [[            <Text variant="bodyMedium">Content</Text>]],
                    [[        </Dialog.Content>]],
                    [[        <Dialog.Actions>]],
                    [[            <Button onPress={() => { }}>Cancel</Button>]],
                    [[            <Button onPress={() => { }}>Ok</Button>]],
                    [[        </Dialog.Actions>]],
                    [[    </Dialog>]],
                    [[</Portal> ]], ''
                }),
            }
        ),

        snip(
            {
                trig = '.Drawer',
                dscr = util.trim_margin([[
                    |侧边栏抽屉
                    |
                    |┏━━━━━━━━━━━┳━━━━━━━━━━━━━━┓
                    |┃ user      ┃    App       ┃
                    |┃  account ┃              ┃
                    |┃ 󰋑 favor   ┃  Content     ┃
                    |┃  share   ┃              ┃
                    |┃           ┃              ┃
                    |┃ system    ┃              ┃
                    |┃  setting ┃              ┃
                    |┃  about   ┃              ┃
                    |┗━━━━━━━━━━━┻━━━━━━━━━━━━━━┛
                ]])
            },
            {
                text({
                    [[<Drawer.Section title="Some title">]],
                    [[    <Drawer.Item]],
                    [[        label="First Item"]],
                    [[        active={true}]],
                    [[        onPress={() => { }}]],
                    [[    />]],
                    [[    <Drawer.Item]],
                    [[        label="Second Item"]],
                    [[        active={false}]],
                    [[        onPress={() => { }}]],
                    [[    />]],
                    [[</Drawer.Section>]],
                }),
            }
        ),


    })
end

return M
