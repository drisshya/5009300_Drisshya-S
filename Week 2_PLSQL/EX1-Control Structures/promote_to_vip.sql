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
