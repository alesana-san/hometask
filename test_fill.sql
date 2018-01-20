DELETE FROM ow_accounts;
-- �������� ������ �� ������
INSERT INTO ow_accounts
  (account_id
  ,account_code
  ,creation_date)
  SELECT ow_accounts_s.nextval account_id
        ,t.account_code
        ,SYSDATE + dbms_random.value(-200
                                    ,-100) creation_date
    FROM (SELECT '92' account_code
            FROM dual
          UNION ALL
          SELECT '95'
            FROM dual
          UNION ALL
          SELECT '97'
            FROM dual
          UNION ALL
          SELECT '91'
            FROM dual
          UNION ALL
          SELECT '90'
            FROM dual
          UNION ALL
          SELECT '98'
            FROM dual) t
   WHERE NOT EXISTS (SELECT 1
            FROM ow_accounts r
           WHERE t.account_code = r.account_code);

DELETE FROM ow_turnovers;
-- �������� ������ �� ��������
INSERT INTO ow_turnovers
  (account_id
  ,accounted_sum
  ,accounting_date
  ,comments)
  SELECT 45
        ,139.39
        ,DATE '2017-10-22'
        ,'��������� ���������� �����'
    FROM dual
  UNION ALL
  SELECT 45
        ,841.23
        ,DATE '2017-11-19'
        ,'������� �� ����� 90 �� ���� 92'
    FROM dual
  UNION ALL
  SELECT 45
        ,-304.95
        ,DATE '2017-11-02'
        ,'������� �� ����� 92 �� ���� 97'
    FROM dual
  UNION ALL
  SELECT 45
        ,-814.95
        ,DATE '2018-01-10'
        ,'�������� �������� �������'
    FROM dual
  UNION ALL
  SELECT 46
        ,273.25
        ,DATE '2017-10-16'
        ,'��������� ���������� �����'
    FROM dual
  UNION ALL
  SELECT 46
        ,863.26
        ,DATE '2017-11-25'
        ,'������� �� ����� 97 �� ���� 95'
    FROM dual
  UNION ALL
  SELECT 46
        ,-557.19
        ,DATE '2018-01-13'
        ,'�������� �������� �������'
    FROM dual
  UNION ALL
  SELECT 47
        ,304.95
        ,DATE '2017-11-02'
        ,'������� �� ����� 92 �� ���� 97'
    FROM dual
  UNION ALL
  SELECT 47
        ,406.21
        ,DATE '2017-12-27'
        ,'������� �� ����� 98 �� ���� 97'
    FROM dual
  UNION ALL
  SELECT 47
        ,959.32
        ,DATE '2017-10-26'
        ,'��������� ���������� �����'
    FROM dual
  UNION ALL
  SELECT 47
        ,-390.91
        ,DATE '2018-01-19'
        ,'�������� �������� �������'
    FROM dual
  UNION ALL
  SELECT 47
        ,-632.42
        ,DATE '2017-12-13'
        ,'������� �� ����� 97 �� ���� 90'
    FROM dual
  UNION ALL
  SELECT 47
        ,-835.08
        ,DATE '2018-01-06'
        ,'������� �� ����� 97 �� ���� 90'
    FROM dual
  UNION ALL
  SELECT 47
        ,-863.26
        ,DATE '2017-11-25'
        ,'������� �� ����� 97 �� ���� 95'
    FROM dual
  UNION ALL
  SELECT 48
        ,273.42
        ,DATE '2017-10-15'
        ,'��������� ���������� �����'
    FROM dual
  UNION ALL
  SELECT 48
        ,-565.28
        ,DATE '2018-01-05'
        ,'������� �� ����� 91 �� ���� 98'
    FROM dual
  UNION ALL
  SELECT 48
        ,-632.76
        ,DATE '2018-01-11'
        ,'�������� �������� �������'
    FROM dual
  UNION ALL
  SELECT 49
        ,415.19
        ,DATE '2017-10-22'
        ,'��������� ���������� �����'
    FROM dual
  UNION ALL
  SELECT 49
        ,590.66
        ,DATE '2017-12-31'
        ,'������� �� ����� 98 �� ���� 90'
    FROM dual
  UNION ALL
  SELECT 49
        ,632.42
        ,DATE '2017-12-13'
        ,'������� �� ����� 97 �� ���� 90'
    FROM dual
  UNION ALL
  SELECT 49
        ,677.95
        ,DATE '2017-11-13'
        ,'������� �� ����� 98 �� ���� 90'
    FROM dual
  UNION ALL
  SELECT 49
        ,835.08
        ,DATE '2018-01-06'
        ,'������� �� ����� 97 �� ���� 90'
    FROM dual
  UNION ALL
  SELECT 49
        ,-215.19
        ,DATE '2018-01-13'
        ,'�������� �������� �������'
    FROM dual
  UNION ALL
  SELECT 49
        ,-525.89
        ,DATE '2018-01-08'
        ,'������� �� ����� 90 �� ���� 98'
    FROM dual
  UNION ALL
  SELECT 49
        ,-841.23
        ,DATE '2017-11-19'
        ,'������� �� ����� 90 �� ���� 92'
    FROM dual
  UNION ALL
  SELECT 50
        ,-57.13
        ,DATE '2018-01-12'
        ,'�������� �������� �������'
    FROM dual
  UNION ALL
  SELECT 50
        ,525.89
        ,DATE '2018-01-08'
        ,'������� �� ����� 90 �� ���� 98'
    FROM dual
  UNION ALL
  SELECT 50
        ,565.28
        ,DATE '2018-01-05'
        ,'������� �� ����� 91 �� ���� 98'
    FROM dual
  UNION ALL
  SELECT 50
        ,942.13
        ,DATE '2017-10-25'
        ,'��������� ���������� �����'
    FROM dual
  UNION ALL
  SELECT 50
        ,-406.21
        ,DATE '2017-12-27'
        ,'������� �� ����� 98 �� ���� 97'
    FROM dual
  UNION ALL
  SELECT 50
        ,-590.66
        ,DATE '2017-12-31'
        ,'������� �� ����� 98 �� ���� 90'
    FROM dual
  UNION ALL
  SELECT 50
        ,-677.95
        ,DATE '2017-11-13'
        ,'������� �� ����� 98 �� ���� 90'
    FROM dual;
