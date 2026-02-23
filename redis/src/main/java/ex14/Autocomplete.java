package ex14;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.params.ZRangeParams;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

import java.util.List;
import java.util.Scanner;

public class Autocomplete {
    protected final Jedis jedis = new Jedis();
    protected final String REDIS_KEY = "autocomplete";

    public void uploadData(String filepath){
        try (BufferedReader br = new BufferedReader(new FileReader(filepath))){
            String line;
            while ((line = br.readLine()) != null) {
                if (!line.trim().isEmpty()) {
                    jedis.zadd(REDIS_KEY, 0, line.trim());
                }
            }
        }catch (IOException e){
            System.err.println("File error: " + e.getMessage());
        }
    }

    public List<String> search(String query){

        String start = "[" + query;
        String end = "(" + query.substring(0, query.length()-1) + (char) (query.charAt(query.length()-1) + 1);
        ZRangeParams params = ZRangeParams.zrangeByLexParams(start, end).limit(0, 10);
        return jedis.zrange(REDIS_KEY, params);
    }

    public void flush(){jedis.flushAll();}

    public static void main(String[] args) {
        Autocomplete autocomplete = new Autocomplete();

        autocomplete.flush();

        String filepath = "./resources/names.txt";
        System.out.printf("Loading data into Redis from %s ...\n", filepath);
        autocomplete.uploadData(filepath);


        Scanner scanner = new Scanner(System.in);

        System.out.println("\n--- Redis ex14.Autocomplete System ---");
        System.out.println("Type a name to search (or press Enter to quit):");

        boolean running = true;
        while(running){
            System.out.print("> ");
            String query = scanner.nextLine().trim();

            if (query.isEmpty()) {
                System.out.println("Exiting...");
                running = false;
            } else {
                List<String> results = autocomplete.search(query);

                if (results.isEmpty()) {
                    System.out.println("No matches found.");
                } else {
                    System.out.println("Suggestions: " + String.join(", ", results));
                }
            }
        }

        scanner.close();
        autocomplete.flush();
    }

}


