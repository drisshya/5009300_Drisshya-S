CREATE TABLE accounts (
    account_id NUMBER PRIMARY KEY,
    balance NUMBER
);

CREATE TABLE loans (
    loan_id NUMBER PRIMARY KEY,
    customer_id NUMBER,
    amount NUMBER,
    annual_interest_rate NUMBER,
    loan_duration_years NUMBER
);

CREATE TABLE employees (
    employee_id NUMBER PRIMARY KEY,
    salary NUMBER,
    department_id NUMBER
);

INSERT INTO accounts (account_id, balance) VALUES (1, 5000);
INSERT INTO accounts (account_id, balance) VALUES (2, 3000);

INSERT INTO loans (loan_id, customer_id, amount, annual_interest_rate, loan_duration_years) VALUES (1, 1, 10000, 5, 5);
INSERT INTO loans (loan_id, customer_id, amount, annual_interest_rate, loan_duration_years) VALUES (2, 2, 15000, 4, 10);

INSERT INTO employees (employee_id, salary, department_id) VALUES (1, 60000, 10);
INSERT INTO employees (employee_id, salary, department_id) VALUES (2, 50000, 10);
INSERT INTO employees (employee_id, salary, department_id) VALUES (3, 55000, 20);

COMMIT;

CREATE OR REPLACE FUNCTION CalculateAge (
  p_date_of_birth IN DATE
) RETURN NUMBER IS
  v_age NUMBER;
BEGIN
  SELECT FLOOR(MONTHS_BETWEEN(SYSDATE, p_date_of_birth) / 12) INTO v_age FROM dual;
  RETURN v_age;
END CalculateAge;
/ 

CREATE OR REPLACE FUNCTION CalculateMonthlyInstallment (
  p_loan_amount IN NUMBER,
  p_annual_interest_rate IN NUMBER,
  p_loan_duration_years IN NUMBER
) RETURN NUMBER IS
  v_monthly_interest_rate NUMBER;
  v_number_of_payments NUMBER;
  v_monthly_installment NUMBER;
BEGIN
  v_monthly_interest_rate := p_annual_interest_rate / 1200;
  v_number_of_payments := p_loan_duration_years * 12;

  v_monthly_installment := p_loan_amount * (v_monthly_interest_rate * POWER(1 + v_monthly_interest_rate, v_number_of_payments)) / 
                           (POWER(1 + v_monthly_interest_rate, v_number_of_payments) - 1);
  
  RETURN v_monthly_installment;
END CalculateMonthlyInstallment;
/ 

CREATE OR REPLACE FUNCTION HasSufficientBalance (
  p_account_id IN NUMBER,
  p_amount IN NUMBER
) RETURN BOOLEAN IS
  v_balance NUMBER;
BEGIN
  SELECT balance INTO v_balance
  FROM accounts
  WHERE account_id = p_account_id;

  IF v_balance >= p_amount THEN
    RETURN TRUE;
  ELSE
    RETURN FALSE;
  END IF;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN FALSE;
END HasSufficientBalance;
/ 
