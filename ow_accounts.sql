DECLARE
 i NUMBER;
BEGIN
SELECT 1 INTO i
FROM   all_objects o
WHERE  o.owner=sys_context( 'userenv', 'current_schema' )
       AND o.object_type='TABLE'
       AND UPPER(o.object_name)=UPPER('OW_ACCOUNTS');
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    EXECUTE IMMEDIATE 'create table OW_ACCOUNTS
(
  account_id    NUMBER not null,
  account_code  VARCHAR2(20 CHAR) not null,
  creation_date DATE default sysdate not null,
  currency_code VARCHAR2(10 CHAR) default ''RUB'' not null
)';

  EXECUTE IMMEDIATE 'create unique index OW_ACCOUNTS_U1 on OW_ACCOUNTS (ACCOUNT_ID)';
  EXECUTE IMMEDIATE 'create unique index OW_ACCOUNTS_U2 on OW_ACCOUNTS (ACCOUNT_CODE)';
  
  EXECUTE IMMEDIATE 'create sequence ow_accounts_s';
  
END;
/
comment on table OW_ACCOUNTS
  is 'Таблица содержит информацию по банковским счетам';
comment on column OW_ACCOUNTS.account_id
  is 'ID счета';
comment on column OW_ACCOUNTS.account_code
  is 'Код счета (визуальное представление)';
comment on column OW_ACCOUNTS.creation_date
  is 'Дата создания счета (по умолчанию - текущая дата)';
comment on column OW_ACCOUNTS.currency_code
  is 'Валюта счета (по умолчанию Российский рубль)';
/