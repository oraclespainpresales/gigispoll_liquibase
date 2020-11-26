--------------------------------------------------------
--  DDL for Table POLLUUID
--------------------------------------------------------
BEGIN
    DROP TABLE "MICROSERVICE"."POLLUUID";
    
    WHEN OTHERS THEN NULL;
END;

CREATE TABLE "MICROSERVICE"."POLLUUID" ( 
    "UUID" VARCHAR2(40 BYTE) NOT NULL, 
    "ORDERID" VARCHAR2(20 BYTE) NOT NULL, 
    "DUEDATETIME" VARCHAR2(30 BYTE) NOT NULL, 
    "USED" VARCHAR2(1 BYTE) DEFAULT 'N'
);

ALTER TABLE "MICROSERVICE"."PAYMENTS" 
ADD ( 
    SERVICESURVEY NUMBER DEFAULT 0,
    SERVICESCOMMENTS VARCHAR2(2000 BYTE)
);

COMMIT;
