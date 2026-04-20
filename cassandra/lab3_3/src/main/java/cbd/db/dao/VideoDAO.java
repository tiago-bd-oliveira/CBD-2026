package cbd.db.dao;

import cbd.db.CassandraConnection;
import cbd.models.Video;
import com.datastax.oss.driver.api.core.cql.ResultSet;
import com.datastax.oss.driver.api.core.cql.Row;
import com.datastax.oss.driver.api.core.cql.SimpleStatement;
import com.datastax.oss.driver.api.querybuilder.QueryBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.time.Instant;
import java.util.*;

public class VideoDAO {
    private static final Logger LOGGER = LoggerFactory.getLogger(VideoDAO.class);
    private static final String TABLE_NAME = "videos";
    private static final String TABLE_BY_AUTHOR = "videos_by_author";

    /**
     * Insert a new video
     */
    public static void insertVideo(Video video) {
        try {
            // Insert into videos table
            SimpleStatement statement1 = QueryBuilder.insertInto(TABLE_NAME)
                    .value("video_id", QueryBuilder.literal(video.getVideoId()))
                    .value("author_username", QueryBuilder.literal(video.getAuthorUsername()))
                    .value("title", QueryBuilder.literal(video.getTitle()))
                    .value("description", QueryBuilder.literal(video.getDescription()))
                    .value("tags", QueryBuilder.literal(video.getTags()))
                    .value("upload_timestamp", QueryBuilder.literal(video.getUploadTimestamp()))
                    .build();

            CassandraConnection.execute(statement1);

            // Insert into videos_by_author table
            SimpleStatement statement2 = QueryBuilder.insertInto(TABLE_BY_AUTHOR)
                    .value("author_username", QueryBuilder.literal(video.getAuthorUsername()))
                    .value("video_id", QueryBuilder.literal(video.getVideoId()))
                    .value("title", QueryBuilder.literal(video.getTitle()))
                    .value("description", QueryBuilder.literal(video.getDescription()))
                    .value("tags", QueryBuilder.literal(video.getTags()))
                    .value("upload_timestamp", QueryBuilder.literal(video.getUploadTimestamp()))
                    .build();

            CassandraConnection.execute(statement2);
            LOGGER.info("Inserted video: {}", video.getVideoId());
        } catch (Exception e) {
            LOGGER.error("Failed to insert video: {}", video.getVideoId(), e);
            throw new RuntimeException("Failed to insert video", e);
        }
    }

    /**
     * Update an existing video
     */
    public static void updateVideo(Video video) {
        try {
            // Update videos table
            SimpleStatement statement1 = QueryBuilder.update(TABLE_NAME)
                    .setColumn("title", QueryBuilder.literal(video.getTitle()))
                    .setColumn("description", QueryBuilder.literal(video.getDescription()))
                    .setColumn("tags", QueryBuilder.literal(video.getTags()))
                    .whereColumn("video_id").isEqualTo(QueryBuilder.literal(video.getVideoId()))
                    .build();

            CassandraConnection.execute(statement1);

            // Update videos_by_author table
            SimpleStatement statement2 = QueryBuilder.update(TABLE_BY_AUTHOR)
                    .setColumn("title", QueryBuilder.literal(video.getTitle()))
                    .setColumn("description", QueryBuilder.literal(video.getDescription()))
                    .setColumn("tags", QueryBuilder.literal(video.getTags()))
                    .whereColumn("author_username").isEqualTo(QueryBuilder.literal(video.getAuthorUsername()))
                    .whereColumn("upload_timestamp").isEqualTo(QueryBuilder.literal(video.getUploadTimestamp()))
                    .whereColumn("video_id").isEqualTo(QueryBuilder.literal(video.getVideoId()))
                    .build();

            CassandraConnection.execute(statement2);
            LOGGER.info("Updated video: {}", video.getVideoId());
        } catch (Exception e) {
            LOGGER.error("Failed to update video: {}", video.getVideoId(), e);
            throw new RuntimeException("Failed to update video", e);
        }
    }

