# YouTube-like Cassandra Application (Lab 3.3)

## Overview

This is a Java application that demonstrates CRUD (Create, Read, Update) operations on an Apache Cassandra database. The application implements a YouTube-like system with users, videos, and comments.

## Features

The application demonstrates:

- **User Management**: Insert, update, search, and delete users
- **Video Management**: Insert, update, search videos by author, and manage video metadata
- **Comment Management**: Insert, update, and search comments on videos
- **Advanced Search**: Filter videos by tags, find comments by user, and more

## Project Structure

```
lab3_3/
├── pom.xml                                          # Maven configuration
├── src/
│   └── main/
│       ├── java/
│       │   └── cbd/
│       │       ├── Main.java                        # Main application entry point
│       │       ├── models/
│       │       │   ├── User.java                    # User model
│       │       │   ├── Video.java                   # Video model
│       │       │   └── Comment.java                 # Comment model
│       │       └── db/
│       │           ├── CassandraConnection.java     # Connection manager
│       │           └── dao/
│       │               ├── UserDAO.java             # User database operations
│       │               ├── VideoDAO.java            # Video database operations
│       │               └── CommentDAO.java          # Comment database operations
│       └── resources/
└── target/
    └── lab3_3-1.0-SNAPSHOT.jar                     # Compiled JAR (executable)
```

## Database Schema

The application uses the following tables (from lab3_2):

### Users Table
- `username` (PRIMARY KEY)
- `name`
- `email`
- `created_at`

### Videos Tables
- `videos`: Main video table with video_id as primary key
- `videos_by_author`: Denormalized table for querying videos by author

### Comments Tables
- `comments_by_video`: Comments indexed by video
- `comments_by_user`: Comments indexed by author

## Prerequisites

1. **Java 21**: The application requires Java 21 or higher
2. **Apache Cassandra**: A running Cassandra instance (default: localhost:9042)
3. **Maven**: For building the project

## Installation

### 1. Build the project

```bash
cd /home/tiago/Documents/repos/CBD/cassandra/lab3_3
mvn clean package
```

This will create an executable JAR file at:
```
target/lab3_3-1.0-SNAPSHOT.jar
```

### 2. Cassandra Setup

Ensure Cassandra is running on `127.0.0.1:9042` with the `youtube` keyspace created.

If you need to set up the database, run the DDL from lab3_2:
```bash
cqlsh -f ../lab3_2/DDL.cql
```

## Running the Application

### Option 1: Run with Maven

```bash
mvn exec:java -Dexec.mainClass="cbd.Main"
```

### Option 2: Run the executable JAR

```bash
java -jar target/lab3_3-1.0-SNAPSHOT.jar
```

## Application Output

The application will:

1. **Connect to Cassandra** on localhost:9042
2. **Insert sample data**:
   - 3 new users (john_doe, jane_smith, bob_wilson)
   - 2 new videos with tags
   - Comments on videos
3. **Demonstrate operations**:
   - Searching for specific users
   - Updating user information
   - Searching for videos by author
   - Updating video metadata
   - Adding and searching comments
4. **Perform advanced searches**:
   - Filter videos by tags
   - Find all comments by a user
   - Find all comments on a video

## Code Examples

### User Operations

```java
// Insert a user
User user = new User("john_doe", "John Doe", "john@example.com", Instant.now());
UserDAO.insertUser(user);

// Search for a user
User foundUser = UserDAO.getUserByUsername("john_doe");

// Update a user
user.setEmail("new@example.com");
UserDAO.updateUser(user);

// Get all users
List<User> allUsers = UserDAO.getAllUsers();
```

### Video Operations

```java
// Insert a video
Set<String> tags = new HashSet<>(Arrays.asList("java", "tutorial"));
Video video = new Video(UUID.randomUUID(), "john_doe", "Java Tutorial", 
                        "Learn Java", tags, Instant.now());
VideoDAO.insertVideo(video);

// Search for a video
Video foundVideo = VideoDAO.getVideoById(videoId);

// Get videos by author
List<Video> authorVideos = VideoDAO.getVideosByAuthor("john_doe");
```

### Comment Operations

```java
// Insert a comment
Comment comment = new Comment(videoId, UUID.randomUUID(), "bob_wilson", "Great video!");
CommentDAO.insertComment(comment);

// Get comments on a video
List<Comment> videoComments = CommentDAO.getCommentsByVideo(videoId);

// Get comments by user
List<Comment> userComments = CommentDAO.getCommentsByUser("bob_wilson");
```

## Technologies Used

- **Apache Cassandra Java Driver**: 4.17.0
- **QueryBuilder**: For building CQL queries programmatically
- **SLF4J**: Logging framework
- **GSON**: JSON processing (optional for future enhancements)
- **Maven**: Build tool

## Key Features of the Implementation

1. **Singleton Connection Pattern**: Manages a single Cassandra session
2. **DAO Pattern**: Separates database operations from business logic
3. **Model Classes**: Type-safe representation of database entities
4. **Query Builder**: Type-safe query construction instead of raw CQL strings
5. **Error Handling**: Comprehensive exception handling and logging
6. **Denormalized Tables**: Optimized for different query patterns (e.g., videos by author)

## Troubleshooting

### Connection Error
If you get a connection error, ensure:
- Cassandra is running: `sudo systemctl status cassandra`
- Default port is 9042: `netstat -tuln | grep 9042`
- Keyspace exists: `cqlsh -e "DESCRIBE KEYSPACES"`

### Query Errors
If you get CQL errors, ensure:
- All tables are created: `cqlsh -e "USE youtube; DESCRIBE TABLES;"`
- Run DDL from lab3_2

### Build Errors
If compilation fails:
- Verify Java version: `java -version` (should be 21+)
- Clean and rebuild: `mvn clean compile`

## Future Enhancements

- Add video ratings operations
- Add video events tracking
- Add follower relationships
- Implement pagination for large result sets
- Add batch operations for bulk inserts
- Add metrics/statistics queries

## Notes

- The application uses UUIDs for video and comment IDs
- All timestamps use Java's `Instant` class for timezone-safe operations
- The application uses Cassandra's query builder for type-safe queries
- Denormalized tables ensure efficient queries for common access patterns

## Author

Created for CBD (Cassandra Database) Course - Lab 3.3

## License

Educational purposes only

