import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.FindOneAndUpdateOptions;
import com.mongodb.client.model.ReturnDocument;
import com.mongodb.client.model.Updates;
import org.bson.Document;
import org.bson.conversions.Bson;

import java.time.Instant;
import java.util.Date;

public class ProductManager {

    private final MongoCollection<Document> bucketCollection;
    final private int timeslotSeconds;
    final private int requestThreshold;

    public ProductManager(MongoDatabase database, int timeslotSeconds, int requestThreshold) {
        this.bucketCollection = database.getCollection("request_buckets");
        this.timeslotSeconds = timeslotSeconds;
        this.requestThreshold = requestThreshold;
    }

    public void requestProduct(String username, String product, int quantity) {
        long now = Instant.now().getEpochSecond();

        long timestamp = (now / timeslotSeconds) * timeslotSeconds;
        String bucketId = username + "_" + timestamp;

        Document productEntry = new Document("name", product)
                .append("quantity", quantity);

        Bson filter = Filters.eq("_id", bucketId);
        Bson update = Updates.combine(
                Updates.inc("current_count", quantity),
                Updates.push("products", productEntry),
                Updates.setOnInsert("username", username),
                Updates.setOnInsert("timeslot_start", timestamp),
                Updates.setOnInsert("expireAt", new Date((timestamp + timeslotSeconds) * 1000))
        );

        var options = new FindOneAndUpdateOptions()
                .upsert(true)
                .returnDocument(ReturnDocument.AFTER);

        Document result = bucketCollection.findOneAndUpdate(filter, update, options);

        if (result != null && result.getInteger("current_count") <= requestThreshold) {
            System.out.println("[SUCCESS] Product '" + product + "' recorded for user: " + username);
        } else {
            bucketCollection.updateOne(filter, Updates.inc("current_count", -1));
            System.err.println("[ERROR] Limit exceeded for user '" + username +
                    "'. Max allowed: " + requestThreshold + " per " + timeslotSeconds + "s.");
        }
    }

    public static void main(String[] args) {
        try (MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017")) {
            MongoDatabase database = mongoClient.getDatabase("store_db");

            int timeslot = 5;
            int threshold = 10;
            ProductManager manager = new ProductManager(database, timeslot, threshold);

            String user = "tech_enthusiast_99";

            System.out.println("--- Starting Test: Window 1 ---");

            manager.requestProduct(user, "Mechanical Keyboard", 2);
            manager.requestProduct(user, "Gaming Mouse", 1);

            manager.requestProduct(user, "Ultrawide Monitor", 7);

            manager.requestProduct(user, "USB-C Cable", 1);

            System.out.println("\n--- Waiting for next timeslot (" + timeslot + "s) ---");
            try {
                Thread.sleep((timeslot + 1) * 1000);
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }

            System.out.println("--- Starting Test: Window 2 (Limit Reset) ---");

            manager.requestProduct(user, "Webcam", 5);

            manager.requestProduct(user, "Graphic Card", 50);

        } catch (Exception e) {
            System.err.println("Connection error: " + e.getMessage());
        }
    }
}
