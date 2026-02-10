package cbd;

import redis.clients.jedis.Jedis;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.time.Instant;
import java.util.HashMap;
import java.util.Map;
import java.util.function.Consumer;

public class Booking {
    protected static final Jedis jedis = new Jedis();

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
        jedis.zadd(userBookingKey, ts.getNano(), Long.toString(id));
    }

}
