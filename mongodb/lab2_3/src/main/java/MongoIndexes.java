import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Indexes;
import org.bson.Document;

public class MongoIndexes {
    public static void main(String[] args) {
        String uri = "mongodb://localhost:27017";

        try (MongoClient mongoClient = MongoClients.create(uri)) {
            MongoDatabase database = mongoClient.getDatabase("cbd");
            MongoCollection<Document> collection = database.getCollection("restaurants");

            collection.dropIndexes();

            System.out.println("=== 1. Testing Without Indexes ===");

            long startUnindexedLocality = System.nanoTime();
            long countUnindexedBronx = collection.countDocuments(Filters.eq("localidade", "Bronx"));
            long endUnindexedLocality = System.nanoTime();

            System.out.println("Found (Locality): " + countUnindexedBronx);
            System.out.println("Time (Unindexed Locality): " + (endUnindexedLocality - startUnindexedLocality) / 1_000_000.0 + " ms");

            long startUnindexedText = System.nanoTime();
            long countUnindexedCafe = collection.countDocuments(Filters.regex("nome", ".*Cafe.*", "i"));
            long endUnindexedText = System.nanoTime();

            System.out.println("Found (Regex Name): " + countUnindexedCafe);
            System.out.println("Time (Unindexed Regex): " + (endUnindexedText - startUnindexedText) / 1_000_000.0 + " ms\n");

            System.out.println("=== 2. Creating Indexes ===");

            String idxLocality = collection.createIndex(Indexes.ascending("localidade"));
            System.out.println("Created index: " + idxLocality);

            String idxGastronomy = collection.createIndex(Indexes.ascending("gastronomia"));
            System.out.println("Created index: " + idxGastronomy);

            String idxText = collection.createIndex(Indexes.text("nome"));
            System.out.println("Created text index: " + idxText + "\n");

            System.out.println("=== 3. Testing With Indexes ===");

            long startIndexedLocality = System.nanoTime();
            long countIndexedBronx = collection.countDocuments(Filters.eq("localidade", "Bronx"));
            long endIndexedLocality = System.nanoTime();

            System.out.println("Found (Locality): " + countIndexedBronx);
            System.out.println("Time (Indexed Locality): " + (endIndexedLocality - startIndexedLocality) / 1_000_000.0 + " ms");

            long startIndexedText = System.nanoTime();
            long countIndexedCafe = collection.countDocuments(Filters.text("Cafe"));
            long endIndexedText = System.nanoTime();

            System.out.println("Found (Text Index): " + countIndexedCafe);
            System.out.println("Time (Indexed Text): " + (endIndexedText - startIndexedText) / 1_000_000.0 + " ms");

        } catch (Exception e) {
            System.err.println("Execution error: " + e.getMessage());
        }
    }
}