    /**
     * Get a video by video ID
     */
    public static Video getVideoById(UUID videoId) {
        try {
            SimpleStatement statement = QueryBuilder.selectFrom(TABLE_NAME)
                    .all()
                    .whereColumn("video_id").isEqualTo(QueryBuilder.literal(videoId))
                    .build();

            ResultSet resultSet = CassandraConnection.execute(statement);
            Row row = resultSet.one();

            if (row != null) {
                return rowToVideo(row);
            }
            LOGGER.debug("Video not found: {}", videoId);
            return null;
        } catch (Exception e) {
            LOGGER.error("Failed to get video: {}", videoId, e);
            throw new RuntimeException("Failed to get video", e);
        }
    }

    /**
     * Get all videos by author
     */
    public static List<Video> getVideosByAuthor(String authorUsername) {
        try {
            SimpleStatement statement = QueryBuilder.selectFrom(TABLE_BY_AUTHOR)
                    .all()
                    .whereColumn("author_username").isEqualTo(QueryBuilder.literal(authorUsername))
                    .build();

            ResultSet resultSet = CassandraConnection.execute(statement);
            List<Video> videos = new ArrayList<>();

            for (Row row : resultSet) {
                videos.add(rowToVideo(row));
            }

            LOGGER.debug("Retrieved {} videos for author: {}", videos.size(), authorUsername);
            return videos;
        } catch (Exception e) {
            LOGGER.error("Failed to get videos for author: {}", authorUsername, e);
            throw new RuntimeException("Failed to get videos for author", e);
        }
    }

    /**
     * Get all videos
     */
    public static List<Video> getAllVideos() {
        try {
            SimpleStatement statement = QueryBuilder.selectFrom(TABLE_NAME)
                    .all()
                    .build();

            ResultSet resultSet = CassandraConnection.execute(statement);
            List<Video> videos = new ArrayList<>();

            for (Row row : resultSet) {
                videos.add(rowToVideo(row));
            }

            LOGGER.debug("Retrieved {} videos", videos.size());
            return videos;
        } catch (Exception e) {
            LOGGER.error("Failed to get all videos", e);
            throw new RuntimeException("Failed to get all videos", e);
        }
    }

    /**
     * Delete a video by video ID
     */
    public static void deleteVideo(Video video) {
        try {
            // Delete from videos table
            SimpleStatement statement1 = QueryBuilder.deleteFrom(TABLE_NAME)
                    .whereColumn("video_id").isEqualTo(QueryBuilder.literal(video.getVideoId()))
                    .build();

            CassandraConnection.execute(statement1);

            // Delete from videos_by_author table
            SimpleStatement statement2 = QueryBuilder.deleteFrom(TABLE_BY_AUTHOR)
                    .whereColumn("author_username").isEqualTo(QueryBuilder.literal(video.getAuthorUsername()))
                    .whereColumn("upload_timestamp").isEqualTo(QueryBuilder.literal(video.getUploadTimestamp()))
                    .whereColumn("video_id").isEqualTo(QueryBuilder.literal(video.getVideoId()))
                    .build();

            CassandraConnection.execute(statement2);
            LOGGER.info("Deleted video: {}", video.getVideoId());
        } catch (Exception e) {
            LOGGER.error("Failed to delete video: {}", video.getVideoId(), e);
            throw new RuntimeException("Failed to delete video", e);
        }
    }

    private static Video rowToVideo(Row row) {
        Set<String> tags = row.getSet("tags", String.class);
        return new Video(
                row.getUuid("video_id"),
                row.getString("author_username"),
                row.getString("title"),
                row.getString("description"),
                tags != null ? new HashSet<>(tags) : new HashSet<>(),
                row.getInstant("upload_timestamp")
        );
    }
}

