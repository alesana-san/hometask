CREATE OR REPLACE FUNCTION get_prc_summ
(
  p_account_code IN VARCHAR2 -- ��� �����
 ,p_start_date   IN DATE -- ���� ������ ���������� ������� (����� ��������� �� ���)
 ,p_end_date     IN DATE -- ���� ��������� ���������� ������� (����� ��������� �� ���)
 ,p_prc_rate     IN NUMBER -- ���������� ������ � ���������, �.�. ���� ������ ����� 10%, �� ���������� 10
) RETURN NUMBER IS
  l_result     NUMBER := 0;
  l_year_days  NUMBER;
  l_start_date DATE := trunc(p_start_date
                            ,'DD');
  l_end_date   DATE := trunc(p_end_date
                            ,'DD');
  l_prev_date  DATE := l_start_date;
  l_amount     NUMBER;
  l_account_id NUMBER;

  CURSOR dates
  (
    c_start_date IN DATE
   ,c_end_date   IN DATE
   ,c_account_id IN NUMBER
  ) IS
    SELECT accounting_day_end
          ,amount
      FROM (
            -- 1. �������� ������� � ������, ����� ����������� ����� ������� �� �����
            SELECT trunc(r.accounting_date
                         ,'DD') accounting_day_end
                   ,(SELECT coalesce(SUM(r1.accounted_sum)
                                    ,0)
                       FROM ow_turnovers r1
                      WHERE r1.account_id = c_account_id
                        AND r1.accounting_date <=
                            trunc(r.accounting_date
                                 ,'DD')) amount
              FROM ow_turnovers r
            
             WHERE 1 = 1
               AND r.account_id = c_account_id
               AND trunc(r.accounting_date
                        ,'DD') BETWEEN c_start_date AND c_end_date - 1
             GROUP BY trunc(r.accounting_date
                            ,'DD')
            
            UNION ALL
            -- 2. ��������� ������� �� ������� ����� (��������� ���� ����)
            SELECT accounting_day_end accounting_day_end
                   ,(SELECT coalesce(SUM(r1.accounted_sum)
                                    ,0)
                       FROM ow_turnovers r1
                      WHERE r1.account_id = c_account_id
                        AND r1.accounting_date <=
                            trunc(r.accounting_day_end
                                 ,'DD')) amount
              FROM (SELECT add_months(trunc(c_start_date
                                            ,'YYYY') - 1
                                      ,12 * (LEVEL - 1)) accounting_day_end
                       FROM dual
                     CONNECT BY LEVEL <=
                                to_number(to_char(c_end_date
                                                 ,'YYYY')) -
                                to_number(to_char(c_start_date
                                                 ,'YYYY')) + 1) r)
     WHERE accounting_day_end > c_start_date -- ��������� ������ �� ���������, ������� ��������� ����� ���� ������ �������������� �������
     ORDER BY 1 ASC; -- ��������� ������� � ������� ���� �����
BEGIN
  -- ���������� ID �����
  SELECT account_id
    INTO l_account_id
    FROM ow_accounts
   WHERE account_code = p_account_code;

  -- ����������� �� ��������� �������
  FOR line IN dates(l_start_date - 1
                   ,l_end_date
                   ,l_account_id)
  LOOP
    -- ������������ ����� ���� � ����, � �������� ����������� ������
    l_year_days := add_months(trunc(line.accounting_day_end
                                   ,'YYYY')
                             ,12) - trunc(line.accounting_day_end
                                         ,'YYYY');
    -- ������������ ���������
    l_result := l_result +
                round((line.accounting_day_end - l_prev_date + 1) *
                      p_prc_rate * line.amount / 100 / l_year_days
                     ,2);
  
    -- ��������� ������� �������� ������ ��� ���������� ��� ��������� �������� �������
    l_prev_date := line.accounting_day_end + 1;
  END LOOP;

  -- ��������� �������� ��� �������� ���� �������������� �������
  l_year_days := add_months(trunc(l_end_date
                                 ,'YYYY')
                           ,12) - trunc(l_end_date
                                       ,'YYYY');

  SELECT coalesce(SUM(r1.accounted_sum)
                 ,0)
    INTO l_amount
    FROM ow_turnovers r1
   WHERE r1.account_id = l_account_id
     AND r1.accounting_date <= trunc(l_end_date
                                    ,'DD');

  l_result := l_result + round((l_end_date - l_prev_date + 1) * p_prc_rate *
                               l_amount / 100 / l_year_days
                              ,2);

  RETURN l_result;
END get_prc_summ;
/
