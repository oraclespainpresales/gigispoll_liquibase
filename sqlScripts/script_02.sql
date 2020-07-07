-- script_02.sql
CREATE OR REPLACE FUNCTION get_tab_count RETURNS NUMBER AS
  f_count  NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO   f_count
  FROM   tab1;

  RETURN f_count;
END;
/