import java.util.ArrayList;
import java.util.List;

public class EmployeeManagementSystem {
    private List<Employee> employees;

    public EmployeeManagementSystem() {
        employees = new ArrayList<>();
    }

    public void addEmployee(Employee employee) {
        employees.add(employee);
    }

    public Employee searchEmployee(int employeeId) {
        for (Employee emp : employees) {
            if (emp.getEmployeeId() == employeeId) {
                return emp;
            }
        }
        return null;
    }

    public void traverseEmployees() {
        for (Employee emp : employees) {
            System.out.println(emp);
        }
    }

    public void deleteEmployee(int employeeId) {
        employees.removeIf(emp -> emp.getEmployeeId() == employeeId);
    }

    public static void main(String[] args) {
        EmployeeManagementSystem ems = new EmployeeManagementSystem();
        Employee emp1 = new Employee(1, "John Doe", "Developer", 60000);
        Employee emp2 = new Employee(2, "Jane Smith", "Manager", 80000);

        ems.addEmployee(emp1);
        ems.addEmployee(emp2);
        ems.traverseEmployees();

        System.out.println(ems.searchEmployee(1));

        ems.deleteEmployee(1);
        ems.traverseEmployees();
    }
}
