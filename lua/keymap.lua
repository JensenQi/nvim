local M = {
    goto_file_explorer = "<Leader>`",             -- [normal] 跳转到文件管理器
    goto_tab1 = "<Leader>1",                      -- [normal] 跳转到编号为 1 的 Tab 页
    goto_tab2 = "<Leader>2",                      -- [normal] 跳转到编号为 2 的 Tab 页
    goto_tab3 = "<Leader>3",                      -- [normal] 跳转到编号为 3 的 Tab 页
    goto_tab4 = "<Leader>4",                      -- [normal] 跳转到编号为 4 的 Tab 页
    goto_tab5 = "<Leader>5",                      -- [normal] 跳转到编号为 5 的 Tab 页
    goto_tab6 = "<Leader>6",                      -- [normal] 跳转到编号为 6 的 Tab 页
    goto_left_tab = "<Leader>h",                  -- [normal] 跳转到左边的 Tab 页
    goto_right_tab = "<Leader>l",                 -- [normal] 跳转到右边 Tab 页
    close_current_tab = "<Leader><backspace>",    -- [normal] 关闭当前 Tab 页
    close_other_tab = "<Leader><down>",           -- [normal] 关闭其他 Tab 页
    close_left_tab = "<Leader><left>",            -- [normal] 关闭左侧 Tab 页
    close_right_tab = "<Leader><right>",          -- [normal] 关闭右侧 Tab 页
    word_highlight = "<Leader>f",                 -- [normal]搜索高亮当前词
    word_cancel_highlight = "<Leader>F",          -- [normal]关闭高亮搜索词
    open_git_blame = "<esc>v",                    -- [normal]打开 git blame 面板
    open_todo = "<esc>t",                         -- 打开 todo 列表
    open_terminal = "<esc>\\",                    -- [normal,insert] 打开控制台面板
    open_commander = "<esc>r",                    -- [normal] 打开自定义快捷命令面板
    exec_run_command = "<F5>",                    -- 执行项目 Run 命令
    exec_build_command = "<F4>",                  -- 执行项目 Build 命令
    exec_release_command = "<F10>",               -- 执行项目打包命令
    find_file = "<esc>o",                         -- [normal] 查找文件
    find_file_hisotry = "<esc>h",                 -- [normal] 查看文件本地变更历史
    find_string = "<C-F>",                        -- 全局搜索字符串
    goto_next_problem = '<A-n>',                  -- [normal] 跳转到当前文件中下一个代码有问题的地方
    goto_definition = 'gd',                       -- [normal] 跳转到函数或变量定义的地方
    go_back = "gb",                               -- [normal] 跳回跳转前的地方
    goto_class_definition = 'gc',                 -- 跳转到类定义的地方
    goto_preview = 'gp',                          -- [normal] 显示函数预览
    close_preview = "<esc>",                      -- [normal] 关闭函数预览
    find_usage = "gu",                            -- [normal] 查看函数或变量的引用
    usage_jump = "<CR>",                          -- [normal] 跳转到引用处
    usage_edit = "<Tab>",                         -- [normal] 编辑引用出
    close_find_usage = "<esc>",                   -- [normal] 关闭引用列表
    find_implement = "gi",                        -- [normal] 查看接口的继承
    code_action = "<A-Enter>",                    -- [normal] 列举修复建议
    close_code_action = "<esc>",                  -- [normal] 变比修复建议
    code_action_confirm = "<CR>",                 -- [normal] 执行修复建议
    code_complete = "<A-Enter>",                  -- [normal] 列举自动补全项
    focus_code_complete = "<C-j>",                -- [insert] 跳入代码补全候选单
    next_code_complete = "j",                     -- [insert] 移动到下一个补全项
    pre_code_complete = "k",                      -- [insert] 移动到上一个补全项
    complete_confirm_or_jump_next_slot = "<Tab>", -- [insert] 执行自动补全并跳到模板的下一个插槽
    complete_confirm = "<CR>",                    -- [insert] 执行自动补全
    refactor_name = '<s-r>',                      -- [normal]变量或函数重命名
    refactor_confirm = "<CR>",                    -- [normal] 执行变量或函数重命名
    close_refactor = "<esc>",
    format_file = "<C-A-L>",                      -- 格式化文件
    goto_test_file = "gt",                        --[normal] 跳转到测试文件
    goto_source_file = "gs",                      -- [normal] 跳转到源文件
    goto_header_file = "gh",                      -- [normal] 跳转到头文件
    goto_vsc_diff = "gv",                         -- git 变更预览
    comment_current_line = "<C-_>",               -- [normal] 注释当前行，并将光标移动到下一行
    comment_block = "<C-_>",                      -- [normal] 注释当前选中块
    increase_vis_block = "v",                     -- [normal] 扩大当前选中块
    decrease_vis_block = "V",                     -- [normal] 缩小当前选中块
    switch_file_explorer_and_editor = '<C-e>',    -- [normal] 窗口切换
    file_explorer_preview = '<Tab>',              -- [normal] 文件预览
    file_explorer_edit = '<CR>',                  -- [normal] 打开文件并进入编辑
    file_explorer_close_parent_dir = 'zc',        -- [normal] 折叠父文件夹
    file_explorer_close_all_dir = 'xx',           -- [normal] 折叠所有文件夹
    file_explorer_create = 'nn',                  -- [normal] 新建文件或文件夹
    file_explorer_goto_parent = 'gg',             -- [normal] 跳转到父文件夹
    file_explorer_rename = 'rr',                  -- [normal] 重命名文件或文件夹
    file_explorer_remove = 'DD',                  -- [normal] 删除文件或文件夹
    file_explorer_trash = 'dd',                   -- [normal] 将文件或文件夹移动到回收站
    file_explorer_copy = 'yy',                    -- [normal] 复制文件或文件夹
    file_explorer_cut = 'cc',                     -- [normal] 剪切文件或文件夹
    file_explorer_paste = 'p',                    -- [normal] 粘贴文件或文件夹
    file_explorer_show_info = '?',                -- [normal] 预览文件或文件夹元数据
    file_explorer_reload = 'R',                   -- [normal] 刷新文件系统
    open_outline = '<esc>[]',                     -- [normal] 打开代码大纲
    close_outline = '<esc>',                      -- [normal] 关闭代码大纲
    outline_goto_next_line = 'j',                 -- [normal] 移动到大纲中下一个 scope
    outline_goto_prev_line = 'k',                 -- [normal] 移动到大纲中上一个 scope
    goto_prev_object = '[',                       -- [normal] 移动到大纲中上一个 scope
    goto_next_object = ']',                       -- [normal] 移动到大纲中下一个 scope
    add_or_remove_bookmark = "mm",                -- [normal] 添加或删除书签
    edit_bookmark = "mi",                         -- [normal] 编辑书签
    remove_curr_buf_bookmark = "dm",              -- [normal] 删除当前缓冲区书签
    list_all_bookmarks = "<esc>m",                -- [normal] 列出所有书签
    leap_jump_forward = "s",                      -- [normal] 向下快速跳转
    leap_jump_backward = "S",                     -- [normal] 向上快速跳转
    tree_join = "<C-j>",                          -- [normal] 基于语法树的 join 或展开
    list_yank_list = "<esc>p",                    -- [normal]列出所有yank
    pre_yank = "<Tab>",                           -- [normal] 选择上一个yank
    nex_yank = "<s-Tab>",                         -- [normal] 选择下一个yank
}

function M.map2fun(mode, key, fun, opt)
    opt = opt or { noremap = true, silent = true }
    vim.keymap.set(mode, key, fun, opt)
end

function M.map2cmd(mode, key, cmd, opt)
    opt = opt or { noremap = true, silent = true }
    vim.api.nvim_set_keymap(mode, key, cmd, opt)
end

function M.init()
    vim.g.mapleader = " "         -- Leader Key 设置为空格
    vim.g.maplocalleader = " "
    vim.opt.timeoutlen = 400      -- leader & esc 等待延迟时长(ms)
    M.map2cmd("n", "<Space>", "") -- 关闭空格键的移动, 仅作为 Leader 键

    M.map2cmd("n", "j", "gj")
    M.map2cmd("n", "k", "gk")
    M.map2cmd("n", "$", "g$")
    M.map2cmd("n", "0", "g0")
    M.map2cmd("n", "qq", '<CMD>wqall<CR>')
end

return M
