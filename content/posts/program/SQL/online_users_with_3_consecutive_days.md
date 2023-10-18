---
title: "查询连续登陆3天的用户id和登陆天数"
categories: ["编程"]
tags: ["SQL"]
date: 2023-08-01
---
```sql
-- 查询连续登陆3天的用户id和登陆天数
-- step1:用户登录日期去重
select distinct
    user_id,
    date(visit_time) as dt
from cm.tb_user_logs;

-- step2:用row_number()计数
select *,
       row_number() over (PARTITION by user_id order by dt) as xrank
from (select distinct
        user_id,
        date(visit_time) as dt
    from cm.tb_user_logs) a;

-- step3: 日期减去计数值得到差值delta
select *, date_sub(dt, INTERVAL xrank DAY) as delta
from (select *,
             row_number() over (PARTITION by user_id order by dt) as xrank
      from (select distinct
                user_id,
                date(visit_time) as dt
            from cm.tb_user_logs) a
      ) b;

-- step4:根据id和结果分组并计算总和,大于等于3的即为连续登录3天的用户
select user_id, min(dt) as start_date, count(*) as days
from (select *, date_sub(dt, INTERVAL xrank DAY) as delta
      from (select *,
                 row_number() over (PARTITION by user_id order by dt) as xrank
            from (select distinct
                      user_id,
                        date(visit_time) as dt
                  from cm.tb_user_logs) a
            ) b
      ) c
GROUP BY user_id, delta
having count(*) >= 3;
```