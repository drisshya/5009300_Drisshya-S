CREATE TABLE customers (
    customer_id NUMBER PRIMARY KEY,
    age NUMBER,
    loan_interest_rate NUMBER,
    IsVIP BOOLEAN DEFAULT FALSE
);

CREATE TABLE loans (
    loan_id NUMBER PRIMARY KEY,
    customer_id NUMBER,
    interest_rate NUMBER,
    due_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE accounts (
    customer_id NUMBER PRIMARY KEY,
    balance NUMBER,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, age, loan_interest_rate, IsVIP) VALUES (1, 65, 0.05, FALSE);
INSERT INTO customers (customer_id, age, loan_interest_rate, IsVIP) VALUES (2, 70, 0.06, FALSE);
INSERT INTO customers (customer_id, age, loan_interest_rate, IsVIP) VALUES (3, 55, 0.07, FALSE);

INSERT INTO loans (loan_id, customer_id, interest_rate, due_date) VALUES (101, 1, 0.05, SYSDATE + 15);
INSERT INTO loans (loan_id, customer_id, interest_rate, due_date) VALUES (102, 2, 0.06, SYSDATE + 40);
INSERT INTO loans (loan_id, customer_id, interest_rate, due_date) VALUES (103, 3, 0.07, SYSDATE + 10);

INSERT INTO accounts (customer_id, balance) VALUES (1, 15000);
INSERT INTO accounts (customer_id, balance) VALUES (2, 5000);
INSERT INTO accounts (customer_id, balance) VALUES (3, 20000);

COMMIT;

BEGIN
  FOR rec IN (SELECT customer_id, loan_interest_rate
              FROM customers
              WHERE age > 60) 
  LOOP
    UPDATE loans
    SET interest_rate = rec.loan_interest_rate - 0.01
    WHERE customer_id = rec.customer_id;

    DBMS_OUTPUT.PUT_LINE('Customer ID ' || rec.customer_id || ' has had their loan interest rate reduced by 1%.');
  END LOOP;
  
  COMMIT;
END;
/

BEGIN
  FOR rec IN (SELECT customer_id, balance
              FROM accounts
              WHERE balance > 10000) 
  LOOP
    UPDATE customers
    SET IsVIP = TRUE
    WHERE customer_id = rec.customer_id;

    DBMS_OUTPUT.PUT_LINE('Customer ID ' || rec.customer_id || ' has been promoted to VIP status.');
  END LOOP;
  
  COMMIT;
END;
/

BEGIN
  FOR rec IN (SELECT loan_id, customer_id, due_date
              FROM loans
              WHERE due_date BETWEEN SYSDATE AND SYSDATE + 30) 
  LOOP
    DBMS_OUTPUT.PUT_LINE('Reminder: Loan ID ' || rec.loan_id || ' for Customer ID ' || rec.customer_id || ' is due on ' || rec.due_date || '. Please make sure to make the payment before the due date.');
  END LOOP;
END;
/
