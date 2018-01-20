SET TERM ON
SET ECHO OFF
SET FEED ON
SET VER ON
SET PAU OFF
SET SERVEROUTPUT ON SIZE 1000000
WHENEVER SQLERROR CONTINUE
SPOOL OW_INSTALL.log  

PROMPT Creating table ow_accounts
@ow_accounts.sql
PROMPT Creating table ow_turnovers
@ow_turnovers.sql
PROMPT Creating function get_prc_summ
@get_prc_summ.sql
SHOW ERRORS
PROMPT Filling with test data
@test_fill.sql
COMMIT;

SPOOL OFF
EXIT