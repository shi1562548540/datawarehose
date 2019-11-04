--#--
--1.注意where 后面使用 not  时 ("字符1","字符2",null)注意null的情况，false or null的结果是null,TRUE or null 的结果是TRUE。

--2.
regexp_replace(trim(adjust_id),'\\t',''), 
regexp_replace是替换字符，trim(adjust_id)中的\t使用''代替。