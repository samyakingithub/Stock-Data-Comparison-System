
CREATE DIRECTORY EXTERNAL_DIR AS 'C:\Users\dell\OneDrive\Desktop\Zicuro\csv files';

CREATE TABLE Exchange_Data_External (
    User_ID VARCHAR2(50),
    Stock_ID VARCHAR2(50),
    Stock_Name VARCHAR2(100),
    Stock_Count NUMBER
)
ORGANIZATION EXTERNAL (
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY EXTERNAL_DIR
    ACCESS PARAMETERS (
        RECORDS DELIMITED BY NEWLINE
        FIELDS TERMINATED BY ','
    )
    LOCATION ('exchange_data_full.csv')
);

CREATE TABLE Depository_Data_External (
    User_ID VARCHAR2(50),
    Stock_ID VARCHAR2(50),
    Stock_Name VARCHAR2(100),
    Stock_Count NUMBER
)
ORGANIZATION EXTERNAL (
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY EXTERNAL_DIR
    ACCESS PARAMETERS (
        RECORDS DELIMITED BY NEWLINE
        FIELDS TERMINATED BY ','
    )
    LOCATION ('depository_data_full.csv')
);
