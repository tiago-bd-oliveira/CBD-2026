import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Accumulators;
import com.mongodb.client.model.Aggregates;
import com.mongodb.client.model.Filters;
import org.bson.Document;
import java.util.*;

public class MongoMethods {
    private MongoCollection<Document> collection;

    public MongoMethods(MongoCollection<Document> collection) {
        this.collection = collection;
    }

    public int countLocalidades() {
        List<String> distinctLocalidades = collection.distinct("localidade", String.class)
                .into(new ArrayList<>());
        return distinctLocalidades.size();
    }


    public Map<String, Integer> countRestByLocalidade() {
        Map<String, Integer> results = new HashMap<>();

        collection.aggregate(Arrays.asList(
                Aggregates.group("$localidade", Accumulators.sum("count", 1))
        )).forEach(doc -> {
            results.put(doc.getString("_id"), doc.getInteger("count"));
        });

        return results;
    }


    public List<String> getRestWithNameCloserTo(String name) {
        List<String> names = new ArrayList<>();

        collection.find(Filters.regex("nome", name, "i"))
                .forEach(doc -> {
                    names.add(doc.getString("nome"));
                });

        return names;
    }

    public static void main(String[] args) {
        String uri = "mongodb://localhost:27017";

        try (MongoClient mongoClient = MongoClients.create(uri)) {
            MongoDatabase database = mongoClient.getDatabase("cbd");
            MongoCollection<Document> collection = database.getCollection("restaurants");

            MongoMethods manager = new MongoMethods(collection);

            int numLocalidades = manager.countLocalidades();
            System.out.println("Numero de localidades distintas: " + numLocalidades);

            System.out.println("\nNumero de restaurantes por localidade:");
            Map<String, Integer> counts = manager.countRestByLocalidade();
            for (Map.Entry<String, Integer> entry : counts.entrySet()) {
                System.out.println("-> " + entry.getKey() + " - " + entry.getValue());
            }

            String searchName = "Park";
            System.out.println("\nNome de restaurantes contendo '" + searchName + "' no nome:");
            List<String> parkRestaurantes = manager.getRestWithNameCloserTo(searchName);
            for (String name : parkRestaurantes) {
                System.out.println("-> " + name);
            }
        } catch (Exception e) {
            System.err.println("Error connecting to MongoDB: " + e.getMessage());
        }
    }
}