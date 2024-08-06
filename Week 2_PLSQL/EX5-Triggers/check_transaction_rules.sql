CREATE OR REPLACE TRIGGER CheckTransactionRules
BEFORE INSERT ON Transactions
FOR EACH ROW
DECLARE
  v_balance NUMBER;
BEGIN
  IF :NEW.transaction_type = 'WITHDRAWAL' THEN
    SELECT balance INTO v_balance
    FROM accounts
    WHERE account_id = :NEW.account_id;
    
    IF v_balance < :NEW.amount THEN
      RAISE_APPLICATION_ERROR(-20002, 'Withdrawal amount exceeds account balance.');
    END IF;

  ELSIF :NEW.transaction_type = 'DEPOSIT' THEN
    IF :NEW.amount <= 0 THEN
      RAISE_APPLICATION_ERROR(-20003, 'Deposit amount must be positive.');
    END IF;

  END IF;
END CheckTransactionRules;
/
