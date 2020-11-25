--------------------------------------------------------
--  DDL for Table POLLUUID
--------------------------------------------------------

CREATE TABLE "MICROSERVICE"."POLLUUID2" ( 
    "UUID" VARCHAR2(40 BYTE) NOT NULL, 
    "ORDERID" VARCHAR2(20 BYTE) NOT NULL, 
    "DUEDATETIME" VARCHAR2(30 BYTE) NOT NULL, 
    "USED" VARCHAR2(1 BYTE) DEFAULT 'N'
);

COMMIT;