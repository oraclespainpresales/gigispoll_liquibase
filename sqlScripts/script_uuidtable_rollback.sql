BEGIN
    BEGIN
        execute immediate 'drop table MICROSERVICE.POLLUUID';
        EXCEPTION WHEN OTHERS THEN NULL;
    END;    
    COMMIT;
END;