CREATE OR REPLACE PROCEDURE UpdateSalary (
  p_employee_id IN NUMBER,
  p_percentage IN NUMBER
) IS
  v_current_salary NUMBER;
BEGIN
  SELECT salary INTO v_current_salary
  FROM employees
  WHERE employee_id = p_employee_id;

  UPDATE employees
  SET salary = salary + (salary * p_percentage / 100)
  WHERE employee_id = p_employee_id;

  COMMIT;

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Employee ID does not exist.');
    ROLLBACK;
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
    ROLLBACK;
END UpdateSalary;
/
