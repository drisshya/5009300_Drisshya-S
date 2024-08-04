public class SearchAlgorithms {
    public static Product linearSearch(Product[] products, int searchId) {
        for (Product product : products) {
            if (product.getProductId() == searchId) {
                return product;
            }
        }
        return null; 
    }
}
