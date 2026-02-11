package cbd;

import redis.clients.jedis.Pipeline;
import redis.clients.jedis.Response;
import redis.clients.jedis.params.ZRangeParams;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;

public class AutocompleteWithPopularity extends Autocomplete {
    private final String NAMES_KEY = REDIS_KEY + ":names";
    private final String SCORES_KEY = REDIS_KEY + ":scores";

    @Override
    public void uploadData(String filepath) {
        try (BufferedReader br = new BufferedReader(new FileReader(filepath))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    String[] parts = line.trim().split(";");
                    String name = parts[0];
                    int score = Integer.parseInt(parts[1]);
                    jedis.zadd(NAMES_KEY, 0, name);
                    jedis.zadd(SCORES_KEY, score, name);
                }
            }
        } catch (IOException e) {
            System.err.println("File error: " + e.getMessage());
        }
    }

    public List<String> searchNames(String query) {
        // Using the \xff trick for a safer lexicographical range
        String start = "[" + query;
        String end = "(" + query.substring(0, query.length()-1) + (char) (query.charAt(query.length()-1) + 1);
        ZRangeParams params = ZRangeParams.zrangeByLexParams(start, end).limit(0, 10);
        return jedis.zrange(NAMES_KEY, params);
    }

    // Changed return type to List<String> to return formatted Name (Score) strings
    public List<String> SortByScoreAndFormat(List<String> matches) {
        if (matches == null || matches.isEmpty()) return new ArrayList<>();

        Map<String, Response<Double>> scoreResponses = new HashMap<>();

        try (Pipeline pipeline = jedis.pipelined()) {
            for (String name : matches) {
                scoreResponses.put(name, pipeline.zscore(SCORES_KEY, name));
            }
            pipeline.sync();
        }

        // Sort the original names first
        matches.sort((a, b) -> {
            Double scoreA = scoreResponses.get(a).get();
            Double scoreB = scoreResponses.get(b).get();
            double valA = (scoreA != null) ? scoreA : 0;
            double valB = (scoreB != null) ? scoreB : 0;
            return Double.compare(valB, valA);
        });

        // Create a new list with the "Name (Score)" format
        List<String> formattedResults = new ArrayList<>();
        for (String name : matches) {
            Double s = scoreResponses.get(name).get();
            long score = (s != null) ? s.longValue() : 0;
            formattedResults.add(String.format("%s (%d)", name, score));
        }

        return formattedResults;
    }

    public static void main(String[] args) {
        AutocompleteWithPopularity autocomplete = new AutocompleteWithPopularity();
        autocomplete.flush();

        String filepath = "./resources/nomes-pt-2021.csv";
        System.out.printf("Loading data into Redis from %s ...\n", filepath);
        autocomplete.uploadData(filepath);

        Scanner scanner = new Scanner(System.in);
        System.out.println("\n--- Redis Popularity Autocomplete ---");
        System.out.println("Type a name (or press Enter to quit):");

        while (true) {
            System.out.print("> ");
            String query = scanner.nextLine().trim();

            if (query.isEmpty()) {
                System.out.println("Exiting...");
                break;
            }

            List<String> rawResults = autocomplete.searchNames(query);

            if (rawResults.isEmpty()) {
                System.out.println("No matches found.");
            } else {
                // Get the formatted strings back from the sorting method
                List<String> rankedResults = autocomplete.SortByScoreAndFormat(rawResults);

                System.out.println("Suggestions (Ranked):");
                for (String entry : rankedResults) {
                    System.out.println(" - " + entry);
                }
            }
        }

        scanner.close();
        autocomplete.flush();
    }
}