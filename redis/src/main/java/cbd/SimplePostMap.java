package cbd;

import redis.clients.jedis.Jedis;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class SimplePostMap {
    private Jedis jedis;
    public static String USERS = "users";

    public SimplePostMap() {
        this.jedis = new Jedis();

    }

    public void saveUser(String key, String username) {
        jedis.hset(USERS, key, username);
    }

    public Map<String, String> getUser() {

        return jedis.hgetAll(USERS);
    }

    public Set<String> getAllKeys() {
        return jedis.keys("*");
    }

    public void flush(){
        jedis.flushAll();
    }

    public static void main(String[] args) {
        SimplePostMap board = new SimplePostMap();

        // set some users
        Map<String, String> map = new HashMap<>();
        map.put("k1", "ana");
        map.put("k2", "luis");
        map.put("k3", "jose");
        map.put("k4", "tosta mista");

        map.forEach(board::saveUser);

        board.getAllKeys().forEach(System.out::println);
        board.getUser().forEach((k, v) -> System.out.printf("%s -> %s\n", k, v));

        board.flush();
    }
}
