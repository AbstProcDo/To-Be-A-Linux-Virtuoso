# 帮你精通Linux：一切皆为文件的7大属性



在Linux操作系统中，一切皆为文件，因此我们首先来分析文件与文档。

当我们从命令行查看文件属性的时候，可以直观的看到7列信息：

![帮你精通Linux：一切皆为文件的7大属性](images/aaa4c37ce3fd41a8b4f9a2d9c3ee0711)



从一个具体的案例，我们将从右往左详尽分析这七列数据：

![帮你精通Linux：一切皆为文件的7大属性](images/1c3dd6222d604972b87fc38deb832f05)



# 第一列：文件名

自右边数起的第一列，一目了然是文件名01.proj.projects.org_archive 。如下图，最后一列都是文件名:

```
➜  Master git:(master) ✗ ls -alh
total 324K
drwxr-xr-x 1 gaowei gaowei  512 Dec  1 18:19 .
drwxr-xr-x 1 gaowei gaowei  512 Nov 29 14:06 ..
drwxr-xr-x 1 gaowei gaowei  512 Dec  1 08:51 .git
-rwxr--r-- 1 gaowei gaowei 1.7K Aug 22 16:31 .orgids
-rwxr--r-- 1 gaowei gaowei 227K Dec  1 08:51 01.proj.projects.org
-rwxr--r-- 1 gaowei gaowei  849 Nov 21 19:24 01.proj.projects.org_archive
-rwxr--r-- 1 gaowei gaowei  39K Nov 16 14:31 build-vocabulary.org
-rw-r--r-- 1 gaowei gaowei  13K Nov 23 09:35 history-todos.org
-rwxr--r-- 1 gaowei gaowei 8.2K Nov 21 18:30 standard-diary
-rwxr--r-- 1 gaowei gaowei 1.1K Nov 23 13:41 timeline.org
-rwxr--r-- 1 gaowei gaowei  12K Dec  1 07:30 todo.today.org
-rwxr--r-- 1 gaowei gaowei  823 Nov 30 09:38 todo.today.org_archive
```

# 第二列：最新修改的时间

第二列‘Dec 1 08:51’为最近修改的时间(modification  time)，此处也是创建时间。文件的时间属性有三个，修改时间（modification-time简写成mtime），创建时间（creation-time简写成ctime），以及最近一次打开的时间（access-time简写成atime）

使用ls命令分别查看这三个不同的时间属性

```
➜  Master git:(master) ✗ ls -ul 01.proj.projects.org  # -u代表access-time
-rwxr--r-- 1 gaowei gaowei 231577 Dec  1 08:51 01.proj.projects.org
➜  Master git:(master) ✗ ls -cl 01.proj.projects.org  #-c 代表creation-time 创建时间
-rwxr--r-- 1 gaowei gaowei 231577 Dec  1 08:51 01.proj.projects.org
➜  Master git:(master) ✗ ls -ml 01.proj.projects.org  #-m 代表modification-time 修改时间
-rwxr--r-- 1 gaowei gaowei 231577 Dec  1 08:51 01.proj.projects.org
```

如果省略特指的时间属性，则默认按照修改时间列出，

```
➜  Master git:(master) ✗ ls -l 01.proj.projects.org
-rwxr--r-- 1 gaowei gaowei 231577 Dec  1 08:51 01.proj.projects.org
```

简单对比可知，‘ls -l’等同于‘ls -ml’.

# 第三列：文件大小

第三列‘227K’更加直观，乃是文件的大小。默认状态下，文件的大小是以字节（byte）显示：

```
➜  Master git:(master) ✗ ls -al
total 324
drwxr-xr-x 1 gaowei gaowei    512 Dec  1 18:19 .
drwxr-xr-x 1 gaowei gaowei    512 Nov 29 14:06 ..
drwxr-xr-x 1 gaowei gaowei    512 Dec  1 18:24 .git
-rwxr--r-- 1 gaowei gaowei   1727 Aug 22 16:31 .orgids
-rwxr--r-- 1 gaowei gaowei 231577 Dec  1 08:51 01.proj.projects.org
-rwxr--r-- 1 gaowei gaowei    849 Nov 21 19:24 01.proj.projects.org_archive
-rwxr--r-- 1 gaowei gaowei  38993 Nov 16 14:31 build-vocabulary.org
-rw-r--r-- 1 gaowei gaowei  13005 Nov 23 09:35 history-todos.org
-rwxr--r-- 1 gaowei gaowei   8388 Nov 21 18:30 standard-diary
-rwxr--r-- 1 gaowei gaowei   1082 Nov 23 13:41 timeline.org
-rwxr--r-- 1 gaowei gaowei  12108 Dec  1 07:30 todo.today.org
-rwxr--r-- 1 gaowei gaowei    823 Nov 30 09:38 todo.today.org_archive
```

增加‘-h'选项，则以人类可读的模式显示：

```
➜  Master git:(master) ✗ ls -alh
total 324K
drwxr-xr-x 1 gaowei gaowei  512 Dec  1 18:19 .
drwxr-xr-x 1 gaowei gaowei  512 Nov 29 14:06 ..
drwxr-xr-x 1 gaowei gaowei  512 Dec  1 18:24 .git
-rwxr--r-- 1 gaowei gaowei 1.7K Aug 22 16:31 .orgids
-rwxr--r-- 1 gaowei gaowei 227K Dec  1 08:51 01.proj.projects.org
-rwxr--r-- 1 gaowei gaowei  849 Nov 21 19:24 01.proj.projects.org_archive
-rwxr--r-- 1 gaowei gaowei  39K Nov 16 14:31 build-vocabulary.org
-rw-r--r-- 1 gaowei gaowei  13K Nov 23 09:35 history-todos.org
-rwxr--r-- 1 gaowei gaowei 8.2K Nov 21 18:30 standard-diary
-rwxr--r-- 1 gaowei gaowei 1.1K Nov 23 13:41 timeline.org
-rwxr--r-- 1 gaowei gaowei  12K Dec  1 07:30 todo.today.org
-rwxr--r-- 1 gaowei gaowei  823 Nov 30 09:38 todo.today.org_archive
```

# 第四列与第五列分别为用户名和用户组的名称

此处用户即机主本人为‘gaowei’，用户组为‘gaowei’，后文我们将详加阐述。

# 第六列：链接数量

此处的数字1表示文件的链接数量。新建的文件链接数量是1，新建文件夹的连接数量为2。

# 第七列：权限 (Permissions)

第七列是重中之重，我们在此处浓墨重彩，一一加以分析。我们再读一遍整体的信息：

![帮你精通Linux：一切皆为文件的7大属性](images/fa35e2534d574763bb58e2c4cd3044be)



**文件类型**

由图可知，这一列中有10个字符‘-rw-rw-r--’，其中第一个字符代表文件类型，d表示文件夹(directory)等，详见下表：

![帮你精通Linux：一切皆为文件的7大属性](images/15a992dc050b4476bbf0104056074de0)



**分组权限**

后面的9个字符‘rw-rw-r--’是三个组别，分别表示三个不同的用户组的三组权限，见下表：

![帮你精通Linux：一切皆为文件的7大属性](images/6ad583a817b44ad5a1545edab7003df1)



由图可知，二进制最为简单易懂，‘001’为 x（execute）运行权限，‘010’为 w（write）写入或者修改权限，‘100’为 r（读取权限）。

后文，我们将陆续详细阐述Linux操作 系统。