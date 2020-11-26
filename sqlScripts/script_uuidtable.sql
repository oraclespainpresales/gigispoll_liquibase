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
    
    BEGIN
        execute immediate 'ALTER TABLE MICROSERVICE.PAYMENTS 
        ADD ( 
            SERVICESURVEY NUMBER DEFAULT 0,
            SERVICESCOMMENTS VARCHAR2(2000 BYTE)
        )';
        
        EXCEPTION WHEN OTHERS THEN NULL;
    END;
    
    COMMIT;
END;
