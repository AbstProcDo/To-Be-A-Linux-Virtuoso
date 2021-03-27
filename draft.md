# 帮你精通Linux：Find命令高阶操作4项动作



前文中，我们详细阐述了Linux中最复杂的Find命令的基础查询之八列属性：

[帮你精通Linux：Find命令的八大属性](https://www.toutiao.com/i6903147121009164812/?group_id=6903147121009164812) 

![image-20210327193849942](images/image-20210327193849942.png)



本文将继续探讨其高级查询功能，将分为四个方面展开讨论：

1. 预定义动作 Predefined-Actions
2. 自定义动作 User-defined Actions
3. 与grep协同动作
4. Operator逻辑操作

# 一、预定义动作 Predefined Actions

搜索是第一步，第二步是处理搜索的结果。比如删除所有的搜索结果。

在Documents目录下，搜索空文档，然后删除。

```
$ find ~/Documents -maxdepth 3 -empty -type f |nl
```

删除操作需要第二步处理，我们使用循环结构和 read 命令

```
find ~/Documents -maxdepth 3 -empty -type f | while read line; do rm $line; done
```

为了避免每次都写上 while read line; do rm $line; done 这一段，Find 命令提供了很多定义的行为。拿上面删除搜索结果例子而言，只需后面加上 -delete 即可

```
find ~/Documents -maxdepth 3 -empty -type f -delete
```

我们前面已经接触到了 -ls 这个预定义的行为

```
find ~/Documents -maxdepth 3 -empty -type f -ls
```


其他的预定义动作还有：

1) -print 打印当前的结果到标准输出 (Terminal)，这是默认的行为，不需要显式标注

2) -print0 是文件名中的空格等换行符用空值表示，与xargs 的 -0 配合使用。

3) -quit 匹配到一个结果后退出查询。

# 二、自定义动作 User-defined Actions

-print -ls 这些自定义动作，虽然很便捷，但其灵活性差的弊端也显著。比如上例中的 -ls 只有一种显示格式。

 **-exec (execute) 自定义执行**

当需要更灵活多样的显示格式，需要引入 -exec (execute)

```
find ~/Documents -maxdepth 3 -empty -type f -exec ls -lh '{}' ';'
```

'{}' 指代前面所有的搜索结果，可以理解为前面的查询结果都放入到了 {} 这个篮子里，后面的 ；为命令分割符。

**ok代替exec**

exec 的替代选项是 -ok，每次执行前都会弹出提示要用户确认。处理删除任务时，-ok 是更加安全的选项。

```
find ~/Documents -maxdepth 3 -empty -type f -ok rm '{}' ';'
```

 **+ 结束符**

除了有以 ; 为命令的结束符，之外还有一个 + 结束符。

```
find ~/Documents -maxdepth 3 -empty -type f -ok ls -lh '{}' +
```

二者之间的区别是，当以 ； 结尾时，程序的实际执行过程为:

```
ls -lh file1
ls -lh file2
ls -lh file3
...
```

也就是对每个搜索结果逐个执行 ls 命令操作，这通常效率不高。而以 + 结尾则对上搜索就结果执行一次 ls 操作。

```
ls -lh file1 file2 file3 ...
```

同时还有与 xargs 相结合的方案，不推荐此方法，捎带提一句。

```
find ~/Documents -maxdepth 3 -empty -type f | xargs -lh
# 等同于
find ~/Documents -maxdepth 3 -empty -type f -ok ls -lh '{}' +
```

# 三、与 grep 命令协同工作 搜索 Book.SICP 目录下所有包含关键词‘洞见’的文件，执行以下命令：

```
find . -type f -exec grep --color -nH --null -e '洞见' \{\} +
```

得到结果为：

![帮你精通Linux：Find命令高阶操作4项动作](images/6c46aa6bf0d84e19aa2915c749fa99f1)



![帮你精通Linux：Find命令高阶操作4项动作](images/f4d15e5314244f28a598c9c02f3eff46)



# 四、逻辑操作

三种逻辑操作在 Find 命令中的选项分别为 -and(a), -or(o), -not

比如我们在上一讲中，提到查询各种类型的文件格式

```
find ~ -type f,d,l
```

使用’或‘逻辑将其改写为：

```
find ~ \( -type f -or -type d -or -type l \)
```

-not 的案例

```
find ~ \( -type f -not -perms 0600\) -or \( -type d -not -perms 0700 \)
```

-and 与逻辑是默认执行动作。

使用逻辑关系的基本表达是为：

```
expr1 -operator expr2
```

# 五、总结

我们以文件的七列属性为蓝本，逐次探讨了Find的八个基本查询功能，以及四个高阶应用，总结如下：

![帮你精通Linux：Find命令高阶操作4项动作](images/6d047d4f34914751a60fd67de98096e9)

find 总结

```
|----------+----------+----------------------------------------|
|     列号 | 名称     | 方法                                   |
|----------+----------+----------------------------------------|
|        1 | 文件名   | -iname, -ipath, -regex                 |
|----------+----------+----------------------------------------|
|        2 | 时间戳   | -mtime(atime,ctime); -mmin(amin, cmin) |
|----------+----------+----------------------------------------|
|        3 | 文件大小 | -size(b,c,k,M,G)                       |
|----------+----------+----------------------------------------|
|        4 | 用户组   | -group                                 |
|----------+----------+----------------------------------------|
|        5 | 用户     | -user                                  |
|----------+----------+----------------------------------------|
|        6 | inode    | -inum                                  |
|----------+----------+----------------------------------------|
|        7 | 权限     | -type, -perm                           |
|----------+----------+----------------------------------------|
|        8 | 深度     | -mindepth，-maxdepth                   |
|----------+----------+----------------------------------------|
|  Actions | 预定义   | -delete, -ls, -print, -print0          |
|----------+----------+----------------------------------------|
|  Actions | 自定义   | -exec, -ok, xargs                      |
|----------+----------+----------------------------------------|
|  Actions | 协同     | 与 grep 协同                           |
|----------+----------+----------------------------------------|
| Operator | 逻辑操作 | -and, -or, -not                        |
|----------+----------+----------------------------------------  
```

以上为 Find 查询的全部内容。