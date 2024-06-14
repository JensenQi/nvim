// Set Prettier as default formatter in JetBrains IDEA
// 1. Open the `Settings` dialog, go to `Languages & Frameworks | JavaScript | Prettier`.
// 2. Select `Manual Prettier configuration` and then select the `Run on 'Reformat Code'` action checkbox.
// 3. Choose the Prettier package and configuration file.
module.exports = {
    tabWidth: 4, // 缩进空格数
    printWidth: 120, // 每行长度约束
    arrowParens: 'avoid', //  (x) => {} 箭头函数参数只有一个时是否要有小括号。avoid：省略括号
    endOfLine: "auto", // 结尾是 \n \r \n\r auto
    bracketSameLine: true,
    bracketSpacing: true,
    singleQuote: true,
    trailingComma: 'all',
};

