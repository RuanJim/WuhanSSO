CREATE TABLE SSO.SSO_DEPARTMENT (
  SESSION_ID           NVARCHAR2(200),
  DEPARTMENT           NVARCHAR2(200)
  CONSTRAINT PK_SSO_LOG PRIMARY KEY (SESSION_ID, DEPARTMENT) USING INDEX TABLESPACE USERS STORAGE (INITIAL 64 K
                                                                                       NEXT 1 M
                                                                                       MAXEXTENTS UNLIMITED)
)
TABLESPACE USERS
STORAGE (INITIAL 64 K
         NEXT 1 M
         MAXEXTENTS UNLIMITED)
LOGGING;