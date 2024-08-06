CREATE TABLE accounts (
    account_id NUMBER PRIMARY KEY,
    balance NUMBER
);

CREATE TABLE transactions (
    transaction_id NUMBER PRIMARY KEY,
    transaction_date DATE,
    account_id NUMBER,
    transaction_type VARCHAR2(20),
    amount NUMBER,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

CREATE TABLE loans (
    loan_id NUMBER PRIMARY KEY,
    interest_rate NUMBER
);

CREATE TABLE customers (
    customer_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    email VARCHAR2(100)
);

INSERT INTO accounts (account_id, balance) VALUES (1, 5000);
INSERT INTO accounts (account_id, balance) VALUES (2, 3000);

INSERT INTO transactions (transaction_id, transaction_date, account_id, transaction_type, amount) VALUES (1, SYSDATE, 1, 'WITHDRAWAL', 100);
INSERT INTO transactions (transaction_id, transaction_date, account_id, transaction_type, amount) VALUES (2, SYSDATE, 2, 'DEPOSIT', 200);

INSERT INTO loans (loan_id, interest_rate) VALUES (1, 0.05);
INSERT INTO loans (loan_id, interest_rate) VALUES (2, 0.07);

INSERT INTO customers (customer_id, name, email) VALUES (1, 'John Doe', 'john.doe@example.com');
INSERT INTO customers (customer_id, name, email) VALUES (2, 'Jane Smith', 'jane.smith@example.com');

COMMIT;
