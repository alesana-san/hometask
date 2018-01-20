DELETE FROM ow_accounts;
-- Тестовые данные по счетам
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
-- Тестовые данные по оборотам
INSERT INTO ow_turnovers
  (account_id
  ,accounted_sum
  ,accounting_date
  ,comments)
  SELECT 45
        ,139.39
        ,DATE '2017-10-22'
        ,'Первичное пополнение счета'
    FROM dual
  UNION ALL
  SELECT 45
        ,841.23
        ,DATE '2017-11-19'
        ,'Перенос со счета 90 на счет 92'
    FROM dual
  UNION ALL
  SELECT 45
        ,-304.95
        ,DATE '2017-11-02'
        ,'Перенос со счета 92 на счет 97'
    FROM dual
  UNION ALL
  SELECT 45
        ,-814.95
        ,DATE '2018-01-10'
        ,'Списание наличных средств'
    FROM dual
  UNION ALL
  SELECT 46
        ,273.25
        ,DATE '2017-10-16'
        ,'Первичное пополнение счета'
    FROM dual
  UNION ALL
  SELECT 46
        ,863.26
        ,DATE '2017-11-25'
        ,'Перенос со счета 97 на счет 95'
    FROM dual
  UNION ALL
  SELECT 46
        ,-557.19
        ,DATE '2018-01-13'
        ,'Списание наличных средств'
    FROM dual
  UNION ALL
  SELECT 47
        ,304.95
        ,DATE '2017-11-02'
        ,'Перенос со счета 92 на счет 97'
    FROM dual
  UNION ALL
  SELECT 47
        ,406.21
        ,DATE '2017-12-27'
        ,'Перенос со счета 98 на счет 97'
    FROM dual
  UNION ALL
  SELECT 47
        ,959.32
        ,DATE '2017-10-26'
        ,'Первичное пополнение счета'
    FROM dual
  UNION ALL
  SELECT 47
        ,-390.91
        ,DATE '2018-01-19'
        ,'Списание наличных средств'
    FROM dual
  UNION ALL
  SELECT 47
        ,-632.42
        ,DATE '2017-12-13'
        ,'Перенос со счета 97 на счет 90'
    FROM dual
  UNION ALL
  SELECT 47
        ,-835.08
        ,DATE '2018-01-06'
        ,'Перенос со счета 97 на счет 90'
    FROM dual
  UNION ALL
  SELECT 47
        ,-863.26
        ,DATE '2017-11-25'
        ,'Перенос со счета 97 на счет 95'
    FROM dual
  UNION ALL
  SELECT 48
        ,273.42
        ,DATE '2017-10-15'
        ,'Первичное пополнение счета'
    FROM dual
  UNION ALL
  SELECT 48
        ,-565.28
        ,DATE '2018-01-05'
        ,'Перенос со счета 91 на счет 98'
    FROM dual
  UNION ALL
  SELECT 48
        ,-632.76
        ,DATE '2018-01-11'
        ,'Списание наличных средств'
    FROM dual
  UNION ALL
  SELECT 49
        ,415.19
        ,DATE '2017-10-22'
        ,'Первичное пополнение счета'
    FROM dual
  UNION ALL
  SELECT 49
        ,590.66
        ,DATE '2017-12-31'
        ,'Перенос со счета 98 на счет 90'
    FROM dual
  UNION ALL
  SELECT 49
        ,632.42
        ,DATE '2017-12-13'
        ,'Перенос со счета 97 на счет 90'
    FROM dual
  UNION ALL
  SELECT 49
        ,677.95
        ,DATE '2017-11-13'
        ,'Перенос со счета 98 на счет 90'
    FROM dual
  UNION ALL
  SELECT 49
        ,835.08
        ,DATE '2018-01-06'
        ,'Перенос со счета 97 на счет 90'
    FROM dual
  UNION ALL
  SELECT 49
        ,-215.19
        ,DATE '2018-01-13'
        ,'Списание наличных средств'
    FROM dual
  UNION ALL
  SELECT 49
        ,-525.89
        ,DATE '2018-01-08'
        ,'Перенос со счета 90 на счет 98'
    FROM dual
  UNION ALL
  SELECT 49
        ,-841.23
        ,DATE '2017-11-19'
        ,'Перенос со счета 90 на счет 92'
    FROM dual
  UNION ALL
  SELECT 50
        ,-57.13
        ,DATE '2018-01-12'
        ,'Списание наличных средств'
    FROM dual
  UNION ALL
  SELECT 50
        ,525.89
        ,DATE '2018-01-08'
        ,'Перенос со счета 90 на счет 98'
    FROM dual
  UNION ALL
  SELECT 50
        ,565.28
        ,DATE '2018-01-05'
        ,'Перенос со счета 91 на счет 98'
    FROM dual
  UNION ALL
  SELECT 50
        ,942.13
        ,DATE '2017-10-25'
        ,'Первичное пополнение счета'
    FROM dual
  UNION ALL
  SELECT 50
        ,-406.21
        ,DATE '2017-12-27'
        ,'Перенос со счета 98 на счет 97'
    FROM dual
  UNION ALL
  SELECT 50
        ,-590.66
        ,DATE '2017-12-31'
        ,'Перенос со счета 98 на счет 90'
    FROM dual
  UNION ALL
  SELECT 50
        ,-677.95
        ,DATE '2017-11-13'
        ,'Перенос со счета 98 на счет 90'
    FROM dual;
