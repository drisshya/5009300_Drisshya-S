CREATE OR REPLACE FUNCTION CalculateMonthlyInstallment (
  p_loan_amount IN NUMBER,
  p_annual_interest_rate IN NUMBER,
  p_loan_duration_years IN NUMBER
) RETURN NUMBER IS
  v_monthly_interest_rate NUMBER;
  v_number_of_payments NUMBER;
  v_monthly_installment NUMBER;
BEGIN
  v_monthly_interest_rate := p_annual_interest_rate / 1200;
  v_number_of_payments := p_loan_duration_years * 12;

  v_monthly_installment := p_loan_amount * (v_monthly_interest_rate * POWER(1 + v_monthly_interest_rate, v_number_of_payments)) / 
                           (POWER(1 + v_monthly_interest_rate, v_number_of_payments) - 1);
  
  RETURN v_monthly_installment;
END CalculateMonthlyInstallment;
/
