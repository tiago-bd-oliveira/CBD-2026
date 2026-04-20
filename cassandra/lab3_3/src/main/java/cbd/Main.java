package cbd;

import cbd.db.CassandraConnection;
import cbd.db.dao.CommentDAO;
import cbd.db.dao.UserDAO;
import cbd.db.dao.VideoDAO;
import cbd.models.Comment;
import cbd.models.User;
import cbd.models.Video;
import com.datastax.oss.driver.api.core.uuid.Uuids;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.time.Instant;
import java.util.*;

public class Main {
    private static final Logger LOGGER = LoggerFactory.getLogger(Main.class);

    public static void main(String[] args) {
        try {
            // Connect to Cassandra
            LOGGER.info("Connecting to Cassandra...");
            CassandraConnection.connect("127.0.0.1", 9042, "cbd");

            // Demonstrate User operations
            demonstrateUserOperations();

            // Demonstrate Video operations
            demonstrateVideoOperations();

            // Demonstrate Comment operations
            demonstrateCommentOperations();

            // Demonstrate Search operations
            demonstrateSearchOperations();

        } catch (Exception e) {
            LOGGER.error("Application error", e);
        } finally {
            CassandraConnection.disconnect();
        }
    }

    /**
     * Demonstrate user insertion, update, and search
     */
    private static void demonstrateUserOperations() {
        System.out.println("\n========== USER OPERATIONS ==========\n");

        // 1. Insert new users
        System.out.println("1. Inserting new users...");
        User user1 = new User("john_doe", "John Doe", "john@example.com", Instant.now());
        User user2 = new User("jane_smith", "Jane Smith", "jane@example.com", Instant.now());
        User user3 = new User("bob_wilson", "Bob Wilson", "bob@example.com", Instant.now());

        UserDAO.insertUser(user1);
        UserDAO.insertUser(user2);
        UserDAO.insertUser(user3);
        System.out.println("✓ Inserted 3 new users");

        // 2. Search for a specific user
        System.out.println("\n2. Searching for user 'john_doe'...");
        User foundUser = UserDAO.getUserByUsername("john_doe");
        if (foundUser != null) {
            System.out.println("✓ Found: " + foundUser);
        }

        // 3. Update user information
        System.out.println("\n3. Updating user 'john_doe'...");
        user1.setEmail("john.doe@newdomain.com");
        user1.setName("John Alexander Doe");
        UserDAO.updateUser(user1);
        System.out.println("✓ Updated user information");

        // 4. Search and display updated user
        System.out.println("\n4. Searching for updated user 'john_doe'...");
        User updatedUser = UserDAO.getUserByUsername("john_doe");
        if (updatedUser != null) {
            System.out.println("✓ Updated user: " + updatedUser);
        }

        // 5. Search all users
        System.out.println("\n5. Retrieving all users...");
        List<User> allUsers = UserDAO.getAllUsers();
        System.out.println("✓ Found " + allUsers.size() + " users:");
        for (User user : allUsers) {
            System.out.println("  - " + user.getUsername() + ": " + user.getName() + " (" + user.getEmail() + ")");
        }
    }

    /**
     * Demonstrate video insertion, update, and search
     */
    private static void demonstrateVideoOperations() {
        System.out.println("\n========== VIDEO OPERATIONS ==========\n");

        // 1. Insert new videos
        System.out.println("1. Inserting new videos...");
        UUID video1Id = UUID.randomUUID();
        UUID video2Id = UUID.randomUUID();

        Set<String> tags1 = new HashSet<>(Arrays.asList("java", "tutorial", "programming"));
        Video video1 = new Video(
                video1Id,
                "john_doe",
                "Introduction to Java",
                "Learn the basics of Java programming",
                tags1,
                Instant.now()
        );

        Set<String> tags2 = new HashSet<>(Arrays.asList("database", "cassandra", "nosql"));
        Video video2 = new Video(
                video2Id,
                "jane_smith",
                "Cassandra Database Tutorial",
                "A comprehensive guide to Cassandra",
                tags2,
                Instant.now()
        );

        VideoDAO.insertVideo(video1);
        VideoDAO.insertVideo(video2);
        System.out.println("✓ Inserted 2 new videos");

        // 2. Search for a specific video
        System.out.println("\n2. Searching for video by ID...");
        Video foundVideo = VideoDAO.getVideoById(video1Id);
        if (foundVideo != null) {
            System.out.println("✓ Found: " + foundVideo.getTitle());
        }

        // 3. Update video information
        System.out.println("\n3. Updating video information...");
        video1.setTitle("Advanced Java Programming");
        video1.setDescription("Learn advanced Java concepts and best practices");
        video1.getTags().add("advanced");
        VideoDAO.updateVideo(video1);
        System.out.println("✓ Updated video information");

        // 4. Search and display updated video
        System.out.println("\n4. Searching for updated video...");
        Video updatedVideo = VideoDAO.getVideoById(video1Id);
        if (updatedVideo != null) {
            System.out.println("✓ Updated video: " + updatedVideo.getTitle());
            System.out.println("  Description: " + updatedVideo.getDescription());
            System.out.println("  Tags: " + updatedVideo.getTags());
        }

        // 5. Search videos by author
        System.out.println("\n5. Searching for videos by author 'john_doe'...");
        List<Video> johnVideos = VideoDAO.getVideosByAuthor("john_doe");
        System.out.println("✓ Found " + johnVideos.size() + " video(s) by john_doe:");
        for (Video video : johnVideos) {
            System.out.println("  - " + video.getTitle());
        }

        // 6. Search all videos
        System.out.println("\n6. Retrieving all videos...");
        List<Video> allVideos = VideoDAO.getAllVideos();
        System.out.println("✓ Found " + allVideos.size() + " video(s):");
        for (Video video : allVideos) {
            System.out.println("  - " + video.getTitle() + " (Author: " + video.getAuthorUsername() + ")");
        }
    }

