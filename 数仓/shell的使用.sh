1.
字符串截取（不匹配字符）
符号	含义解析
${string#substring}	从变量${string}的开头, 删除最短匹配${substring}的子串
${string##substring}	从变量${string}的开头, 删除最长匹配${substring}的子串
${string%substring}	从变量${string}的结尾, 删除最短匹配${substring}的子串
${string%%substring}	从变量${string}的结尾, 删除最长匹配${substring}的子串
我们可以总结一下规律：
换句话来说，＃总是表示左边算起，％总是表示右边算起；一个符号表示最短匹配，两个符号表示最长匹配。