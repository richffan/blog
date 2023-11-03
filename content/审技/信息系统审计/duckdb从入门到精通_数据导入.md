---
title: duckdb从入门到精通：数据导入
type: posts
categories: [审技]
tags: [IT审计]
date: 2023-05-05 14:19:09
---

### 数据导入

这里我们都以 csv 文件举例，如果你需要导入 excel 文件，需要先转换成 csv 文件（后面我们会介绍 xlsx2csv 工具）。


#### 读取文件

实际上，duckdb 可以不导入到数据库中，就可以直接查询。

我们先“新建 SQL 编辑器”，这样我们就可以在里面写 SQL 语句了。



我们使用一个电商数据集<a href="#citeproc_bib_item_1">[1]</a>，在编辑器中输入代码：

```sql
select * from "C:\Users\data.csv"
```

直接可以查询出数据结果，而不需要像一般数据库需要先建表、导入数据后才能查询。

从这一点可以看出是非常简洁、方便的。


#### 智能导数 read_csv_auto

一般来说，如果一张表我们要经常查询还是需要将其导入到数据库中。

这时我们可以使用read_csv_auto函数，智能创建表并导入到数据库中。

```sql
create table ecommerce as select * from read_csv_auto('input.csv');
```


我们打开数据库，可以看到出现了刚新建的表`ecommerce`，双击后，点击`数据`选项卡，能够查看导入的数据。


这个导数的过程非常智能，快速，比 mysql 导入速度快了不少。


##### 导入报错解决方法

由于它是根据前面几行自动判断数据类型，可能会出现后面的数据不符合数据类型而导致出错的情况。

如：

```sql
SQL Error: Invalid Input Error: Could not convert string '2.03.19' to DOUBLE in column "物料编码", at line 577268.
```

这个报错就是第 577268 行，不符合智能创建的表的该字段的数据类型。

这里我们可以参考官方文档的[参数列表](https://duckdb.org/docs/data/csv/overview.html)中的sample_size参数 <a href="#citeproc_bib_item_2">[2]</a>，让智能判断时参考多一些行数。

```sql
CREATE TABLE new_tbl AS SELECT * FROM read_csv_auto('input.csv', sample_size=600000);
```

这就会参考 60 万行数据，来创建合适的数据类型。或者设置`sample_size=-1`，这样可以参数数据中的所有行，来创建适当的数据类型。

当然也可以使用参数`all_varchar=1`，让所有数据以 varchar 的文本类型导入数据库，不过不建议这样做，因为无法对数字和日期进行计算。

需要注意的是 duckdb 和 mysql 不同的是需要设置严格的数据类型，例如， mysql 中 varchar 文本类型也是可以计算的，但是在 duckdb 只就不能进行计算。所以，我们需要在建表时设置正确的数据类型，数字就设置成数字类型，日期时间设置成日期时间的类型。

假如数据中有`双引号包裹的千分符数字`，如"12,345.23"，这对 duckdb来说是文本格式，将不能参与计算，为了能导入成数字格式，我们需要先将原文件中双引号中的逗号删除，可以在终端中使用 sed 命令来完成。

( 注：linux,mac 终端中可以使用 sed 命令，Windows 可以安装wsl linux子系统使用终端 sed 命令）


##### 删除引号内数字中逗号

如果你想替换原文件，你可以使用 -i 选项来实现原地修改，例如：

```bash
sed -i 's/\("\)\([^",]\+\),\([^"]\+\)\("\)/\1\2\3\4/g' file
```

例如，将1,2,3,"45,678.00" 转换成1,2,3,"45678.00"

这个命令会在修改data.csv文件的同时，生成一个data.csv.bak文件作为备份。


### xlsx2csv


#### 安装

xlsx2csv 是一个将 excel 文件转 csv 文件的 python 包。

安装方法：

```bash
pip install xlsx2csv
```


#### 基础使用

在终端中将`input_name.xlsx`转换成`output_name.csv`：

```bash
xlsx2csv input_name.xlsx output_name.csv
```

上述命令只会转换工作簿的第一张表，如果你需要转换的 xlsx 中是有多个表，那么可以使用`-a`参数：

```bash
xlsx2csv -a input_name.xlsx output_dir_name
```

将会把`input_name.xlsx`文件所以表转换输出到`output_dir_name`文件夹下。

如果你要将一个文件夹下所有的工作簿转换成 csv 可以使用：

```bash
xlsx2csv /path/to/input/dir /path/to/output/dir
```

同样的，如果文件中有多个工作表，需要使用`-a`参数将所有的工作表转出。


### 参考资料

<style>.csl-left-margin{float: left; padding-right: 0em;}
 .csl-right-inline{margin: 0 0 0 1em;}</style><div class="csl-bib-body">
  <div class="csl-entry"><a id="citeproc_bib_item_1"></a>
    <div class="csl-left-margin">[1]</div><div class="csl-right-inline">nigo81, “nigo81/IT-Audit-Resources,” <i>Gitee</i>. https://gitee.com/nigo81/it-audit-resources.</div>
  </div>
  <div class="csl-entry"><a id="citeproc_bib_item_2"></a>
    <div class="csl-left-margin">[2]</div><div class="csl-right-inline">“CSV Loading,” <i>Duckdb</i>. https://duckdb.org/docs/data/csv/overview.html.</div>
  </div>
</div>
