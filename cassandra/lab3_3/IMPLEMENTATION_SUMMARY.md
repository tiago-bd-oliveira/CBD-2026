# Lab 3.3 - Java Cassandra Application Summary

## Project Overview

A comprehensive Java application demonstrating CRUD operations (Create, Read, Update, Delete) on an Apache Cassandra database using the YouTube schema from Lab 3.2.

## Deliverables

### 1. **Model Classes** (`cbd.models` package)
- `User.java` - Represents a user with username, name, email, and creation timestamp
- `Video.java` - Represents a video with metadata, tags, and author information
- `Comment.java` - Represents a comment with video reference and author

### 2. **Database Layer** (`cbd.db` package)

#### Connection Management
- `CassandraConnection.java` - Singleton pattern for managing Cassandra sessions

#### Data Access Objects (DAOs)
- `UserDAO.java` - CRUD operations for users:
  - `insertUser()` - Add new user to database
  - `updateUser()` - Modify user information
  - `getUserByUsername()` - Search user by username
  - `getAllUsers()` - Retrieve all users
  - `deleteUser()` - Remove user from database

- `VideoDAO.java` - CRUD operations for videos:
  - `insertVideo()` - Add new video (maintains both video and video_by_author tables)
  - `updateVideo()` - Modify video information
  - `getVideoById()` - Search video by UUID
  - `getVideosByAuthor()` - Search videos by author
  - `getAllVideos()` - Retrieve all videos
  - `deleteVideo()` - Remove video from database

- `CommentDAO.java` - CRUD operations for comments:
  - `insertComment()` - Add new comment (maintains both comments_by_video and comments_by_user tables)
  - `updateComment()` - Modify comment content
  - `getCommentsByVideo()` - Search comments on a specific video
  - `getCommentsByUser()` - Search all comments by a user
  - `deleteComment()` - Remove comment from database

### 3. **Main Application** (`cbd.Main`)

Comprehensive demonstration application with 4 main sections:

#### Section 1: User Operations
- Insert 3 sample users
- Search for a specific user
- Update user information
- Retrieve all users

#### Section 2: Video Operations
- Insert 2 sample videos with tags
- Search for a specific video
- Update video information
- Search videos by author
- Retrieve all videos

#### Section 3: Comment Operations
- Insert 2 sample comments
- Search comments on a video
- Update comment content
- Search comments by user

#### Section 4: Advanced Search Operations
- Search user by username
- Find all videos by an author
- Filter videos by specific tags
- Find all comments on a video
- Find all comments by a user

### 4. **Build Configuration**

#### pom.xml
Dependencies:
- `com.datastax.oss:java-driver-core` (4.17.0)
- `com.datastax.oss:java-driver-query-builder` (4.17.0)
- `com.google.code.gson:gson` (2.10.1)
- `org.slf4j:slf4j-api` and `slf4j-simple` (2.0.7)

Build Plugins:
- Maven Shade Plugin for creating executable JAR

Target Java: 21

### 5. **Documentation and Scripts**

#### README.md
- Project overview and features
- Installation instructions
- Database schema description
- Usage examples for all operations
- Troubleshooting guide
- Future enhancement ideas

#### run.sh (Executable Script)
- Automated build and run script
- Checks for Java installation
- Validates Cassandra connection
- Builds project if needed
- Executes the application

#### cassandra.properties
- Configuration file for connection parameters
- Default settings for host, port, keyspace

## Key Features

### 1. **Object-Oriented Design**
- Model classes for domain entities
- Separation of concerns with DAO pattern
- Type-safe operations

### 2. **Database Integration**
- Query Builder for type-safe query construction
- Denormalized tables for efficient queries
- Batch operations maintaining consistency

### 3. **Error Handling**
- Try-catch blocks with logging
- Meaningful error messages
- Connection validation

### 4. **Logging**
- SLF4J integration
- Information, debug, and error levels
- Operation tracing

## Demonstration Scenarios

The application demonstrates:

1. **Insertion**: Adding new records to multiple tables
2. **Search**: Querying records by various criteria (ID, username, author)
3. **Update**: Modifying existing records
4. **Filtering**: Advanced search with client-side filtering (tags)
5. **Relationship Queries**: Getting related records (videos by author, comments on video)

## File Structure

```
lab3_3/
├── pom.xml
├── README.md
├── run.sh
├── src/main/
│   ├── java/cbd/
│   │   ├── Main.java
│   │   ├── models/
│   │   │   ├── User.java
│   │   │   ├── Video.java
│   │   │   └── Comment.java
│   │   └── db/
│   │       ├── CassandraConnection.java
│   │       └── dao/
│   │           ├── UserDAO.java
│   │           ├── VideoDAO.java
│   │           └── CommentDAO.java
│   └── resources/
│       └── cassandra.properties
└── target/
    └── lab3_3-1.0-SNAPSHOT.jar
```

## How to Run

### Quick Start
```bash
./run.sh
```

### Manual Execution
```bash
# Build
mvn clean package

# Run
java -jar target/lab3_3-1.0-SNAPSHOT.jar
```

## Sample Output

The application produces organized output showing:
- Connection confirmation
- User insertion and updates
- Video management operations
- Comment operations
- Advanced search results
- Operation counts and details

## Database Schema Utilization

The application uses the complete schema from Lab 3.2:
- **users** table
- **videos** and **videos_by_author** tables (denormalized)
- **comments_by_video** and **comments_by_user** tables (denormalized)
- Supports future: video_followers, video_events, video_ratings_stats

## Technologies

- **Language**: Java 21
- **Database**: Apache Cassandra
- **Driver**: DataStax Java Driver 4.17.0
- **Build**: Apache Maven 3.x
- **Logging**: SLF4J + SLF4J-Simple

## Lessons Demonstrated

1. Connection management patterns
2. CRUD operation implementation
3. Query builder usage
4. DAO pattern for data access
5. Cassandra denormalization benefits
6. Error handling and logging
7. Maven project organization
8. Type-safe database operations

---

**Lab Completed**: Lab 3.3
**Date**: April 20, 2026
**Status**: ✓ Complete and Tested

