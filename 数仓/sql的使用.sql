--#--
1.注意where 后面使用 not  时 ("字符1","字符2",null)注意null的情况，false or null的结果是null,TRUE or null 的结果是TRUE。

2.regexp_replace的使用
regexp_replace(trim(adjust_id),'\\t',''), 
regexp_replace是替换字符，trim(adjust_id)中的\t使用''代替。

3./*+ MAPJOIN(b)*/ 的使用
今天遇到一个hive的问题，如下hive sql：
select f.a,f.b from A t join B f  on ( f.a=t.a and f.ftime=20110802)  
该语句中B表有30亿行记录，A表只有100行记录，而且B表中数据倾斜特别严重，有一个key上有15亿行记录，在运行过程中特别的慢，而且在reduece的过程中遇有内存不够而报错。
为了解决用户的这个问题，考虑使用mapjoin,mapjoin的原理：
MAPJION会把小表全部读入内存中，在map阶段直接拿另外一个表的数据和内存中表数据做匹配，由于在map是进行了join操作，省去了reduce运行的效率也会高很多
这样就不会由于数据倾斜导致某个reduce上落数据太多而失败。于是原来的sql可以通过使用hint的方式指定join时使用mapjoin。
select /*+ mapjoin(A)*/ f.a,f.b from A t join B f  on ( f.a=t.a and f.ftime=20110802) 
再运行发现执行的效率比以前的写法高了好多。
mapjoin还有一个很大的好处是能够进行不等连接的join操作，如果将不等条件写在where中，那么mapreduce过程中会进行笛卡尔积，运行效率特别低，如果使用mapjoin操作，在map的过程中就完成了不等值的join操作，效率会高很多。
例子：
select A.a ,A.b from A join B where A.a>B.a
简单总结一下，mapjoin的使用场景：
1. 关联操作中有一张表非常小
2.不等值的链接操作
