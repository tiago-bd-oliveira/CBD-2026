# Quick Start Guide - Lab 3.3

## Prerequisites

- Java 21+
- Apache Cassandra running on localhost:9042
- Maven 3.6+

## One-Line Quick Start

```bash
./run.sh
```

## Step-by-Step Setup

### 1. Build the Project
```bash
mvn clean package
```

Expected output: `BUILD SUCCESS`

### 2. Ensure Cassandra is Running
```bash
# Check if Cassandra is accessible
nc -zv 127.0.0.1 9042
```

Expected output: `Connection to 127.0.0.1 9042 port [tcp/*] succeeded!`

### 3. Ensure Database Schema Exists
```bash
# From the lab3_2 directory, load the schema
cqlsh -f ../lab3_2/DDL.cql
```

Or verify with:
```bash
cqlsh -e "USE youtube; DESCRIBE TABLES;"
```

### 4. Run the Application

**Option A: Using the run script (Recommended)**
```bash
./run.sh
```

**Option B: Using Maven**
```bash
mvn exec:java -Dexec.mainClass="cbd.Main"
```

**Option C: Using the JAR directly**
```bash
java -jar target/lab3_3-1.0-SNAPSHOT.jar
```

## Expected Output

The application will display:
1. Connection confirmation
2. **USER OPERATIONS** section with 5 operations
3. **VIDEO OPERATIONS** section with 6 operations  
4. **COMMENT OPERATIONS** section with 4 operations
5. **SEARCH OPERATIONS** section with 5 advanced searches
6. **END OF OPERATIONS** message

All operations should show ✓ (checkmark) indicators.

## What the Application Does

### Creates Sample Data
- 3 Users: john_doe, jane_smith, bob_wilson
- 2 Videos: "Introduction to Java", "Cassandra Database Tutorial"
- 2 Comments on the first video

### Demonstrates CRUD Operations

**CREATE (Insert)**
```
✓ Inserted 3 new users
✓ Inserted 2 new videos
✓ Inserted 2 new comments
```

**READ (Search/Query)**
```
✓ Found: User(s)
✓ Found: Video(s)
✓ Found: Comment(s)
```

**UPDATE (Modify)**
```
✓ Updated user information
✓ Updated video information
✓ Updated comment
```

### Advanced Search Examples

1. Search users by username
2. Find videos by author
3. Filter videos by tags
4. Get comments on a video
5. Get comments by author

## Troubleshooting

### Error: "Cannot connect to Cassandra"
```bash
# Start Cassandra
sudo systemctl start cassandra

# Or using Docker
docker-compose up -d  # if using Docker
```

### Error: "Keyspace youtube does not exist"
```bash
# Load the schema from lab3_2
cqlsh -f ../lab3_2/DDL.cql
```

### Error: "java: command not found"
```bash
# Install Java 21
sudo apt-get install openjdk-21-jdk

# Verify
java -version
```

### Error: "BUILD FAILURE"
```bash
# Clean and rebuild
mvn clean compile

# Check for errors
mvn dependency:tree
```

## Project Files

| File | Purpose |
|------|---------|
| `Main.java` | Entry point and demo scenarios |
| `models/*.java` | Domain objects (User, Video, Comment) |
| `db/CassandraConnection.java` | Connection management |
| `db/dao/*.java` | Database operations (UserDAO, VideoDAO, CommentDAO) |
| `pom.xml` | Maven configuration & dependencies |
| `run.sh` | Automated build & run script |
| `cassandra.properties` | Configuration file |

## Key Classes

### CassandraConnection
```java
// Connect once
CassandraConnection.connect("127.0.0.1", 9042, "youtube");

// Use throughout application
CqlSession session = CassandraConnection.getSession();

// Disconnect when done
CassandraConnection.disconnect();
```

### UserDAO - Typical Usage
```java
// Insert
UserDAO.insertUser(new User(...));

// Search
User user = UserDAO.getUserByUsername("john_doe");

// Update
user.setEmail("newemail@example.com");
UserDAO.updateUser(user);

// Get all
List<User> users = UserDAO.getAllUsers();
```

### VideoDAO - Typical Usage
```java
// Insert
VideoDAO.insertVideo(new Video(...));

// Search by ID
Video video = VideoDAO.getVideoById(videoId);

// Search by author
List<Video> videos = VideoDAO.getVideosByAuthor("john_doe");

// Update
VideoDAO.updateVideo(video);
```

### CommentDAO - Typical Usage
```java
// Insert
CommentDAO.insertComment(new Comment(...));

// Get comments on video
List<Comment> comments = CommentDAO.getCommentsByVideo(videoId);

// Get comments by user
List<Comment> userComments = CommentDAO.getCommentsByUser("bob_wilson");

// Update
CommentDAO.updateComment(comment);
```

## Log Output

The application uses SLF4J logging with DEBUG/INFO/ERROR levels:

```
[INFO] Connecting to Cassandra...
[INFO] Connected to Cassandra at 127.0.0.1:9042
[DEBUG] Inserted user: john_doe
[DEBUG] Retrieved 3 users
[ERROR] Failed to insert user (if error occurs)
```

## What to Look For

✓ **Success Indicators:**
- All sections print without exceptions
- Checkmarks (✓) appear on each operation
- User/video/comment counts increase
- Search results are found and displayed

❌ **Failure Indicators:**
- Exception stack traces
- "Connection refused" or "timeout"
- 0 records found when 3+ should be
- BUILD FAILURE in Maven output

## Performance Notes

- First run takes longer due to dependency downloads
- Subsequent runs are faster (cached dependencies)
- Application runs in under 5 seconds typically
- No external API calls needed

## Next Steps

1. ✓ Verify the basic functionality with `./run.sh`
2. Explore the source code to understand the implementation
3. Modify the sample data in `Main.java` to test with custom values
4. Examine the DAOs to understand database operations
5. Read `IMPLEMENTATION_SUMMARY.md` for detailed documentation

## Additional Resources

- Full documentation: `README.md`
- Implementation details: `IMPLEMENTATION_SUMMARY.md`
- Cassandra schema: `../lab3_2/DDL.cql`
- Original data: `../lab3_2/DML.cql`

---

**Status**: Ready to run ✓
**Last Updated**: April 20, 2026

