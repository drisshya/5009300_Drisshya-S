BEGIN
  FOR rec IN (SELECT customer_id, age, loan_interest_rate
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
