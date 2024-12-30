-- Preloading sample data into Exchange_Data and Depository_Data
INSERT INTO Exchange_Data (User_ID, Stock_ID, Stock_Name, Stock_Count)
VALUES ('user1', 'AAPL', 'Apple Inc.', 100);

INSERT INTO Depository_Data (User_ID, Stock_ID, Stock_Name, Stock_Count)
VALUES ('user1', 'AAPL', 'Apple Inc.', 100);

-- Additional sample data can be inserted similarly
