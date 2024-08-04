public class Main {
    public static void main(String[] args) {
        InventoryManagementSystem ims = new InventoryManagementSystem();
        
        // Adding products
        ims.addProduct(new Product(1, "Laptop", 10, 999.99));
        ims.addProduct(new Product(2, "Mouse", 100, 25.50));
        
        // Updating a product
        ims.updateProduct(1, "Gaming Laptop", 8, 1299.99);
        
        // Retrieving a product
        Product p = ims.getProduct(1);
        if (p != null) {
            System.out.println("Product ID: " + p.getProductId());
            System.out.println("Name: " + p.getProductName());
            System.out.println("Quantity: " + p.getQuantity());
            System.out.println("Price: " + p.getPrice());
        }
        
        // Deleting a product
        ims.deleteProduct(2);
    }
}