    /**
     * Demonstrate comment insertion, update, and search
     */
    private static void demonstrateCommentOperations() {
        System.out.println("\n========== COMMENT OPERATIONS ==========\n");

        // Get a video ID for testing (we'll use the first video found)
        List<Video> videos = VideoDAO.getAllVideos();
        if (videos.isEmpty()) {
            System.out.println("No videos found. Skipping comment operations.");
            return;
        }

        UUID videoId = videos.get(0).getVideoId();
        System.out.println("Using video: " + videos.get(0).getTitle() + "\n");

        // 1. Insert new comments
        System.out.println("1. Inserting new comments...");
        UUID comment1Id = Uuids.timeBased();
        UUID comment2Id = Uuids.timeBased();

        Comment comment1 = new Comment(
                videoId,
                comment1Id,
                "bob_wilson",
                "Great tutorial! Very helpful for beginners."
        );

        Comment comment2 = new Comment(
                videoId,
                comment2Id,
                "jane_smith",
                "Excellent explanation. Looking forward to more content!"
        );

        CommentDAO.insertComment(comment1);
        CommentDAO.insertComment(comment2);
        System.out.println("✓ Inserted 2 new comments");

        // 2. Search for comments on a video
        System.out.println("\n2. Searching for comments on this video...");
        List<Comment> videoComments = CommentDAO.getCommentsByVideo(videoId);
        System.out.println("✓ Found " + videoComments.size() + " comment(s):");
        for (Comment comment : videoComments) {
            System.out.println("  - " + comment.getAuthorUsername() + ": " + comment.getContent());
        }

        // 3. Update a comment
        System.out.println("\n3. Updating a comment...");
        comment1.setContent("Great tutorial! Very helpful for both beginners and intermediate developers.");
        CommentDAO.updateComment(comment1);
        System.out.println("✓ Updated comment");

        // 4. Search for comments by user
        System.out.println("\n4. Searching for comments by 'bob_wilson'...");
        List<Comment> bobComments = CommentDAO.getCommentsByUser("bob_wilson");
        System.out.println("✓ Found " + bobComments.size() + " comment(s) by bob_wilson:");
        for (Comment comment : bobComments) {
            System.out.println("  - On video: " + comment.getVideoId());
            System.out.println("    Content: " + comment.getContent());
        }
    }

    /**
     * Demonstrate search operations
     */
    private static void demonstrateSearchOperations() {
        System.out.println("\n========== SEARCH OPERATIONS ==========\n");

        // 1. Search user by username
        System.out.println("1. Advanced search - Find user by username:");
        System.out.println("   Searching for 'jane_smith'...");
        User user = UserDAO.getUserByUsername("jane_smith");
        if (user != null) {
            System.out.println("✓ Found: " + user.getName() + " (" + user.getEmail() + ")");
        }

        // 2. Search videos by author
        System.out.println("\n2. Advanced search - Find all videos by an author:");
        System.out.println("   Searching for videos by 'jane_smith'...");
        List<Video> authorVideos = VideoDAO.getVideosByAuthor("jane_smith");
        System.out.println("✓ Found " + authorVideos.size() + " video(s)");

        // 3. Filter videos by tags
        System.out.println("\n3. Advanced search - Filter videos with specific tags:");
        System.out.println("   Searching for videos with 'java' tag...");
        List<Video> allVideos = VideoDAO.getAllVideos();
        List<Video> javaVideos = new ArrayList<>();
        for (Video video : allVideos) {
            if (video.getTags().contains("java")) {
                javaVideos.add(video);
            }
        }
        System.out.println("✓ Found " + javaVideos.size() + " video(s) with 'java' tag:");
        for (Video video : javaVideos) {
            System.out.println("  - " + video.getTitle());
        }

        // 4. Search comments by video
        System.out.println("\n4. Advanced search - Find all comments on a video:");
        if (!allVideos.isEmpty()) {
            UUID videoId = allVideos.get(0).getVideoId();
            List<Comment> comments = CommentDAO.getCommentsByVideo(videoId);
            System.out.println("   Video: " + allVideos.get(0).getTitle());
            System.out.println("✓ Found " + comments.size() + " comment(s)");
        }

        // 5. Search comments by user
        System.out.println("\n5. Advanced search - Find all comments by a user:");
        System.out.println("   Searching for comments by 'bob_wilson'...");
        List<Comment> userComments = CommentDAO.getCommentsByUser("bob_wilson");
        System.out.println("✓ Found " + userComments.size() + " comment(s)");

        System.out.println("\n========== END OF OPERATIONS ==========\n");
    }
}

