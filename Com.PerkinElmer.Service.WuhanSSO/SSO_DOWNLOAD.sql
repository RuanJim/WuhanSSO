CREATE TABLE SSO.SSO_DOWNLOAD (
  SESSION_ID    NVARCHAR2(200),
  DOWNLOAD_TIME NVARCHAR2(200),
  USER_ID       NVARCHAR2(200),
  CONSTRAINT PK_SSO_DOWNLOAD PRIMARY KEY (SESSION_ID, DOWNLOAD_TIME) USING INDEX TABLESPACE USERS STORAGE (INITIAL 64 K
                                                                                                           NEXT 1 M
                                                                                                           MAXEXTENTS UNLIMITED)
)
TABLESPACE USERS
STORAGE (INITIAL 64 K
         NEXT 1 M
         MAXEXTENTS UNLIMITED)
LOGGING;