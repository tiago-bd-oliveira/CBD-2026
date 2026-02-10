package cbd;

import redis.clients.jedis.Jedis;

import java.util.List;
import java.util.Set;


public class SimplePostList {
    private Jedis jedis;
    public static String USERS = "users";

    public SimplePostList() {
        this.jedis = new Jedis();
    }

    public void saveUser(String username) {
        jedis.lpush(USERS, username);
    }


    public List<String> getUser() {

        return jedis.lpop(USERS,1);
    }

    public Set<String> getAllKeys() {
        return jedis.keys("*");
    }

    public static void main(String[] args) {
        SimplePostList board = new SimplePostList();
        // set some users
        String[] users = { "Ana", "Pedro", "Maria", "Luis" };
        for (String user: users)
            board.saveUser(user);
        board.getAllKeys().stream().forEach(System.out::println);
        board.getUser().stream().forEach(System.out::println);


    }
}
