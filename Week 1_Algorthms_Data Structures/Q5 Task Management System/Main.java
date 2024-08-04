public class Main {
    public static void main(String[] args) {
        // Create a new TaskList
        TaskList taskList = new TaskList();

        // Add tasks to the list
        taskList.addTask(new Task(1, "Complete homework", "Pending"));
        taskList.addTask(new Task(2, "Read a book", "Completed"));
        taskList.addTask(new Task(3, "Go grocery shopping", "Pending"));

        // Display all tasks
        System.out.println("All tasks:");
        taskList.traverseTasks();

        // Search for a task by ID
        int searchId = 2;
        Task searchedTask = taskList.searchTask(searchId);
        if (searchedTask != null) {
            System.out.println("\nTask with ID " + searchId + " found: " + searchedTask);
        } else {
            System.out.println("\nTask with ID " + searchId + " not found.");
        }

        // Delete a task by ID
        int deleteId = 1;
        boolean isDeleted = taskList.deleteTask(deleteId);
        if (isDeleted) {
            System.out.println("\nTask with ID " + deleteId + " was deleted successfully.");
        } else {
            System.out.println("\nTask with ID " + deleteId + " not found.");
        }

        // Display remaining tasks
        System.out.println("\nRemaining tasks:");
        taskList.traverseTasks();
    }
}
