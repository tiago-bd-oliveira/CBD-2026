package cbd.db;

import com.datastax.oss.driver.api.core.CqlSession;
import com.datastax.oss.driver.api.core.cql.ResultSet;
import com.datastax.oss.driver.api.core.cql.Row;
import com.datastax.oss.driver.api.core.cql.SimpleStatement;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.net.InetSocketAddress;

public class CassandraConnection {
    private static final Logger LOGGER = LoggerFactory.getLogger(CassandraConnection.class);
    private static CqlSession session;

    public static synchronized void connect(String host, int port, String keyspace) {
        if (session != null) {
            LOGGER.warn("Session already connected");
            return;
        }

        try {
            session = CqlSession.builder()
                    .addContactPoint(new InetSocketAddress(host, port))
                    .withLocalDatacenter("datacenter1")
                    .withKeyspace(keyspace)
                    .build();
            LOGGER.info("Connected to Cassandra at {}:{}", host, port);
        } catch (Exception e) {
            LOGGER.error("Failed to connect to Cassandra", e);
            throw new RuntimeException("Failed to connect to Cassandra", e);
        }
    }

    public static CqlSession getSession() {
        if (session == null) {
            throw new RuntimeException("Session not initialized. Call connect() first.");
        }
        return session;
    }

    public static void disconnect() {
        if (session != null) {
            session.close();
            session = null;
            LOGGER.info("Disconnected from Cassandra");
        }
    }

    public static ResultSet execute(String query) {
        return getSession().execute(query);
    }

    public static ResultSet execute(SimpleStatement statement) {
        return getSession().execute(statement);
    }
}

