
## 插件列表

* [aerial](https://github.com/stevearc/aerial.nvim.git): 代码大纲概览
* [auto-save](https://github.com/okuuva/auto-save.nvim.git): 文件自动保存
* [auto-session](https://github.com/rmagatti/auto-session.git): 会话管理
* [nvim-autopairs](https://github.com/windwp/nvim-autopairs): 括号自动补全
* [bufferline](https://github.com/akinsho/bufferline.nvim.git): tab 页管理
* [catppuccin](https://github.com/catppuccin/nvim.git): UI 主题风格
* [coc.nvim](https://github.com/neoclide/coc.nvim.git): 自动补全
* [vim-snippets](https://github.com/honza/vim-snippets.git): 代码片段
* [commander.nvim](https://github.com/FeiyouG/commander.nvim.git): 快捷命令管理
* [Comment.nvim](https://github.com/numToStr/Comment.nvim.git): 快捷注释
* [vim-expand-region](https://github.com/terryma/vim-expand-region.git): 快速扩大选择块
* [gitsigns](https://github.com/lewis6991/gitsigns.nvim.git): 状态栏显示 git 状态
* [blame.nvim](https://github.com/FabijanZulj/blame.nvim.git): git blame 管理
* [indent-blankline](https://github.com/lukas-reineke/indent-blankline.nvim.git): 块缩进提示
* [interestingwords](https://github.com/Mr-LLLLL/interestingwords.nvim.git): 快速高亮搜索词
* [leap.nvim](https://github.com/ggandor/leap.nvim.git): 光标快速跳转
* [lualine](https://github.com/nvim-lualine/lualine.nvim.git): 状态栏
* [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua.git): 文件管理
* [pretty-fold](https://github.com/anuvyklack/pretty-fold.nvim.git): 美化折叠样式
* [vim-startuptime](https://github.com/dstein64/vim-startuptime.git): 启动时间分析
* [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim.git): 全局文件/字符串搜索
* [todo-comments](https://github.com/folke/todo-comments.nvim.git): todo 注释高亮
* [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim.git): 编辑器内嵌终端
* [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter.git): 基于语法的代码高亮
* [wilder.nvim](https://github.com/gelguy/wilder.nvim.git): 命令模式自动提示 + 搜索模式界面美化


## 支持语言

以下语言支持自动补全和代码跳转

* C/C++: 通过 clangd 实现
* Rust: 通过 rust-analyzer 实现
* Java: 通过 jdt.ls 实现
* Scala: 通过 metals 实现
* Go: 通过 gols 实现
* Python: 通过 pyright 实现
* JavaScript/TypeScript: 通过 tsserver 实现
* Lua: 通过 sumneko 实现

## 快捷键

| 作用域    | 快捷键            | 操作详情                                       | 依赖插件     |
|-----------|-------------------|------------------------------------------------|--------------|
| 编辑区    | space + []        | 打开函数列表                                   | aerial       |
| 编辑区    | alt + [           | 上一个函数                                     | aerial       |
| 编辑区    | alt + ]           | 下一个函数                                     | aerial       |
| 函数概览区| j                 | 上一个函数                                     | aerial       |
| 函数概览区| k                 | 下一个函数                                     | aerial       |
| 函数概览区| esc + esc         | 关闭函数预览区                                 | aerial       |
| 函数概览区| q                 | 关闭函数预览区                                 | aerial       |
| 编辑区    | space + 1~6       | 切换到对应数字的 tab 页                        | bufferline   |
| 编辑区    | space + `         | 切换到文件导航区                               | bufferline   |
| 编辑区    | space + h         | 切换到左边的 tab 页                            | bufferline   |
| 编辑区    | space + l         | 切换到右边的 tab 页                            | bufferline   |
| 编辑区    | space + backspace | 关闭当前 tab 页                                | bufferline   |
| 编辑区    | space + ↓         | 关闭其他所有 tab 页                            | bufferline   |
| 编辑区    | space + ←         | 关闭左侧所有 tab 页                            | bufferline   |
| 编辑区    | space + →         | 关闭右侧所有 tab 页                            | bufferline   |
| 编辑区    | space + v         | 打开/关闭 git blame                            | blame        |
| 编辑区    | esc / q           | 关闭 git blame                                 | blame        |
| Blame 区  | tab               | git blame 压栈                                 | blame        |
| Blame 区  | backspace         | git blame 出栈                                 | blame        |
| Blame 区  | i                 | 查看 commit 简介                               | blame        |
| Blame 区  | enter             | 查看 commit diff                               | blame        |
| 编辑区    | esc + o           | 查找文件, 按 enter 后打开                      | telescope    |
| 编辑区    | esc + h           | 查看文件更改历史, 约等于 idea 的 local history | telescope    |
| 编辑区    | esc + p           | 打开自定义命令行面板                           | commander    |


## 功能

### 自动保存(auto-save)

当编辑区失去焦点时，自动执行文件保存操作, 失去焦点的事件包括:

* 由编辑区切换到文件区
* 切换 tab 页
* 关闭 tab 页
* 切换到命令模式
* 打开 telescope
* 打开 commander

当触发自动保存时，会自动检查文件的最后一行，如果最后一行不是空行，则自动追加一个空行

### 会话恢复(auto-session)

当关闭 nvim 后，当前打开的文件以及最近打开的 tab 会自动保存到当前项目空间下的 `.vim/session` 文件下，下一次打开时自动恢复最近打开的文件，并将 tab 焦点切换到关闭时的焦点上。

如果因为某些原因使得 session 文件破坏，导致 session 恢复失败，那么手动删除 `.vim/session` 文件，然后再进入 nvim 即可，此时所有的 session 被清空，相当于 session 恢复初始状态。



