
public class MVCPatternExample {
    public static void main(String[] args) {
         Student model = new Student("1", "John Doe", "A");

        
        StudentView view = new StudentView();
        StudentController controller = new StudentController(model, view);

        controller.updateView();

        controller.setStudentName("Jane Doe");
        controller.setStudentGrade("B");
        controller.updateView();
    }
}
