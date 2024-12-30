CREATE OR REPLACE PACKAGE StockComparison AS

    -- Procedure for loading exchange data
    PROCEDURE LoadExchangeData(p_file_path IN VARCHAR2);

    -- Procedure for loading depository data
    PROCEDURE LoadDepositoryData(p_file_path IN VARCHAR2);

    -- Procedure for comparing data between exchange and depository
    PROCEDURE CompareData;

END StockComparison;
/
