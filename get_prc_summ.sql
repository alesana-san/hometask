-- краеугольные кейсы:
-- не было оборотов за период
-- обороты были в граничные дни
CREATE OR REPLACE FUNCTION get_prc_summ
(
  p_account_id IN NUMBER
 ,p_start_date IN DATE
 ,p_end_date   IN DATE
 ,p_prc_rate   IN NUMBER
) RETURN NUMBER IS
  l_result     NUMBER;
  l_start_date DATE := trunc(p_start_date
                            ,'DD') - 1;
  l_end_date   DATE := trunc(p_end_date
                            ,'DD');
BEGIN
  WITH p AS
   (SELECT l_start_date start_date
          ,l_end_date   end_date
      FROM dual),
  periods AS
   (SELECT lag(trunc(r.accounting_date
                    ,'DD')
              ,1
              ,p.start_date) over(ORDER BY trunc(r.accounting_date, 'DD') ASC) + 1 accounting_day_start
          ,trunc(r.accounting_date
                ,'DD') accounting_day_end
          ,(SELECT coalesce(SUM(r1.accounted_sum)
                           ,0)
              FROM ow_turnovers r1
             WHERE r1.account_id = r.account_id
               AND r1.accounting_date <= trunc(r.accounting_date
                                              ,'DD')) amount
      FROM ow_turnovers r
      JOIN p
        ON trunc(r.accounting_date
                ,'DD') BETWEEN p.start_date AND p.end_date - 1
     WHERE 1 = 1
       AND r.account_id = p_account_id
     GROUP BY trunc(r.accounting_date
                   ,'DD')
             ,r.account_id
             ,p.start_date
    
    UNION ALL
    
    SELECT t.accounting_day_start
          ,t.accounting_day_end
          ,(SELECT coalesce(SUM(r1.accounted_sum)
                           ,0)
              FROM ow_turnovers r1
             WHERE r1.account_id = t.account_id
               AND r1.accounting_date <= t.accounting_day_end) amount
    
      FROM (SELECT nvl(MAX(trunc(r.accounting_date
                                ,'DD'))
                       keep(dense_rank FIRST ORDER BY trunc(r.accounting_date
                                 ,'DD') DESC)
                      ,MAX(p.start_date)) + 1 accounting_day_start
                  ,MAX(p.end_date) accounting_day_end
                  ,MAX(r.account_id) account_id
              FROM ow_turnovers r
              JOIN p
                ON trunc(r.accounting_date
                        ,'DD') BETWEEN p.start_date AND p.end_date - 1
             WHERE 1 = 1
               AND r.account_id = p_account_id) t
    
    )
  SELECT coalesce(SUM((r.accounting_day_end - r.accounting_day_start + 1) *
                      p_prc_rate * r.amount / 365)
                 ,0)
    INTO l_result
    FROM periods r;

  RETURN l_result;
END get_prc_summ;
/
