DECLARE
  CURSOR c_transactions IS
    SELECT customer_id, transaction_date, amount, transaction_type
    FROM transactions
    WHERE EXTRACT(MONTH FROM transaction_date) = EXTRACT(MONTH FROM SYSDATE)
    AND EXTRACT(YEAR FROM transaction_date) = EXTRACT(YEAR FROM SYSDATE);

  v_customer_id Customers.customer_id%TYPE;
  v_transaction_date Transactions.transaction_date%TYPE;
  v_amount Transactions.amount%TYPE;
  v_transaction_type Transactions.transaction_type%TYPE;

BEGIN
  OPEN c_transactions;

  LOOP
    FETCH c_transactions INTO v_customer_id, v_transaction_date, v_amount, v_transaction_type;
    EXIT WHEN c_transactions%NOTFOUND;

    -- Print statement for each customer
    DBMS_OUTPUT.PUT_LINE('Customer ID: ' || v_customer_id || ', Date: ' || v_transaction_date ||
                         ', Amount: ' || v_amount || ', Type: ' || v_transaction_type);

  END LOOP;

  CLOSE c_transactions;
END;
/
