import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;
import org.bson.Document;

public class RestaurantsCRUD {

    public static void main(String[] args) {
        String MONGO_URI = "mongodb://localhost";

        try (MongoClient mongoClient = MongoClients.create(MONGO_URI)){

            System.out.printf("Connecting to database at '%s'...\n", MONGO_URI);
            MongoDatabase database = mongoClient.getDatabase("cbd");
            MongoCollection<Document> collection = database.getCollection("restaurants");
            System.out.println("Connected!\n");

            System.out.println("Inserting new document...");
            int new_id = 9001;
            Document restaurant = new Document("restaurant_id", new_id)
                    .append("nome", "Tasca do Zé")
                    .append("localidade", "Faro")
                    .append("gastronomia", "Pexe");
            collection.insertOne(restaurant);
            System.out.println("Done!\n");

            System.out.println("Fetching document...");
            restaurant = collection.find().first();
            if (restaurant != null) {
                System.out.println("Found: " + restaurant.toJson() + "\n");
            } else {
                System.out.println("Not found...\n");
            }

            System.out.println("Editing document...");
            collection.updateOne(
                    Filters.eq("restaurant_id", new_id),
                    Updates.set("gastronomia", "Portuguese Contemporânea")
            );
            Document updatedRestaurant = collection.find(Filters.eq("restaurant_id", "99999999")).first();
            System.out.printf("Edition complete: %s\n", updatedRestaurant);

        } catch (Exception e) {
            System.err.println("An error occurred: " + e.getMessage());
        }
    }
}
