import java.util.Arrays;

public class SearchAlgorithm2 {

    
    public static Product binarySearch(Product[] products, int searchId) {
        int left = 0;
        int right = products.length - 1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (products[mid].getProductId() == searchId) {
                return products[mid];
            } else if (products[mid].getProductId() < searchId) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return null; 
    }

    public static void sortProductsById(Product[] products) {
        Arrays.sort(products, (a, b) -> Integer.compare(a.getProductId(), b.getProductId()));
    }
}
