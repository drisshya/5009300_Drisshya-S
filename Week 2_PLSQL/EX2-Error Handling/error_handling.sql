CREATE TABLE Customers (
    customer_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    email VARCHAR2(100)
);

CREATE TABLE accounts (
    account_id NUMBER PRIMARY KEY,
    balance NUMBER
);

CREATE TABLE employees (
    employee_id NUMBER PRIMARY KEY,
    salary NUMBER
);

INSERT INTO Customers (customer_id, name, email) VALUES (1, 'John Doe', 'john.doe@example.com');
INSERT INTO Customers (customer_id, name, email) VALUES (2, 'Jane Smith', 'jane.smith@example.com');

INSERT INTO accounts (account_id, balance) VALUES (1, 5000);
INSERT INTO accounts (account_id, balance) VALUES (2, 3000);

INSERT INTO employees (employee_id, salary) VALUES (1, 60000);
INSERT INTO employees (employee_id, salary) VALUES (2, 50000);

COMMIT;

CREATE OR REPLACE PROCEDURE AddNewCustomer (
  p_customer_id IN NUMBER,
  p_name IN VARCHAR2,
  p_email IN VARCHAR2
) IS
BEGIN
  INSERT INTO Customers (customer_id, name, email)
  VALUES (p_customer_id, p_name, p_email);

  COMMIT;

EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    DBMS_OUTPUT.PUT_LINE('Customer with this ID already exists.');
    ROLLBACK;
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
    ROLLBACK;
END AddNewCustomer;
/ 

CREATE OR REPLACE PROCEDURE SafeTransferFunds (
  p_from_account_id IN NUMBER,
  p_to_account_id IN NUMBER,
  p_amount IN NUMBER
) IS
  v_balance NUMBER;
BEGIN
  SELECT balance INTO v_balance
  FROM accounts
  WHERE account_id = p_from_account_id;

  IF v_balance < p_amount THEN
    RAISE_APPLICATION_ERROR(-20001, 'Insufficient funds in the from account.');
  END IF;

  UPDATE accounts
  SET balance = balance - p_amount
  WHERE account_id = p_from_account_id;

  UPDATE accounts
  SET balance = balance + p_amount
  WHERE account_id = p_to_account_id;

  COMMIT;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Account ID does not exist.');
    ROLLBACK;
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
    ROLLBACK;
END SafeTransferFunds;
/ 

CREATE OR REPLACE PROCEDURE UpdateSalary (
  p_employee_id IN NUMBER,
  p_percentage IN NUMBER
) IS
  v_current_salary NUMBER;
BEGIN
  SELECT salary INTO v_current_salary
  FROM employees
  WHERE employee_id = p_employee_id;

  UPDATE employees
  SET salary = salary + (salary * p_percentage / 100)
  WHERE employee_id = p_employee_id;

  COMMIT;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Employee ID does not exist.');
    ROLLBACK;
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
    ROLLBACK;
END UpdateSalary;
/ 
