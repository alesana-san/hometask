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
  SELECT (select account_id from ow_accounts where account_code = '92')
        ,139.39
        ,to_date('22.10.2017 10:48:46'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Первичное пополнение счета'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '92')
        ,841.23
        ,to_date('19.11.2017 06:44:17'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Перенос со счета 90 на счет 92'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '92')
        ,-304.95
        ,to_date('02.11.2017 04:14:38'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Перенос со счета 92 на счет 97'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '92')
        ,-814.95
        ,to_date('10.01.2018 19:03:28'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Списание наличных средств'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '95')
        ,273.25
        ,to_date('16.10.2017 14:48:24'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Первичное пополнение счета'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '95')
        ,863.26
        ,to_date('25.11.2017 12:13:50'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Перенос со счета 97 на счет 95'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '95')
        ,-557.19
        ,to_date('13.01.2018 15:15:18'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Списание наличных средств'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '97')
        ,304.95
        ,to_date('02.11.2017 04:14:38'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Перенос со счета 92 на счет 97'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '97')
        ,406.21
        ,to_date('27.12.2017 20:14:28'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Перенос со счета 98 на счет 97'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '97')
        ,959.32
        ,to_date('26.10.2017 04:05:51'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Первичное пополнение счета'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '97')
        ,-390.91
        ,to_date('19.01.2018 13:54:28'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Списание наличных средств'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '97')
        ,-632.42
        ,to_date('13.12.2017 17:48:10'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Перенос со счета 97 на счет 90'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '97')
        ,-835.08
        ,to_date('06.01.2018 05:06:21'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Перенос со счета 97 на счет 90'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '97')
        ,-863.26
        ,to_date('25.11.2017 12:13:50'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Перенос со счета 97 на счет 95'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '91')
        ,273.42
        ,to_date('15.10.2017 20:20:45'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Первичное пополнение счета'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '91')
        ,-565.28
        ,to_date('05.01.2018 23:24:11'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Перенос со счета 91 на счет 98'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '91')
        ,-632.76
        ,to_date('11.01.2018 22:24:57'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Списание наличных средств'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '90')
        ,415.19
        ,to_date('22.10.2017 22:19:43'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Первичное пополнение счета'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '90')
        ,590.66
        ,to_date('31.12.2017 08:02:56'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Перенос со счета 98 на счет 90'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '90')
        ,632.42
        ,to_date('13.12.2017 17:48:10'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Перенос со счета 97 на счет 90'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '90')
        ,677.95
        ,to_date('13.11.2017 22:06:14'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Перенос со счета 98 на счет 90'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '90')
        ,835.08
        ,to_date('06.01.2018 05:06:21'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Перенос со счета 97 на счет 90'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '90')
        ,-215.19
        ,to_date('13.01.2018 22:32:50'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Списание наличных средств'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '90')
        ,-525.89
        ,to_date('08.01.2018 16:00:07'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Перенос со счета 90 на счет 98'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '90')
        ,-841.23
        ,to_date('19.11.2017 06:44:17'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Перенос со счета 90 на счет 92'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '98')
        ,-57.13
        ,to_date('12.01.2018 11:19:10'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Списание наличных средств'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '98')
        ,525.89
        ,to_date('08.01.2018 16:00:07'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Перенос со счета 90 на счет 98'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '98')
        ,565.28
        ,to_date('05.01.2018 23:24:11'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Перенос со счета 91 на счет 98'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '98')
        ,942.13
        ,to_date('25.10.2017 11:53:03'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Первичное пополнение счета'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '98')
        ,-406.21
        ,to_date('27.12.2017 20:14:28'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Перенос со счета 98 на счет 97'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '98')
        ,-590.66
        ,to_date('31.12.2017 08:02:56'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Перенос со счета 98 на счет 90'
    FROM dual
  UNION ALL
  SELECT (select account_id from ow_accounts where account_code = '98')
        ,-677.95
        ,to_date('13.11.2017 22:06:14'
                ,'DD.MM.YYYY HH24:MI:SS')
        ,'Перенос со счета 98 на счет 90'
    FROM dual;
