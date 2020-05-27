-- script_01.sql
administer key management set keystore open identified by "Welcome1#Oc4j1013-";
CREATE TABLE tab1 (
  id          NUMBER,
  description VARCHAR2(50),
  CONSTRAINT tab1_pk PRIMARY KEY (id)
);
CREATE SEQUENCE tab1_seq;

INSERT INTO tab1 (id, description) VALUES (tab1_seq.NEXTVAL, 'Description for ' || tab1_seq.CURRVAL);
COMMIT;
