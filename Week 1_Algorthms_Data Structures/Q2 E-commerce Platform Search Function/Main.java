import java.util.Arrays;

public class Main {
    public static void main(String[] args) {
        // Create an array of Product objects
        Product[] products = {
            new Product(101, "Laptop", "Electronics"),
            new Product(102, "Smartphone", "Electronics"),
            new Product(103, "Desk Chair", "Furniture"),
            new Product(104, "Coffee Maker", "Appliances"),
            new Product(105, "Bluetooth Speaker", "Electronics")
        };

        // Perform linear search
        int searchIdLinear = 103;
        Product foundProductLinear = SearchAlgorithms.linearSearch(products, searchIdLinear);
        System.out.println("Linear Search Result:");
        if (foundProductLinear != null) {
            System.out.println(foundProductLinear);
        } else {
            System.out.println("Product not found.");
        }

        // Sort products by ID for binary search
        SearchAlgorithm2.sortProductsById(products);

        // Perform binary search
        int searchIdBinary = 104;
        Product foundProductBinary = SearchAlgorithm2.binarySearch(products, searchIdBinary);
        System.out.println("Binary Search Result:");
        if (foundProductBinary != null) {
            System.out.println(foundProductBinary);
        } else {
            System.out.println("Product not found.");
        }

        // Additional test: Product not present
        int searchIdNotFound = 999;
        Product notFoundProduct = SearchAlgorithm2.binarySearch(products, searchIdNotFound);
        System.out.println("Search for a non-existing product:");
        if (notFoundProduct != null) {
            System.out.println(notFoundProduct);
        } else {
            System.out.println("Product not found.");
        }
    }
}
