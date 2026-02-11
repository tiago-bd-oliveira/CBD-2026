package cbd;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.params.ZRangeParams;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.time.Instant;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;
import java.util.function.Consumer;

public class Booking {
    protected static final Jedis jedis = new Jedis();

    // thresholds
    protected static final int TIMESLOT = 30; // minutes
    protected static final int PRODUCT_LIMIT = 2;

    // data keys
    protected static final String USERS_KEY = "users";
    protected static final String PRODUCTS_KEY = "products";
    // add :<booking_id> to get the info about the booking
    protected static final String BOOKINGS_KEY = "booking";
    // add :<username> to this key to get user bookings
    protected static final String USER_BOOKINGS_KEY = "user:bookings";

    // metadata keys
    protected static final String BOOKING_ID_COUNTER = "booking:id:counter";

    public void uploadData(String filePath, Consumer<String> lineProcessor) {
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    lineProcessor.accept(line.trim());
                }
            }
        } catch (IOException e) {
            System.err.println("File error: " + e.getMessage());
        }
    }

    public void parseUser(String line) {
        String username = line.trim();
        jedis.sadd(USERS_KEY, username);
    }

    public void parseProduct(String line) {
        String product = line.trim();
        jedis.sadd(PRODUCTS_KEY, product);
    }

    public void addBooking(String user, String product) {
        long id = jedis.incr(BOOKING_ID_COUNTER);
        String bookingKey = BOOKINGS_KEY + ":" + id;
        Instant ts = Instant.now();
        Map<String, String> booking = Map.of("product", product, "user", user, "ts", ts.toString());
        jedis.hset(bookingKey, booking);
        String userBookingKey = USER_BOOKINGS_KEY + ":" + user;
        jedis.zadd(userBookingKey, ts.getEpochSecond(), Long.toString(id));
    }

    public boolean validateBooking(String user){

        long now = Instant.now().getEpochSecond();
        long interval = now - TIMESLOT * 60;
        ZRangeParams params = ZRangeParams.zrangeByScoreParams(interval, now);

        String userBookingKey = USER_BOOKINGS_KEY + ":" + user;
        int numberOfBookings = jedis.zrange(userBookingKey, params).size();

        return numberOfBookings < PRODUCT_LIMIT;
    }

    public static void main(String[] args) {
        Booking bookingApp = new Booking();

        // 1. Initial Setup: Load your catalogs
        System.out.println("Initializing catalogs...");
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

                    // Apply your business logic (Max 10 per 30 mins)
                    if (bookingApp.validateBooking(currentUser)) {
                        bookingApp.addBooking(currentUser, product);
                        System.out.println("Success! Booking confirmed.");
                    } else {
                        System.out.println("Booking Refused: You've reached the limit of " + PRODUCT_LIMIT + " bookings per " + TIMESLOT + " minutes.");
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
                            System.out.printf("- ID: %s | Product: %s | Time: %s\n", id, details.get("product"), details.get("ts"));
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
