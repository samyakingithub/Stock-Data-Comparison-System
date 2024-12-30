-- Creating the main tables for storing data from exchange and depository

CREATE TABLE Exchange_Data (
    User_ID VARCHAR2(50),
    Stock_ID VARCHAR2(50),
    Stock_Name VARCHAR2(100),
    Stock_Count NUMBER
);

CREATE TABLE Depository_Data (
    User_ID VARCHAR2(50),
    Stock_ID VARCHAR2(50),
    Stock_Name VARCHAR2(100),
    Stock_Count NUMBER
);

CREATE TABLE Comparison_Results (
    User_ID VARCHAR2(50),
    Stock_ID VARCHAR2(50),
    Exchange_Count NUMBER,
    Depository_Count NUMBER,
    Status VARCHAR2(20)
);

-- External table definitions to read CSV files into the database
CREATE DIRECTORY EXTERNAL_DIR AS 'C:\Users\dell\OneDrive\Desktop\Zicuro\csv files';
-- The directory path should be modified to the location of the CSV files on your system

-- External table to load exchange data from CSV file
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

-- External table to load depository data from CSV file
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
