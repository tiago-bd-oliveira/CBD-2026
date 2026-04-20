package cbd.db.dao;

import cbd.db.CassandraConnection;
import cbd.models.Comment;
import com.datastax.oss.driver.api.core.cql.ResultSet;
import com.datastax.oss.driver.api.core.cql.Row;
import com.datastax.oss.driver.api.core.cql.SimpleStatement;
import com.datastax.oss.driver.api.querybuilder.QueryBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.*;

public class CommentDAO {
    private static final Logger LOGGER = LoggerFactory.getLogger(CommentDAO.class);
    private static final String TABLE_BY_VIDEO = "comments_by_video";
    private static final String TABLE_BY_USER = "comments_by_user";

    /**
     * Insert a new comment
     */
    public static void insertComment(Comment comment) {
        try {
            // Insert into comments_by_video table
            SimpleStatement statement1 = QueryBuilder.insertInto(TABLE_BY_VIDEO)
                    .value("video_id", QueryBuilder.literal(comment.getVideoId()))
                    .value("comment_id", QueryBuilder.literal(comment.getCommentId()))
                    .value("author_username", QueryBuilder.literal(comment.getAuthorUsername()))
                    .value("content", QueryBuilder.literal(comment.getContent()))
                    .build();

            CassandraConnection.execute(statement1);

            // Insert into comments_by_user table
            SimpleStatement statement2 = QueryBuilder.insertInto(TABLE_BY_USER)
                    .value("author_username", QueryBuilder.literal(comment.getAuthorUsername()))
                    .value("comment_id", QueryBuilder.literal(comment.getCommentId()))
                    .value("video_id", QueryBuilder.literal(comment.getVideoId()))
                    .value("content", QueryBuilder.literal(comment.getContent()))
                    .build();

            CassandraConnection.execute(statement2);
            LOGGER.info("Inserted comment: {}", comment.getCommentId());
        } catch (Exception e) {
            LOGGER.error("Failed to insert comment: {}", comment.getCommentId(), e);
            throw new RuntimeException("Failed to insert comment", e);
        }
    }

    /**
     * Update an existing comment
     */
    public static void updateComment(Comment comment) {
        try {
            // Update comments_by_video table
            SimpleStatement statement1 = QueryBuilder.update(TABLE_BY_VIDEO)
                    .setColumn("content", QueryBuilder.literal(comment.getContent()))
                    .whereColumn("video_id").isEqualTo(QueryBuilder.literal(comment.getVideoId()))
                    .whereColumn("comment_id").isEqualTo(QueryBuilder.literal(comment.getCommentId()))
                    .build();

            CassandraConnection.execute(statement1);

            // Update comments_by_user table
            SimpleStatement statement2 = QueryBuilder.update(TABLE_BY_USER)
                    .setColumn("content", QueryBuilder.literal(comment.getContent()))
                    .whereColumn("author_username").isEqualTo(QueryBuilder.literal(comment.getAuthorUsername()))
                    .whereColumn("comment_id").isEqualTo(QueryBuilder.literal(comment.getCommentId()))
                    .build();

            CassandraConnection.execute(statement2);
            LOGGER.info("Updated comment: {}", comment.getCommentId());
        } catch (Exception e) {
            LOGGER.error("Failed to update comment: {}", comment.getCommentId(), e);
            throw new RuntimeException("Failed to update comment", e);
        }
    }

    /**
     * Get all comments for a video
     */
    public static List<Comment> getCommentsByVideo(UUID videoId) {
        try {
            SimpleStatement statement = QueryBuilder.selectFrom(TABLE_BY_VIDEO)
                    .all()
                    .whereColumn("video_id").isEqualTo(QueryBuilder.literal(videoId))
                    .build();

            ResultSet resultSet = CassandraConnection.execute(statement);
            List<Comment> comments = new ArrayList<>();

            for (Row row : resultSet) {
                comments.add(rowToComment(row));
            }

            LOGGER.debug("Retrieved {} comments for video: {}", comments.size(), videoId);
            return comments;
        } catch (Exception e) {
            LOGGER.error("Failed to get comments for video: {}", videoId, e);
            throw new RuntimeException("Failed to get comments for video", e);
        }
    }

    /**
     * Get all comments by a user
     */
    public static List<Comment> getCommentsByUser(String authorUsername) {
        try {
            SimpleStatement statement = QueryBuilder.selectFrom(TABLE_BY_USER)
                    .all()
                    .whereColumn("author_username").isEqualTo(QueryBuilder.literal(authorUsername))
                    .build();

            ResultSet resultSet = CassandraConnection.execute(statement);
            List<Comment> comments = new ArrayList<>();

            for (Row row : resultSet) {
                comments.add(rowToCommentFromUser(row));
            }

            LOGGER.debug("Retrieved {} comments from user: {}", comments.size(), authorUsername);
            return comments;
        } catch (Exception e) {
            LOGGER.error("Failed to get comments from user: {}", authorUsername, e);
            throw new RuntimeException("Failed to get comments from user", e);
        }
    }

    /**
     * Delete a comment
     */
    public static void deleteComment(Comment comment) {
        try {
            // Delete from comments_by_video table
            SimpleStatement statement1 = QueryBuilder.deleteFrom(TABLE_BY_VIDEO)
                    .whereColumn("video_id").isEqualTo(QueryBuilder.literal(comment.getVideoId()))
                    .whereColumn("comment_id").isEqualTo(QueryBuilder.literal(comment.getCommentId()))
                    .build();

            CassandraConnection.execute(statement1);

            // Delete from comments_by_user table
            SimpleStatement statement2 = QueryBuilder.deleteFrom(TABLE_BY_USER)
                    .whereColumn("author_username").isEqualTo(QueryBuilder.literal(comment.getAuthorUsername()))
                    .whereColumn("comment_id").isEqualTo(QueryBuilder.literal(comment.getCommentId()))
                    .build();

            CassandraConnection.execute(statement2);
            LOGGER.info("Deleted comment: {}", comment.getCommentId());
        } catch (Exception e) {
            LOGGER.error("Failed to delete comment: {}", comment.getCommentId(), e);
            throw new RuntimeException("Failed to delete comment", e);
        }
    }

    private static Comment rowToComment(Row row) {
        return new Comment(
                row.getUuid("video_id"),
                row.getUuid("comment_id"),
                row.getString("author_username"),
                row.getString("content")
        );
    }

    private static Comment rowToCommentFromUser(Row row) {
        return new Comment(
                row.getUuid("video_id"),
                row.getUuid("comment_id"),
                row.getString("author_username"),
                row.getString("content")
        );
    }
}

