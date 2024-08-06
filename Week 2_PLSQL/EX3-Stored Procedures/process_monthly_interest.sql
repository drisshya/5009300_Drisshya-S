CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest IS
BEGIN
  UPDATE savings_accounts
  SET balance = balance * 1.01;

  COMMIT;
END ProcessMonthlyInterest;
/
