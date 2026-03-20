import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;

import java.time.Instant;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;

import static com.mongodb.client.model.Accumulators.*;
import static com.mongodb.client.model.Aggregates.*;
import static com.mongodb.client.model.Filters.*;
import static com.mongodb.client.model.Projections.*;
import static com.mongodb.client.model.Sorts.descending;


public class QueriesFrom2_2 {
    static void main() {


        String MONGO_URI = "mongodb://localhost";

        try (MongoClient mongoClient = MongoClients.create(MONGO_URI)) {
            MongoDatabase database = mongoClient.getDatabase("cbd");
            MongoCollection<Document> collection = database.getCollection("restaurants");

            // 3
            System.out.println("Ex 3");
            collection.find()
                    .projection(fields(
                            include("restaurant_id", "nome", "localidade", "address.zipcode"),
                            exclude("_id")
                    ))
                    .limit(5)
                    .map(Document::toJson)
                    .forEach(System.out::println);

            // 7
            System.out.println("Ex 7");
            collection.find()
                    .filter(and(
                            gte("grades.score", 80),
                            lte("grades.score", 100)
                    ))
                    .projection(fields(
                            include("nome"),
                            excludeId()
                    ))
                    .map(Document::toJson)
                    .forEach(System.out::println);

            // 9
            System.out.println("Ex 9");
            collection.find()
                    .filter(
                            and(
                                    ne("gastronomia", "American"),
                                    gt("grades.score", 70),
                                    lt("address.coord.0", -65)
                            )
                    )
                    .projection(fields(
                            include("nome"),
                            excludeId()
                    ))
                    .map(Document::toJson)
                    .forEach(System.out::println);
            // 20
            System.out.println("Ex 20");
            collection.aggregate(
                            Arrays.asList(
                                    project(
                                            fields(
                                                    include("nome"),
                                                    excludeId(),
                                                    computed("numGrades",
                                                            new Document("$size",
                                                                    new Document("$ifNull", Arrays.asList("$grades", Collections.emptyList()))
                                                            )
                                                            )
                                            )
                                    ),
                                    sort(
                                            descending("numGrades")
                                    ),
                                    limit(3)
                            ))
                    .map(Document::toJson)
                    .forEach(System.out::println);

            // 25
            System.out.println("Ex 25");
            Date targetDate = Date.from(Instant.parse("2014-01-01T00:00:00Z"));

            collection.aggregate(
                            Arrays.asList(
                                    // Stage 1: Unwind the array
                                    unwind("$grades"),

                                    // Stage 2: Filter the unwound documents by date
                                    match(gte("grades.date", targetDate)),

                                    // Stage 3: Re-group the documents
                                    group("$_id",
                                            first("nome", "$nome"),
                                            sum("numGrades", 1),
                                            avg("avgScore", "$grades.score")
                                    ),

                                    // Stage 4: Filter the grouped results by the new computed average
                                    match(gt("avgScore", 30)),

                                    // Stage 5: Clean up the final output shape
                                    project(
                                            fields(
                                                    excludeId(),
                                                    include("nome", "numGrades", "avgScore")
                                            )
                                    )
                            )
                    )
                    .map(Document::toJson)
                    .forEach(System.out::println);

        } catch (Exception e) {
            System.err.println("An error occurred: " + e.getMessage());
        }

    }
}
