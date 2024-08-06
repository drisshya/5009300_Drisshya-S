DECLARE
  CURSOR c_loans IS
    SELECT loan_id, interest_rate
    FROM loans;

  v_loan_id Loans.loan_id%TYPE;
  v_interest_rate Loans.interest_rate%TYPE;
  v_new_interest_rate NUMBER := 0.05; -- Example new interest rate policy

BEGIN
  OPEN c_loans;

  LOOP
    FETCH c_loans INTO v_loan_id, v_interest_rate;
    EXIT WHEN c_loans%NOTFOUND;

    -- Update interest rate
    UPDATE loans
    SET interest_rate = v_new_interest_rate
    WHERE loan_id = v_loan_id;

  END LOOP;

  CLOSE c_loans;
  COMMIT;
END;
/
