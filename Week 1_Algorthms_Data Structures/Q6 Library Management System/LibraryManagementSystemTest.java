
package com.example.library;

import java.util.List;

public class LibraryManagementSystemTest {
    public static void main(String[] args) {
        Library library = new Library();

        // Add books
        library.addBook(new Book("B001", "The Great Gatsby", "F. Scott Fitzgerald"));
        library.addBook(new Book("B002", "1984", "George Orwell"));
        library.addBook(new Book("B003", "To Kill a Mockingbird", "Harper Lee"));
        library.addBook(new Book("B004", "The Catcher in the Rye", "J.D. Salinger"));
        library.addBook(new Book("B005", "Pride and Prejudice", "Jane Austen"));

        // Linear search
        System.out.println("Linear Search Results for '1984':");
        List<Book> foundBooks = library.searchBooksByTitleLinear("1984");
        for (Book book : foundBooks) {
            System.out.println(book);
        }

        // Binary search
        System.out.println("\nBinary Search Result for '1984':");
        Book foundBook = library.searchBooksByTitleBinary("1984");
        if (foundBook != null) {
            System.out.println(foundBook);
        } else {
            System.out.println("Book not found.");
        }
    }
}
