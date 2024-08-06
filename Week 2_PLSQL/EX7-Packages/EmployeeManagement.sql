CREATE OR REPLACE PACKAGE EmployeeManagement AS
    PROCEDURE HireEmployee(
        p_EmployeeID IN NUMBER,
        p_Name IN VARCHAR2,
        p_Position IN VARCHAR2,
        p_Salary IN NUMBER,
        p_Department IN VARCHAR2,
        p_HireDate IN DATE
    );
    
    PROCEDURE UpdateEmployee(
        p_EmployeeID IN NUMBER,
        p_Name IN VARCHAR2,
        p_Salary IN NUMBER
    );
    
    FUNCTION CalculateAnnualSalary(
        p_EmployeeID IN NUMBER
    ) RETURN NUMBER;
END EmployeeManagement;
/

CREATE OR REPLACE PACKAGE BODY EmployeeManagement AS

    PROCEDURE HireEmployee(
        p_EmployeeID IN NUMBER,
        p_Name IN VARCHAR2,
        p_Position IN VARCHAR2,
        p_Salary IN NUMBER,
        p_Department IN VARCHAR2,
        p_HireDate IN DATE
    ) IS
    BEGIN
        INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
        VALUES (p_EmployeeID, p_Name, p_Position, p_Salary, p_Department, p_HireDate);
    END HireEmployee;
    
    PROCEDURE UpdateEmployee(
        p_EmployeeID IN NUMBER,
        p_Name IN VARCHAR2,
        p_Salary IN NUMBER
    ) IS
    BEGIN
        UPDATE Employees
        SET Name = p_Name, Salary = p_Salary
        WHERE EmployeeID = p_EmployeeID;
    END UpdateEmployee;
    
    FUNCTION CalculateAnnualSalary(
        p_EmployeeID IN NUMBER
    ) RETURN NUMBER IS
        v_AnnualSalary NUMBER;
    BEGIN
        SELECT Salary * 12 INTO v_AnnualSalary
        FROM Employees
        WHERE EmployeeID = p_EmployeeID;
        RETURN v_AnnualSalary;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END CalculateAnnualSalary;

END EmployeeManagement;
/
