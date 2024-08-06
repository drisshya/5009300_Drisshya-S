CREATE OR REPLACE TRIGGER LogTransaction
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
  INSERT INTO AuditLog (transaction_id, transaction_date, customer_id, amount, action)
  VALUES (:NEW.transaction_id, :NEW.transaction_date, :NEW.customer_id, :NEW.amount, 'INSERT');
END LogTransaction;
/
