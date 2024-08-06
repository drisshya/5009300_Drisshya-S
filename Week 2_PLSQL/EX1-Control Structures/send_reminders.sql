BEGIN
  FOR rec IN (SELECT loan_id, customer_id, due_date
              FROM loans
              WHERE due_date BETWEEN SYSDATE AND SYSDATE + 30) 
  LOOP
    DBMS_OUTPUT.PUT_LINE('Reminder: Loan ID ' || rec.loan_id || ' for Customer ID ' || rec.customer_id || ' is due on ' || rec.due_date || '. Please make sure to make the payment before the due date.');
  END LOOP;
END;
/
