CREATE TABLE savings_accounts (
    account_id NUMBER PRIMARY KEY,
    balance NUMBER
);

CREATE TABLE accounts (
    account_id NUMBER PRIMARY KEY,
    balance NUMBER
);

CREATE TABLE employees (
    employee_id NUMBER PRIMARY KEY,
    salary NUMBER,
    department_id NUMBER
);

INSERT INTO savings_accounts (account_id, balance) VALUES (1, 10000);
INSERT INTO savings_accounts (account_id, balance) VALUES (2, 15000);

INSERT INTO accounts (account_id, balance) VALUES (1, 5000);
INSERT INTO accounts (account_id, balance) VALUES (2, 3000);

INSERT INTO employees (employee_id, salary, department_id) VALUES (1, 60000, 10);
INSERT INTO employees (employee_id, salary, department_id) VALUES (2, 50000, 10);
INSERT INTO employees (employee_id, salary, department_id) VALUES (3, 55000, 20);

COMMIT;

CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest IS
BEGIN
  UPDATE savings_accounts
  SET balance = balance * 1.01;

  COMMIT;
END ProcessMonthlyInterest;
/ 

CREATE OR REPLACE PROCEDURE TransferFunds (
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
    RAISE_APPLICATION_ERROR(-20001, 'Insufficient funds in the source account.');
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
    DBMS_OUTPUT.PUT_LINE('One or both account IDs do not exist.');
    ROLLBACK;
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
    ROLLBACK;
END TransferFunds;
/ 

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
  p_department_id IN NUMBER,
  p_bonus_percentage IN NUMBER
) IS
BEGIN
  UPDATE employees
  SET salary = salary + (salary * p_bonus_percentage / 100)
  WHERE department_id = p_department_id;

  COMMIT;
END UpdateEmployeeBonus;
/ 
