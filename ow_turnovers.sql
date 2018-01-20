DECLARE
 i NUMBER;
BEGIN
SELECT 1 INTO i
FROM   all_objects o
WHERE  o.owner=sys_context( 'userenv', 'current_schema' )
       AND o.object_type='TABLE'
       AND UPPER(o.object_name)=UPPER('OW_TURNOVERS');
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    EXECUTE IMMEDIATE 'create table OW_TURNOVERS
(
  account_id      NUMBER not null,
  accounted_sum   NUMBER default 0 not null,
  accounting_date DATE default sysdate not null,
  comments        VARCHAR2(4000 CHAR)
)';

  EXECUTE IMMEDIATE 'create index OW_TURNOVERS_N1 on OW_TURNOVERS (ACCOUNT_ID)';
  EXECUTE IMMEDIATE 'create index OW_TURNOVERS_N2 on OW_TURNOVERS (ACCOUNTING_DATE)';
  
END;
/
comment on table OW_TURNOVERS
  is '������� �������� ���������� �� �������� � ��������� �������� ��������:
- ������ ����������� ����� - ��������� ���� ������ � ������������� ������ ����� ��� �����
- ��������� �������� ����� - ��������� ���� ������ � ������������� ������ ����� ��� �����
- ��������� ������� ������� � ������ ����� �� ������ - ��������� ������ �� �������� � ��������� ����� � ������ �� ���������� �� ������� ����';
comment on column OW_TURNOVERS.account_id
  is '����, � �������� ���������� ��������/����������';
comment on column OW_TURNOVERS.accounted_sum
  is '�������� �����';
comment on column OW_TURNOVERS.accounting_date
  is '���� �����';
comment on column OW_TURNOVERS.comments
  is '����������� �� �������� �����';
/
