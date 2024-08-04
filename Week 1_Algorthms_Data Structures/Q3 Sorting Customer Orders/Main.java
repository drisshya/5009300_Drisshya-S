public class Main {
    public static void main(String[] args) {
        Order[] orders = {
            new Order(1, "Alice", 250.50),
            new Order(2, "Bob", 150.75),
            new Order(3, "Charlie", 450.00),
            new Order(4, "David", 320.00),
            new Order(5, "Eve", 120.00)
        };

        System.out.println("Bubble Sort:");
        SortingAlgorithm1.bubbleSort(orders);
        for (Order order : orders) {
            System.out.println(order);
        }

        // Reinitialize orders array for Quick Sort
        orders = new Order[] {
            new Order(1, "Alice", 250.50),
            new Order(2, "Bob", 150.75),
            new Order(3, "Charlie", 450.00),
            new Order(4, "David", 320.00),
            new Order(5, "Eve", 120.00)
        };

        System.out.println("\nQuick Sort:");
        SortingAlgorithm2.quickSort(orders, 0, orders.length - 1);
        for (Order order : orders) {
            System.out.println(order);
        }
    }
}
