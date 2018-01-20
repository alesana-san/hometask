-- текущий остаток по всем счетам
-- если раскомментировать условие по ограничению на счет, можно получить остаток по указанному счету
SELECT oa.account_code
      ,coalesce(SUM(ot.accounted_sum)
               ,0) end_amount
  FROM ow_turnovers ot
  JOIN ow_accounts oa
    ON ot.account_id = oa.account_id
 WHERE 1 = 1
-- AND oa.account_code = '92'
 GROUP BY oa.account_code
 ORDER BY 1;

-- остаток по всем счетам на указанную дату (01.02.2017)
-- если раскомментировать условие по ограничению на счет, можно получить остаток по указанному счету
SELECT oa.account_code
      ,coalesce(SUM(ot.accounted_sum)
               ,0) end_amount
  FROM ow_turnovers ot
  JOIN ow_accounts oa
    ON ot.account_id = oa.account_id
 WHERE 1 = 1
      --  AND oa.account_code = '92'
   AND ot.accounting_date <= DATE '2017-02-01'
 GROUP BY oa.account_code
 ORDER BY 1;


-- оборот (Кт, Дт) по всем счетам на указанный период времени (01.01.2017 - 01.02.2017)
-- если раскомментировать условие по ограничению на счет, можно получить оборот по указанному счету
SELECT oa.account_code
      ,coalesce(SUM(decode(sign(ot.accounted_sum)
                          ,1
                          ,ot.accounted_sum
                          ,0))
               ,0) plus_amount
      ,coalesce(SUM(decode(sign(ot.accounted_sum)
                          ,-1
                          ,-1 * ot.accounted_sum
                          ,0))
               ,0) minus_amount
  FROM ow_turnovers ot
  JOIN ow_accounts oa
    ON ot.account_id = oa.account_id
 WHERE 1 = 1
      --  AND oa.account_code = '92'
   AND ot.accounting_date BETWEEN
       DATE '2017-01-01' AND DATE '2017-02-01'
 GROUP BY oa.account_code
 ORDER BY 1;
