public class ProxyPatternTest {
    public static void main(String[] args) {
        Image image1 = new ProxyImage("image1.jpg");
        Image image2 = new ProxyImage("image2.jpg");

        System.out.println("Displaying images for the first time:");
        image1.display();     
        image2.display(); 
        System.out.println("\nDisplaying images again:");
        image1.display(); 
        image2.display(); 
    }
}
