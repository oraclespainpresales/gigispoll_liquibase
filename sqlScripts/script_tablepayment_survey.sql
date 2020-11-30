--------------------------------------------------------
--  DDL for Table PAYMENT
--------------------------------------------------------
BEGIN      
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
