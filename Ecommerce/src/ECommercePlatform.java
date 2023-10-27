// TITLE : E-commerce Platform
// SUBJECT : JAVA-II
// Date : 6 Oct 2023
// ENROLLMENT NO. : Hamza:22002171510019, Satyam:22002171410050 , Dhruvil:22002170410003 , Zaif:22002171410033 , Musaib:22002171410030


import java.sql.*;
import java.util.*;

// Database
public class ECommercePlatform {
    private static final String DB_URL = "jdbc:mysql://localhost/ecommerce";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";
    private static String email;

    public static void main(String[] args) {
        try {
            // Daabase connection
            Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            Scanner sc = new Scanner(System.in);

            while (true) {
                // Menu for user
                System.out.println("-----------------------------------------");
                System.out.println("Welcome to the Online Shopping System!");
                System.out.println("1. Register");
                System.out.println("2. Login");
                System.out.println("3. Browse Products");
                System.out.println("4. View Cart");
                System.out.println("5. Checkout");
                System.out.println("6. Exit");
                System.out.print("Please select an option: ");

                int choice = sc.nextInt();

                switch (choice) {
                    case 1:
                        registerUser(con);
                        break;
                    case 2:
                        loginUser(con);
                        break;
                    case 3:
                        browseProducts(con);
                        break;
                    case 4:
                        viewCart(con, getUserIdByEmail(con, email));
                        break;
                    case 5:
                        checkout(con, getUserIdByEmail(con, email));
                        break;
                    case 6:
                        System.out.println("Thank you, visit again!");
                        con.close();
                        return;
                    default:
                        System.out.println("Invalid option. Please try again.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Regiter a user in database
    private static void registerUser(Connection con) throws SQLException {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter firstname: ");
        String firstname = sc.nextLine();
        System.out.print("Enter lastname: ");
        String lastname = sc.nextLine();
        System.out.print("Enter email: ");
        String email = sc.nextLine(); 
        System.out.print("Enter password: ");
        String password = sc.nextLine();
        System.out.print("Enter mobile: ");
        String mobile = sc.nextLine();

        String sql = "INSERT INTO users (firstname, lastname, email, password, mobile) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, firstname);
        pst.setString(2, lastname);
        pst.setString(3, email);
        pst.setString(4, password);
        pst.setString(5, mobile);

        int rowsAffected = pst.executeUpdate();
        if (rowsAffected > 0) {
            System.out.println("User registered successfully!");
        } else {
            System.out.println("User registration failed.");
        }
    }

    // login as existing user using email and password from database
    private static void loginUser(Connection con) throws SQLException {
        Scanner sc = new Scanner(System.in);

        while (true) {
            System.out.print("Enter email: ");
            String inputEmail = sc.nextLine(); 
            System.out.print("Enter password: ");
            String password = sc.nextLine();

            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, inputEmail); 
            pst.setString(2, password);

            ResultSet resultSet = pst.executeQuery();

            if (resultSet.next()) {
                email = inputEmail; // Store the logged-in email
                System.out.println("Login successful!");
                break; // Exit the loop if login is successful
            } else {
                System.out.println();
                System.out.println("Incorrect email or password!");
                System.out.println();
            }
        }
    }

    // Browsing product and placing order with quantity
    private static void browseProducts(Connection con) throws SQLException {
        Scanner sc = new Scanner(System.in);
        System.out.println("Select a category:");
    
        // Fetch category data from the database
        String categoryQuery = "SELECT * FROM categories";
        PreparedStatement categoryPst = con.prepareStatement(categoryQuery);
        ResultSet categoryResultSet = categoryPst.executeQuery();
    
        while (categoryResultSet.next()) {
            int categoryId = categoryResultSet.getInt("category_id");
            String categoryName = categoryResultSet.getString("category_name");
            System.out.println(categoryId + ". " + categoryName);
        }
    
        int categoryChoice = sc.nextInt();
        String category = getCategoryFromChoice(categoryChoice);
    
        String sql = "SELECT * FROM products WHERE category_id = ?";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setInt(1, categoryChoice);
    
        ResultSet resultSet = pst.executeQuery();
    
        System.out.println("Available " + category + " Products:");
        while (resultSet.next()) {
            int productId = resultSet.getInt("product_id");
            String productName = resultSet.getString("product_name");
            String productDescription = resultSet.getString("description");
            double productPrice = resultSet.getDouble("price");
    
            System.out.println("-----------------------------------");
            System.out.println("Product ID: " + productId);
            System.out.println("Name: " + productName);
            System.out.println("Description: " + productDescription);
            System.out.println("Price: Rs" + productPrice);
            System.out.println("-----------------------------------");
            System.out.println();
        }
    
        // After displaying products, asking the user if they want to place an order
        System.out.print("Do you want to place an order (yes/no)? ");
        String orderChoice = sc.next().toLowerCase();
        
        // User placing order by selectedProductId and quantity
        while(orderChoice.equals("yes")){
            System.out.print("Enter the Product ID you want to order: ");
            int selectedProductId = sc.nextInt();
            System.out.print("Enter the quantity you want to order: ");
            int quantity = sc.nextInt();
            addToCart(con, getUserIdByEmail(con, email), selectedProductId, quantity);
            System.out.print("Do you want to place more order (yes/no)? ");
            orderChoice = sc.next().toLowerCase();
            if(orderChoice == "no"){
                break;
            }
        }
    }

    // Choosing category of product
    private static String getCategoryFromChoice(int choice) {
        switch (choice) {
            case 1:
                return "Laptop";
            case 2:
                return "PC";
            case 3:
                return "Printer";
            case 4:
                return "Accessories";
            default:
                return ""; 
        }
    }
    
    // retrieve the user's order history
    private static void displayOrderHistory(Connection con, int userId) throws SQLException {
        String sql = "SELECT o.product_id, p.product_name, SUM(o.quantity) AS total_quantity " +
                    "FROM orders o " +
                    "INNER JOIN products p ON o.product_id = p.product_id " +
                    "WHERE o.user_id = ? " +
                    "GROUP BY o.product_id, p.product_name";

        PreparedStatement pst = con.prepareStatement(sql);
        pst.setInt(1, userId);
        ResultSet resultSet = pst.executeQuery();

        System.out.println("-----------------------------------");
        System.out.println("Order History");
        while (resultSet.next()) {
            int productId = resultSet.getInt("product_id");
            String productName = resultSet.getString("product_name");
            int totalQuantity = resultSet.getInt("total_quantity");

            System.out.println("Product ID: " + productId);
            System.out.println("Product Name: " + productName);
            System.out.println("Total Quantity: " + totalQuantity);
            System.out.println("-----------------------------------");
        }
    }


    // User choosing product to add in cart
    private static void addToCart(Connection con, int userId, int productId, int quantity) throws SQLException {
        String sql = "INSERT INTO carts (user_id, product_id, quantity) VALUES (?, ?, ?)";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setInt(1, userId);
        pst.setInt(2, productId);
        pst.setInt(3, quantity);
    
        int rowsAffected = pst.executeUpdate();
        if (rowsAffected > 0) {
            System.out.println("Product added to cart successfully!");
            System.out.println("-----------------------------------");
        } else {
            System.out.println("Failed to add product to cart.");
            System.out.println("-----------------------------------");
        }
    }
    
    // Displays product from the user's cart
    // Displays product from the user's cart and calculates the total price
private static void viewCart(Connection con, int userId) throws SQLException {
    String sql = "SELECT c.cart_id, p.product_name, c.quantity, p.price " +
                 "FROM carts c " +
                 "INNER JOIN products p ON c.product_id = p.product_id " +
                 "WHERE c.user_id = ?";
    PreparedStatement pst = con.prepareStatement(sql);
    pst.setInt(1, userId);
    ResultSet resultSet = pst.executeQuery();

    double totalCartPrice = 0.0; // Initialize total cart price

    System.out.println("-----------------------------------");
    System.out.println("Shopping Cart");
    while (resultSet.next()) {
        int cartId = resultSet.getInt("cart_id");
        String productName = resultSet.getString("product_name");
        int cartQuantity = resultSet.getInt("quantity");
        double productPrice = resultSet.getDouble("price");

        double totalPriceForProduct = productPrice * cartQuantity;
        totalCartPrice += totalPriceForProduct; // Update total cart price

        System.out.println("Cart ID: " + cartId);
        System.out.println("Product Name: " + productName);
        System.out.println("Quantity: " + cartQuantity);
        System.out.println("Total Price for Product: Rs" + totalPriceForProduct); // Display total price for the product
        System.out.println("-----------------------------------");
    }

    // Display the total cart price
    System.out.println("Total Cart Price: Rs" + totalCartPrice);
    System.out.println("-----------------------------------");
}

    
    // Placing order
    private static void checkout(Connection con, int userId) throws SQLException {
        Scanner sc = new Scanner(System.in);
        // Retrieve items from the user's cart
        String getCartItemsSql = "SELECT * FROM carts WHERE user_id = ?";
        PreparedStatement getCartItemsPst = con.prepareStatement(getCartItemsSql);
        getCartItemsPst.setInt(1, userId);
        ResultSet cartItemsResultSet = getCartItemsPst.executeQuery();
        System.out.print("Enter your Shipping adderess : ");
        String address = sc.nextLine();

        // Initialize a list to store cart item IDs
        List<Integer> cartItemIds = new ArrayList<>();

        while (cartItemsResultSet.next()) {
            int cartId = cartItemsResultSet.getInt("cart_id");
            cartItemIds.add(cartId);
        }

        // Delete associated cart items
        String deleteCartItemsSql = "DELETE FROM cart_items WHERE cart_id = ?";
        PreparedStatement deleteCartItemsPst = con.prepareStatement(deleteCartItemsSql);

        for (int cartItemId : cartItemIds) {
            deleteCartItemsPst.setInt(1, cartItemId);
            deleteCartItemsPst.executeUpdate();
        }

        // Now that associated cart items have been deleted, delete the cart itself
        String deleteCartSql = "DELETE FROM carts WHERE user_id = ?";
        PreparedStatement deleteCartPst = con.prepareStatement(deleteCartSql);
        deleteCartPst.setInt(1, userId);
        deleteCartPst.executeUpdate();

        System.out.println("Order placed successfully!");
        System.out.println("-----------------------------------");
    }

    // retrieve a user's ID based on their email
    private static int getUserIdByEmail(Connection con, String email) throws SQLException {
        String sql = "SELECT user_id FROM users WHERE email = ?";
        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, email); // Set the email as a parameter
        ResultSet resultSet = pst.executeQuery();
        if (resultSet.next()) {
            return resultSet.getInt("user_id");
        } else {
            return -1; // User not found
        }
    }
}
