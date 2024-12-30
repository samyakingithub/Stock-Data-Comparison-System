# **Stock Data Comparison System**

This repository contains SQL scripts and PL/SQL code to automate the process of comparing stock data between an exchange and a depository. The system efficiently processes large datasets and identifies discrepancies between the two data sources. The repository is designed to meet the requirements of a database assignment.

## **Features**
- Schema creation for tables to store and manage stock data.
- Integration with external CSV files for bulk data loading.
- Automated comparison of stock data between exchange and depository.
- Comprehensive error handling for missing files and data inconsistencies.
- Customizable PL/SQL package for seamless data operations.

---

## **Folder Structure**
```plaintext
.
├── schema.sql                # SQL script to create database tables and external table definitions
├── external_table_definitions.sql # Script to define external tables for CSV data loading
├── package_spec.sql          # PL/SQL package specification
├── package_body.sql          # PL/SQL package implementation
├── data_loading.sql          # (Optional) SQL script for inserting sample data
├── README.md                 # Repository documentation
```

---

## **Requirements**
Before you start, ensure you have the following:
- **Oracle Database** installed and configured.
- SQL Developer or any other tool to execute SQL and PL/SQL scripts.
- Access to a directory for external tables with CSV files:
  - `exchange_data.csv`
  - `depository_data.csv`

---

## **Setup Instructions**

### **Step 1: Clone the Repository**
```bash
git clone https://github.com/your-username/stock-data-comparison.git
cd stock-data-comparison
```

### **Step 2: Configure the Database**
1. Set up a directory on your Oracle server to store the CSV files:
   ```sql
   CREATE DIRECTORY EXTERNAL_DIR AS '/path/to/your/csv/files';
   ```
   Replace '/path/to/your/csv/files' with the directory path on your Oracle server.


2. Place the `exchange_data.csv` and `depository_data.csv` files in this directory.

### **Step 3: Execute the Scripts**
1. Run the `schema.sql` script to create tables and define external tables:
   ```sql
   @schema.sql
   ```

2. Load the external table definitions (if not already defined):
   ```sql
   @external_table_definitions.sql
   ```

3. Compile the PL/SQL package:
   ```sql
   @package_spec.sql
   @package_body.sql
   ```

4. (Optional) Insert sample data using `data_loading.sql`:
   ```sql
   @data_loading.sql
   ```

### **Step 4: Run the System**
1. Load data from the external tables into the database:
   ```sql
   EXEC StockComparison.LoadExchangeData('exchange_data.csv');
   EXEC StockComparison.LoadDepositoryData('depository_data.csv');
   ```

2. Compare the stock data:
   ```sql
   EXEC StockComparison.CompareData;
   ```

3. Query the comparison results:
   ```sql
   SELECT * FROM Comparison_Results;
   ```

---

## **File Descriptions**

### **1. schema.sql**
Defines the database schema, including tables to store exchange and depository data. It also sets up external tables for loading data from CSV files.

### **2. external_table_definitions.sql**
Defines external tables to directly read data from CSV files using Oracle's `ORACLE_LOADER`.

### **3. package_spec.sql**
The PL/SQL package specification outlines the procedures for:
- Loading data from files.
- Comparing stock data.

### **4. package_body.sql**
Implements the functionality of the PL/SQL package with error handling and bulk data loading.

### **5. data_loading.sql**
(Optional) Inserts sample data into the `Exchange_Data` and `Depository_Data` tables for testing.

---

## **How It Works**
1. **Data Loading**: Data is loaded from external CSV files into database tables.
2. **Data Comparison**: Records are compared for discrepancies in stock counts between the exchange and depository.
3. **Results Storage**: Results of the comparison (e.g., Match or Mismatch) are stored in a separate table, `Comparison_Results`.

---

## **Error Handling**
The system includes:
- Validation for missing files or invalid file paths.
- Error handling during data insertion and processing.
- Logging of problematic rows for manual review.

---

## **Customization**
- Update the directory path in `schema.sql` and `external_table_definitions.sql` to match your system's file structure.
- Modify the comparison logic in `CompareData` procedure as needed.

---

## **License**
This project is licensed under the MIT License. See the `LICENSE` file for more details.

---

## **Contributing**
Contributions are welcome! Please follow these steps:
1. Fork the repository.
2. Create a new branch (`feature/new-feature`).
3. Commit your changes.
4. Open a pull request.

---

## **Contact**
If you have any questions or feedback, feel free to reach out:
- Email: [samyakforwork@gmail.com](mailto:samyakforwork@gmail.com)
- GitHub: [samyakingithub](https://github.com/samyakingithub)

---

## **Acknowledgments**
This project was developed as part of a database assignment to demonstrate practical SQL and PL/SQL usage for managing and comparing datasets.

---

