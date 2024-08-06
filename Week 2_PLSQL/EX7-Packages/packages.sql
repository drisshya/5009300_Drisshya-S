CREATE TABLE Customers (
    customer_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    email VARCHAR2(100),
    balance NUMBER,
    dob DATE,
    last_modified DATE
);

CREATE TABLE Accounts (
    account_id NUMBER PRIMARY KEY,
    customer_id NUMBER,
    account_type VARCHAR2(50),
    balance NUMBER,
    last_modified DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Employees (
    employee_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    position VARCHAR2(50),
    salary NUMBER,
    department VARCHAR2(50),
    hire_date DATE
);

CREATE TABLE Transactions (
    transaction_id NUMBER PRIMARY KEY,
    transaction_date DATE,
    account_id NUMBER,
    transaction_type VARCHAR2(20),
    amount NUMBER,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

CREATE TABLE Loans (
    loan_id NUMBER PRIMARY KEY,
    interest_rate NUMBER
);

CREATE OR REPLACE PACKAGE AccountOperations AS
    PROCEDURE OpenAccount(
        p_AccountID IN NUMBER,
        p_CustomerID IN NUMBER,
        p_AccountType IN VARCHAR2,
        p_Balance IN NUMBER
    );
    
    PROCEDURE CloseAccount(
        p_AccountID IN NUMBER
    );
    
    FUNCTION GetTotalBalance(
        p_CustomerID IN NUMBER
    ) RETURN NUMBER;
END AccountOperations;
/

CREATE OR REPLACE PACKAGE BODY AccountOperations AS

    PROCEDURE OpenAccount(
        p_AccountID IN NUMBER,
        p_CustomerID IN NUMBER,
        p_AccountType IN VARCHAR2,
        p_Balance IN NUMBER
    ) IS
    BEGIN
        INSERT INTO Accounts (account_id, customer_id, account_type, balance, last_modified)
        VALUES (p_AccountID, p_CustomerID, p_AccountType, p_Balance, SYSDATE);
    END OpenAccount;
    
    PROCEDURE CloseAccount(
        p_AccountID IN NUMBER
    ) IS
    BEGIN
        DELETE FROM Accounts
        WHERE account_id = p_AccountID;
    END CloseAccount;
    
    FUNCTION GetTotalBalance(
        p_CustomerID IN NUMBER
    ) RETURN NUMBER IS
        v_TotalBalance NUMBER;
    BEGIN
        SELECT SUM(balance) INTO v_TotalBalance
        FROM Accounts
        WHERE customer_id = p_CustomerID;
        RETURN NVL(v_TotalBalance, 0);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 0;
    END GetTotalBalance;

END AccountOperations;
/

CREATE OR REPLACE PACKAGE CustomerManagement AS
    PROCEDURE AddCustomer(
        p_CustomerID IN NUMBER,
        p_Name IN VARCHAR2,
        p_DOB IN DATE,
        p_Balance IN NUMBER
    );
    
    PROCEDURE UpdateCustomer(
        p_CustomerID IN NUMBER,
        p_Name IN VARCHAR2,
        p_Balance IN NUMBER
    );
    
    FUNCTION GetCustomerBalance(
        p_CustomerID IN NUMBER
    ) RETURN NUMBER;
END CustomerManagement;
/

CREATE OR REPLACE PACKAGE BODY CustomerManagement AS

    PROCEDURE AddCustomer(
        p_CustomerID IN NUMBER,
        p_Name IN VARCHAR2,
        p_DOB IN DATE,
        p_Balance IN NUMBER
    ) IS
    BEGIN
        INSERT INTO Customers (customer_id, name, dob, balance, last_modified)
        VALUES (p_CustomerID, p_Name, p_DOB, p_Balance, SYSDATE);
    END AddCustomer;
    
    PROCEDURE UpdateCustomer(
        p_CustomerID IN NUMBER,
        p_Name IN VARCHAR2,
        p_Balance IN NUMBER
    ) IS
    BEGIN
        UPDATE Customers
        SET name = p_Name, balance = p_Balance, last_modified = SYSDATE
        WHERE customer_id = p_CustomerID;
    END UpdateCustomer;
    
    FUNCTION GetCustomerBalance(
        p_CustomerID IN NUMBER
    ) RETURN NUMBER IS
        v_Balance NUMBER;
    BEGIN
        SELECT balance INTO v_Balance
        FROM Customers
        WHERE customer_id = p_CustomerID;
        RETURN v_Balance;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END GetCustomerBalance;

END CustomerManagement;
/

CREATE OR REPLACE PACKAGE EmployeeManagement AS
    PROCEDURE HireEmployee(
        p_EmployeeID IN NUMBER,
        p_Name IN VARCHAR2,
        p_Position IN VARCHAR2,
        p_Salary IN NUMBER,
        p_Department IN VARCHAR2,
        p_HireDate IN DATE
    );
    
    PROCEDURE UpdateEmployee(
        p_EmployeeID IN NUMBER,
        p_Name IN VARCHAR2,
        p_Salary IN NUMBER
    );
    
    FUNCTION CalculateAnnualSalary(
        p_EmployeeID IN NUMBER
    ) RETURN NUMBER;
END EmployeeManagement;
/

CREATE OR REPLACE PACKAGE BODY EmployeeManagement AS

    PROCEDURE HireEmployee(
        p_EmployeeID IN NUMBER,
        p_Name IN VARCHAR2,
        p_Position IN VARCHAR2,
        p_Salary IN NUMBER,
        p_Department IN VARCHAR2,
        p_HireDate IN DATE
    ) IS
    BEGIN
        INSERT INTO Employees (employee_id, name, position, salary, department, hire_date)
        VALUES (p_EmployeeID, p_Name, p_Position, p_Salary, p_Department, p_HireDate);
    END HireEmployee;
    
    PROCEDURE UpdateEmployee(
        p_EmployeeID IN NUMBER,
        p_Name IN VARCHAR2,
        p_Salary IN NUMBER
    ) IS
    BEGIN
        UPDATE Employees
        SET name = p_Name, salary = p_Salary
        WHERE employee_id = p_EmployeeID;
    END UpdateEmployee;
    
    FUNCTION CalculateAnnualSalary(
        p_EmployeeID IN NUMBER
    ) RETURN NUMBER IS
        v_AnnualSalary NUMBER;
    BEGIN
        SELECT salary * 12 INTO v_AnnualSalary
        FROM Employees
        WHERE employee_id = p_EmployeeID;
        RETURN v_AnnualSalary;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END CalculateAnnualSalary;

END EmployeeManagement;
/
