--------------------------------------------------------
--  DDL for Table POLLUUID
--------------------------------------------------------

CREATE TABLE "MICROSERVICE"."POLLUUID2" ( 
    "UUID" VARCHAR2(40 BYTE), 
    "ORDERID" VARCHAR2(20 BYTE), 
    "DUEDATETIME" VARCHAR2(30 BYTE), 
    "USED" VARCHAR2(1 BYTE) DEFAULT 'N'
);
--------------------------------------------------------
--  Constraints for Table POLLUUID
--------------------------------------------------------
ALTER TABLE "MICROSERVICE"."POLLUUID" MODIFY ("UUID" NOT NULL ENABLE);
ALTER TABLE "MICROSERVICE"."POLLUUID" MODIFY ("ORDERID" NOT NULL ENABLE);
ALTER TABLE "MICROSERVICE"."POLLUUID" MODIFY ("DUEDATETIME" NOT NULL ENABLE);
ALTER TABLE "MICROSERVICE"."POLLUUID" MODIFY ("USED" NOT NULL ENABLE);

COMMIT;