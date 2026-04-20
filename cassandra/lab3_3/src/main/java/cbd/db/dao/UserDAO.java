package cbd.db.dao;

import cbd.db.CassandraConnection;
import cbd.models.User;
import com.datastax.oss.driver.api.core.cql.ResultSet;
import com.datastax.oss.driver.api.core.cql.Row;
import com.datastax.oss.driver.api.core.cql.SimpleStatement;
import com.datastax.oss.driver.api.querybuilder.QueryBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private static final Logger LOGGER = LoggerFactory.getLogger(UserDAO.class);
    private static final String TABLE_NAME = "users";

    /**
     * Insert a new user
     */
    public static void insertUser(User user) {
        try {
            SimpleStatement statement = QueryBuilder.insertInto(TABLE_NAME)
                    .value("username", QueryBuilder.literal(user.getUsername()))
                    .value("name", QueryBuilder.literal(user.getName()))
                    .value("email", QueryBuilder.literal(user.getEmail()))
                    .value("created_at", QueryBuilder.literal(user.getCreatedAt()))
                    .build();

            CassandraConnection.execute(statement);
            LOGGER.info("Inserted user: {}", user.getUsername());
        } catch (Exception e) {
            LOGGER.error("Failed to insert user: {}", user.getUsername(), e);
            throw new RuntimeException("Failed to insert user", e);
        }
    }

    /**
     * Update an existing user
     */
    public static void updateUser(User user) {
        try {
            SimpleStatement statement = QueryBuilder.update(TABLE_NAME)
                    .setColumn("name", QueryBuilder.literal(user.getName()))
                    .setColumn("email", QueryBuilder.literal(user.getEmail()))
                    .whereColumn("username").isEqualTo(QueryBuilder.literal(user.getUsername()))
                    .build();

            CassandraConnection.execute(statement);
            LOGGER.info("Updated user: {}", user.getUsername());
        } catch (Exception e) {
            LOGGER.error("Failed to update user: {}", user.getUsername(), e);
            throw new RuntimeException("Failed to update user", e);
        }
    }

    /**
     * Get a user by username
     */
    public static User getUserByUsername(String username) {
        try {
            SimpleStatement statement = QueryBuilder.selectFrom(TABLE_NAME)
                    .all()
                    .whereColumn("username").isEqualTo(QueryBuilder.literal(username))
                    .build();

            ResultSet resultSet = CassandraConnection.execute(statement);
            Row row = resultSet.one();

            if (row != null) {
                return rowToUser(row);
            }
            LOGGER.debug("User not found: {}", username);
            return null;
        } catch (Exception e) {
            LOGGER.error("Failed to get user: {}", username, e);
            throw new RuntimeException("Failed to get user", e);
        }
    }

    /**
     * Get all users
     */
    public static List<User> getAllUsers() {
        try {
            SimpleStatement statement = QueryBuilder.selectFrom(TABLE_NAME)
                    .all()
                    .build();

            ResultSet resultSet = CassandraConnection.execute(statement);
            List<User> users = new ArrayList<>();

            for (Row row : resultSet) {
                users.add(rowToUser(row));
            }

            LOGGER.debug("Retrieved {} users", users.size());
            return users;
        } catch (Exception e) {
            LOGGER.error("Failed to get all users", e);
            throw new RuntimeException("Failed to get all users", e);
        }
    }

    /**
     * Delete a user by username
     */
    public static void deleteUser(String username) {
        try {
            SimpleStatement statement = QueryBuilder.deleteFrom(TABLE_NAME)
                    .whereColumn("username").isEqualTo(QueryBuilder.literal(username))
                    .build();

            CassandraConnection.execute(statement);
            LOGGER.info("Deleted user: {}", username);
        } catch (Exception e) {
            LOGGER.error("Failed to delete user: {}", username, e);
            throw new RuntimeException("Failed to delete user", e);
        }
    }

    private static User rowToUser(Row row) {
        return new User(
                row.getString("username"),
                row.getString("name"),
                row.getString("email"),
                row.getInstant("created_at")
        );
    }
}

