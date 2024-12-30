CREATE OR REPLACE PACKAGE BODY StockComparison AS

    -- Procedure to load exchange data with error handling
    PROCEDURE LoadExchangeData(p_file_path IN VARCHAR2) IS
        v_file UTL_FILE.FILE_TYPE;
        v_line VARCHAR2(4000);
        v_user_id VARCHAR2(50);
        v_stock_id VARCHAR2(50);
        v_stock_name VARCHAR2(100);
        v_stock_count NUMBER;
    BEGIN
        -- Check if the file exists
        BEGIN
            v_file := UTL_FILE.FOPEN('EXTERNAL_DIR', p_file_path, 'R');
        EXCEPTION
            WHEN UTL_FILE.INVALID_PATH THEN
                DBMS_OUTPUT.PUT_LINE('File not found: ' || p_file_path);
                RETURN;
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error opening file: ' || SQLERRM);
                RETURN;
        END;

        -- Read the CSV file and process line by line
        LOOP
            BEGIN
                UTL_FILE.GET_LINE(v_file, v_line);
                -- Assuming CSV has 4 fields: User_ID, Stock_ID, Stock_Name, Stock_Count
                v_user_id := REGEXP_SUBSTR(v_line, '^[^,]+', 1, 1);
                v_stock_id := REGEXP_SUBSTR(v_line, '[^,]+', 1, 2);
                v_stock_name := REGEXP_SUBSTR(v_line, '[^,]+', 1, 3);
                v_stock_count := TO_NUMBER(REGEXP_SUBSTR(v_line, '[^,]+', 1, 4));

                -- Insert into Exchange_Data table
                INSERT INTO Exchange_Data (User_ID, Stock_ID, Stock_Name, Stock_Count)
                VALUES (v_user_id, v_stock_id, v_stock_name, v_stock_count);
            EXCEPTION
                WHEN OTHERS THEN
                    DBMS_OUTPUT.PUT_LINE('Error processing row: ' || v_line || ' - ' || SQLERRM);
            END;
        END LOOP;

        -- Close the file
        UTL_FILE.FCLOSE(v_file);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error during file processing: ' || SQLERRM);
    END LoadExchangeData;

    -- Procedure to load depository data with error handling
    PROCEDURE LoadDepositoryData(p_file_path IN VARCHAR2) IS
        v_file UTL_FILE.FILE_TYPE;
        v_line VARCHAR2(4000);
        v_user_id VARCHAR2(50);
        v_stock_id VARCHAR2(50);
        v_stock_name VARCHAR2(100);
        v_stock_count NUMBER;
    BEGIN
        -- Check if the file exists
        BEGIN
            v_file := UTL_FILE.FOPEN('EXTERNAL_DIR', p_file_path, 'R');
        EXCEPTION
            WHEN UTL_FILE.INVALID_PATH THEN
                DBMS_OUTPUT.PUT_LINE('File not found: ' || p_file_path);
                RETURN;
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error opening file: ' || SQLERRM);
                RETURN;
        END;

        -- Read the CSV file and process line by line
        LOOP
            BEGIN
                UTL_FILE.GET_LINE(v_file, v_line);
                -- Assuming CSV has 4 fields: User_ID, Stock_ID, Stock_Name, Stock_Count
                v_user_id := REGEXP_SUBSTR(v_line, '^[^,]+', 1, 1);
                v_stock_id := REGEXP_SUBSTR(v_line, '[^,]+', 1, 2);
                v_stock_name := REGEXP_SUBSTR(v_line, '[^,]+', 1, 3);
                v_stock_count := TO_NUMBER(REGEXP_SUBSTR(v_line, '[^,]+', 1, 4));

                -- Insert into Depository_Data table
                INSERT INTO Depository_Data (User_ID, Stock_ID, Stock_Name, Stock_Count)
                VALUES (v_user_id, v_stock_id, v_stock_name, v_stock_count);
            EXCEPTION
                WHEN OTHERS THEN
                    DBMS_OUTPUT.PUT_LINE('Error processing row: ' || v_line || ' - ' || SQLERRM);
            END;
        END LOOP;

        -- Close the file
        UTL_FILE.FCLOSE(v_file);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error during file processing: ' || SQLERRM);
    END LoadDepositoryData;

    -- Procedure to compare data between exchange and depository
    PROCEDURE CompareData IS
        CURSOR StockCursor IS
            SELECT
                e.User_ID,
                e.Stock_ID,
                e.Stock_Count AS Exchange_Count,
                d.Stock_Count AS Depository_Count
            FROM
                Exchange_Data e
                FULL OUTER JOIN Depository_Data d
                ON e.User_ID = d.User_ID AND e.Stock_ID = d.Stock_ID;

        l_Status VARCHAR2(20);
    BEGIN
        FOR record IN StockCursor LOOP
            IF record.Exchange_Count = record.Depository_Count THEN
                l_Status := 'Match';
            ELSE
                l_Status := 'Mismatch';
            END IF;

            -- Insert comparison results into the table
            INSERT INTO Comparison_Results (
                User_ID, Stock_ID, Exchange_Count, Depository_Count, Status
            ) VALUES (
                record.User_ID, record.Stock_ID, record.Exchange_Count,
                record.Depository_Count, l_Status
            );
        END LOOP;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error during data comparison: ' || SQLERRM);
    END CompareData;

END StockComparison;
/
