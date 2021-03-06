--------------------------------------------------------
--  DDL for Table POLLUUID
--------------------------------------------------------
BEGIN
    BEGIN
        execute immediate 'drop table MICROSERVICE.POLLUUID';
        EXCEPTION WHEN OTHERS THEN NULL;
    END;
    
    execute immediate 'CREATE TABLE MICROSERVICE.POLLUUID ( 
        UUID VARCHAR2(40 BYTE) NOT NULL, 
        ORDERID VARCHAR2(20 BYTE) NOT NULL, 
        DUEDATETIME VARCHAR2(30 BYTE) NOT NULL, 
        USED VARCHAR2(1 BYTE) DEFAULT ''N''
    )';
    
    COMMIT;
END;
