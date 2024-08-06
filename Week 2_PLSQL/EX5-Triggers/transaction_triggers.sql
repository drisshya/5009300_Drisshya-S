CREATE TABLE Transactions (
    transaction_id NUMBER PRIMARY KEY,
    transaction_date DATE,
    account_id NUMBER,
    transaction_type VARCHAR2(20),
    amount NUMBER
);

CREATE TABLE AuditLog (
    audit_id NUMBER PRIMARY KEY,
    transaction_id NUMBER,
    transaction_date DATE,
    customer_id NUMBER,
    amount NUMBER,
    action VARCHAR2(20)
);

CREATE TABLE Customers (
    customer_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    email VARCHAR2(100),
    LastModified DATE
);

CREATE TABLE accounts (
    account_id NUMBER PRIMARY KEY,
    balance NUMBER
);

INSERT INTO accounts (account_id, balance) VALUES (1, 5000);
INSERT INTO accounts (account_id, balance) VALUES (2, 3000);

COMMIT;
