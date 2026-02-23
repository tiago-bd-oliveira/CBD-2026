package ex15;

import redis.clients.jedis.Pipeline;
import redis.clients.jedis.Response;

import java.time.Instant;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

public class BookingWithQuantities extends Booking {

    public void addBooking(String user, String product, int quantity) {
        long id = jedis.incr(BOOKING_ID_COUNTER);
        String bookingKey = BOOKINGS_KEY + ":" + id;
        Instant ts = Instant.now();
        Map<String, String> booking = Map.of("product", product, "quantity", Integer.toString(quantity), "user", user, "ts", ts.toString());
        jedis.hset(bookingKey, booking);
        String userBookingKey = USER_BOOKINGS_KEY + ":" + user;
        jedis.zadd(userBookingKey, ts.getEpochSecond(), Long.toString(id));
    }


    public boolean validateBooking(String user, int requestedQuantity) {
        long now = Instant.now().getEpochSecond();
        long interval = now - TIMESLOT * 60;
        String userBookingKey = USER_BOOKINGS_KEY + ":" + user;

        List<String> recentBookingIds = jedis.zrangeByScore(userBookingKey, interval, now);

        if (recentBookingIds.isEmpty()) {
            return requestedQuantity <= PRODUCT_LIMIT;
        }

        int currentTotalQuantity = 0;

        // 2. Fetch the 'quantity' for all recent bookings using a Pipeline
        try (Pipeline p = jedis.pipelined()) {
            Map<String, Response<String>> quantityResponses = new HashMap<>();

            for (String id : recentBookingIds) {
                // We use HGET to grab ONLY the quantity field, not the whole hash
                String bookingKey = BOOKINGS_KEY + ":" + id;
                quantityResponses.put(id, p.hget(bookingKey, "quantity"));
            }

            p.sync(); // Execute all HGETs at once

            // 3. Sum the retrieved quantities
            for (Response<String> res : quantityResponses.values()) {
                String qtyStr = res.get();
                if (qtyStr != null) {
                    currentTotalQuantity += Integer.parseInt(qtyStr);
                }
            }

            return (currentTotalQuantity + requestedQuantity) <= PRODUCT_LIMIT;
        }
    }

    public static void main(String[] args) {
        BookingWithQuantities bookingApp = new BookingWithQuantities();

        // 1. Initial Setup: Load your catalogs
        System.out.println("Initializing catalogs...");
        // Assuming you have these files from previous steps
        bookingApp.uploadData("./resources/names.txt", bookingApp::parseUser);
        bookingApp.uploadData("./resources/products.csv", bookingApp::parseProduct);

        Scanner scanner = new Scanner(System.in);
        System.out.println("\n--- Redis Booking System ---");

        // 2. Identify the User
        System.out.print("Enter your username: ");
        String currentUser = scanner.nextLine().trim();

        if (!jedis.sismember(USERS_KEY, currentUser)) {
            System.out.println("User not found in system. Please register first.");
            return;
        }

        // 3. Simple Interaction Loop
        boolean running = true;
        while (running) {
            System.out.println("\nAvailable commands: [book], [history], [quit]");
            System.out.print(currentUser + " > ");
            String cmd = scanner.nextLine().trim().toLowerCase();

            switch (cmd) {
                case "book":
                    System.out.print("Enter product name: ");
                    String product = scanner.nextLine().trim();

                    // Validate product exists
                    if (!jedis.sismember(PRODUCTS_KEY, product)) {
                        System.out.println("Error: Product '" + product + "' does not exist.");
                        break;
                    }

                    // Prompt for Quantity
                    System.out.print("Enter quantity: ");
                    int quantity;
                    try {
                        quantity = Integer.parseInt(scanner.nextLine().trim());
                        if (quantity <= 0) {
                            System.out.println("Quantity must be greater than 0.");
                            break;
                        }
                    } catch (NumberFormatException e) {
                        System.out.println("Invalid number format. Please enter a valid integer.");
                        break;
                    }

                    // Apply your new quantity-based business logic
                    if (bookingApp.validateBooking(currentUser, quantity)) {
                        bookingApp.addBooking(currentUser, product, quantity);
                        System.out.println("Success! Booking confirmed for " + quantity + " unit(s) of " + product + ".");
                    } else {
                        System.out.println("Booking Refused: This request exceeds your limit of " + PRODUCT_LIMIT + " items per " + TIMESLOT + " minutes.");
                    }
                    break;

                case "history":
                    String userKey = USER_BOOKINGS_KEY + ":" + currentUser;
                    // Get all IDs from newest to oldest
                    List<String> ids = jedis.zrevrange(userKey, 0, -1);

                    if (ids.isEmpty()) {
                        System.out.println("No booking history found.");
                    } else {
                        System.out.println("Your Bookings (newest first):");
                        for (String id : ids) {
                            Map<String, String> details = jedis.hgetAll(BOOKINGS_KEY + ":" + id);
                            // Updated to print the quantity as well
                            System.out.printf("- ID: %s | Product: %s | Qty: %s | Time: %s\n",
                                    id,
                                    details.get("product"),
                                    details.get("quantity"),
                                    details.get("ts"));
                        }
                    }
                    break;

                case "quit":
                    running = false;
                    break;

                default:
                    System.out.println("Unknown command.");
            }
        }
        scanner.close();
        System.out.println("Goodbye!");
    }
}
