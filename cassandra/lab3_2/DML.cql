-- Data Insertion Queries (DML) for Video Platform Schema
-- Insert 10-30 entries in each table with realistic data

-- ===== USERS TABLE =====
INSERT INTO users (username, name, email, created_at) VALUES ('alice', 'Alice Johnson', 'alice@example.com', toTimestamp(now()));
INSERT INTO users (username, name, email, created_at) VALUES ('bob', 'Bob Smith', 'bob@example.com', toTimestamp(now()));
INSERT INTO users (username, name, email, created_at) VALUES ('charlie', 'Charlie Brown', 'charlie@example.com', toTimestamp(now()));
INSERT INTO users (username, name, email, created_at) VALUES ('diana', 'Diana Prince', 'diana@example.com', toTimestamp(now()));
INSERT INTO users (username, name, email, created_at) VALUES ('evan', 'Evan Davis', 'evan@example.com', toTimestamp(now()));
INSERT INTO users (username, name, email, created_at) VALUES ('fiona', 'Fiona Green', 'fiona@example.com', toTimestamp(now()));
INSERT INTO users (username, name, email, created_at) VALUES ('george', 'George Wilson', 'george@example.com', toTimestamp(now()));
INSERT INTO users (username, name, email, created_at) VALUES ('hannah', 'Hannah Lee', 'hannah@example.com', toTimestamp(now()));
INSERT INTO users (username, name, email, created_at) VALUES ('isaac', 'Isaac Martinez', 'isaac@example.com', toTimestamp(now()));
INSERT INTO users (username, name, email, created_at) VALUES ('julia', 'Julia Taylor', 'julia@example.com', toTimestamp(now()));
INSERT INTO users (username, name, email, created_at) VALUES ('kevin', 'Kevin Anderson', 'kevin@example.com', toTimestamp(now()));
INSERT INTO users (username, name, email, created_at) VALUES ('lucy', 'Lucy White', 'lucy@example.com', toTimestamp(now()));
INSERT INTO users (username, name, email, created_at) VALUES ('mike', 'Mike Johnson', 'mike@example.com', toTimestamp(now()));
INSERT INTO users (username, name, email, created_at) VALUES ('nancy', 'Nancy Brown', 'nancy@example.com', toTimestamp(now()));
INSERT INTO users (username, name, email, created_at) VALUES ('oscar', 'Oscar Garcia', 'oscar@example.com', toTimestamp(now()));

-- ===== VIDEOS_BY_AUTHOR TABLE =====
-- Videos by Alice
INSERT INTO videos_by_author (author_username, video_id, title, description, tags, upload_timestamp) 
VALUES ('alice', 6c0436f0-5b4f-11eb-b24e-52540054fe95, 'Intro to Cassandra', 'A comprehensive introduction to distributed databases', {'database', 'tutorial', 'cassandra'}, toTimestamp(now()));
INSERT INTO videos_by_author (author_username, video_id, title, description, tags, upload_timestamp) 
VALUES ('alice', 6c0436f0-5b4f-11eb-b24e-52540054fe9a, 'Advanced Query Patterns', 'Learn advanced patterns for Cassandra queries', {'database', 'advanced', 'cassandra'}, toTimestamp(now()));
INSERT INTO videos_by_author (author_username, video_id, title, description, tags, upload_timestamp) 
VALUES ('alice', 6c0436f0-5b4f-11eb-b24e-52540054fe9b, 'Data Modeling Best Practices', 'Best practices for designing Cassandra schemas', {'database', 'design', 'cassandra'}, toTimestamp(now()));

-- Videos by Bob
INSERT INTO videos_by_author (author_username, video_id, title, description, tags, upload_timestamp) 
VALUES ('bob', 6c0436f0-5b4f-11eb-b24e-52540054fe96, 'Python for Beginners', 'Getting started with Python programming', {'python', 'programming', 'tutorial'}, toTimestamp(now()));
INSERT INTO videos_by_author (author_username, video_id, title, description, tags, upload_timestamp) 
VALUES ('bob', 6c0436f0-5b4f-11eb-b24e-52540054fe9c, 'Web Development with Flask', 'Build web applications using Flask framework', {'python', 'web', 'flask'}, toTimestamp(now()));
INSERT INTO videos_by_author (author_username, video_id, title, description, tags, upload_timestamp) 
VALUES ('bob', 6c0436f0-5b4f-11eb-b24e-52540054fe9d, 'APIs and REST Services', 'Understanding RESTful API design', {'api', 'rest', 'web'}, toTimestamp(now()));
INSERT INTO videos_by_author (author_username, video_id, title, description, tags, upload_timestamp) 
VALUES ('bob', 6c0436f0-5b4f-11eb-b24e-52540054fe9e, 'Testing in Python', 'Unit testing and integration testing in Python', {'python', 'testing', 'programming'}, toTimestamp(now()));

-- Videos by Charlie
INSERT INTO videos_by_author (author_username, video_id, title, description, tags, upload_timestamp) 
VALUES ('charlie', 6c0436f0-5b4f-11eb-b24e-52540054fe97, 'Docker Essentials', 'Getting started with containerization', {'docker', 'devops', 'containers'}, toTimestamp(now()));
INSERT INTO videos_by_author (author_username, video_id, title, description, tags, upload_timestamp) 
VALUES ('charlie', 6c0436f0-5b4f-11eb-b24e-52540054fe9f, 'Kubernetes Deployment', 'Deploy applications on Kubernetes clusters', {'kubernetes', 'devops', 'orchestration'}, toTimestamp(now()));
INSERT INTO videos_by_author (author_username, video_id, title, description, tags, upload_timestamp) 
VALUES ('charlie', 6c0436f0-5b4f-11eb-b24e-52540054fea0, 'CI/CD Pipelines', 'Building automated deployment pipelines', {'devops', 'cicd', 'automation'}, toTimestamp(now()));

-- Videos by Diana
INSERT INTO videos_by_author (author_username, video_id, title, description, tags, upload_timestamp) 
VALUES ('diana', 6c0436f0-5b4f-11eb-b24e-52540054fe98, 'Machine Learning Basics', 'Introduction to machine learning concepts', {'ml', 'ai', 'tutorial'}, toTimestamp(now()));
INSERT INTO videos_by_author (author_username, video_id, title, description, tags, upload_timestamp) 
VALUES ('diana', 6c0436f0-5b4f-11eb-b24e-52540054fea1, 'Neural Networks Explained', 'Deep dive into neural network architectures', {'ml', 'ai', 'deep-learning'}, toTimestamp(now()));
INSERT INTO videos_by_author (author_username, video_id, title, description, tags, upload_timestamp) 
VALUES ('diana', 6c0436f0-5b4f-11eb-b24e-52540054fea2, 'Computer Vision Projects', 'Practical computer vision applications', {'ml', 'cv', 'projects'}, toTimestamp(now()));
INSERT INTO videos_by_author (author_username, video_id, title, description, tags, upload_timestamp) 
VALUES ('diana', 6c0436f0-5b4f-11eb-b24e-52540054fea3, 'NLP Fundamentals', 'Natural language processing basics', {'ml', 'nlp', 'ai'}, toTimestamp(now()));

-- Videos by Evan
INSERT INTO videos_by_author (author_username, video_id, title, description, tags, upload_timestamp) 
VALUES ('evan', 6c0436f0-5b4f-11eb-b24e-52540054fe99, 'Java Enterprise Development', 'Building enterprise applications with Java', {'java', 'enterprise', 'backend'}, toTimestamp(now()));
INSERT INTO videos_by_author (author_username, video_id, title, description, tags, upload_timestamp) 
VALUES ('evan', 6c0436f0-5b4f-11eb-b24e-52540054fea4, 'Spring Boot Framework', 'Rapid application development with Spring Boot', {'java', 'spring', 'web'}, toTimestamp(now()));

-- Videos by Fiona
INSERT INTO videos_by_author (author_username, video_id, title, description, tags, upload_timestamp) 
VALUES ('fiona', 6c0436f0-5b4f-11eb-b24e-52540054fea5, 'React Frontend Development', 'Building dynamic UIs with React', {'react', 'frontend', 'javascript'}, toTimestamp(now()));
INSERT INTO videos_by_author (author_username, video_id, title, description, tags, upload_timestamp) 
VALUES ('fiona', 6c0436f0-5b4f-11eb-b24e-52540054fea6, 'Advanced CSS Techniques', 'Master modern CSS for responsive design', {'css', 'frontend', 'design'}, toTimestamp(now()));
INSERT INTO videos_by_author (author_username, video_id, title, description, tags, upload_timestamp) 
VALUES ('fiona', 6c0436f0-5b4f-11eb-b24e-52540054fea7, 'JavaScript Async Programming', 'Understanding promises, async/await', {'javascript', 'frontend', 'async'}, toTimestamp(now()));

-- ===== VIDEOS TABLE =====
-- Canonical table keyed by video_id for direct fetch/display.
INSERT INTO videos (video_id, author_username, title, description, tags, upload_timestamp)
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe95, 'alice', 'Intro to Cassandra', 'A comprehensive introduction to distributed databases', {'database', 'tutorial', 'cassandra'}, toTimestamp(now()));
INSERT INTO videos (video_id, author_username, title, description, tags, upload_timestamp)
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe9a, 'alice', 'Advanced Query Patterns', 'Learn advanced patterns for Cassandra queries', {'database', 'advanced', 'cassandra'}, toTimestamp(now()));
INSERT INTO videos (video_id, author_username, title, description, tags, upload_timestamp)
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe9b, 'alice', 'Data Modeling Best Practices', 'Best practices for designing Cassandra schemas', {'database', 'design', 'cassandra'}, toTimestamp(now()));
INSERT INTO videos (video_id, author_username, title, description, tags, upload_timestamp)
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe96, 'bob', 'Python for Beginners', 'Getting started with Python programming', {'python', 'programming', 'tutorial'}, toTimestamp(now()));
INSERT INTO videos (video_id, author_username, title, description, tags, upload_timestamp)
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe9c, 'bob', 'Web Development with Flask', 'Build web applications using Flask framework', {'python', 'web', 'flask'}, toTimestamp(now()));
INSERT INTO videos (video_id, author_username, title, description, tags, upload_timestamp)
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe9d, 'bob', 'APIs and REST Services', 'Understanding RESTful API design', {'api', 'rest', 'web'}, toTimestamp(now()));
INSERT INTO videos (video_id, author_username, title, description, tags, upload_timestamp)
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe9e, 'bob', 'Testing in Python', 'Unit testing and integration testing in Python', {'python', 'testing', 'programming'}, toTimestamp(now()));
INSERT INTO videos (video_id, author_username, title, description, tags, upload_timestamp)
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe97, 'charlie', 'Docker Essentials', 'Getting started with containerization', {'docker', 'devops', 'containers'}, toTimestamp(now()));
INSERT INTO videos (video_id, author_username, title, description, tags, upload_timestamp)
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe9f, 'charlie', 'Kubernetes Deployment', 'Deploy applications on Kubernetes clusters', {'kubernetes', 'devops', 'orchestration'}, toTimestamp(now()));
INSERT INTO videos (video_id, author_username, title, description, tags, upload_timestamp)
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fea0, 'charlie', 'CI/CD Pipelines', 'Building automated deployment pipelines', {'devops', 'cicd', 'automation'}, toTimestamp(now()));
INSERT INTO videos (video_id, author_username, title, description, tags, upload_timestamp)
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe98, 'diana', 'Machine Learning Basics', 'Introduction to machine learning concepts', {'ml', 'ai', 'tutorial'}, toTimestamp(now()));
INSERT INTO videos (video_id, author_username, title, description, tags, upload_timestamp)
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fea1, 'diana', 'Neural Networks Explained', 'Deep dive into neural network architectures', {'ml', 'ai', 'deep-learning'}, toTimestamp(now()));
INSERT INTO videos (video_id, author_username, title, description, tags, upload_timestamp)
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fea2, 'diana', 'Computer Vision Projects', 'Practical computer vision applications', {'ml', 'cv', 'projects'}, toTimestamp(now()));
INSERT INTO videos (video_id, author_username, title, description, tags, upload_timestamp)
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fea3, 'diana', 'NLP Fundamentals', 'Natural language processing basics', {'ml', 'nlp', 'ai'}, toTimestamp(now()));
INSERT INTO videos (video_id, author_username, title, description, tags, upload_timestamp)
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe99, 'evan', 'Java Enterprise Development', 'Building enterprise applications with Java', {'java', 'enterprise', 'backend'}, toTimestamp(now()));
INSERT INTO videos (video_id, author_username, title, description, tags, upload_timestamp)
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fea4, 'evan', 'Spring Boot Framework', 'Rapid application development with Spring Boot', {'java', 'spring', 'web'}, toTimestamp(now()));
INSERT INTO videos (video_id, author_username, title, description, tags, upload_timestamp)
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fea5, 'fiona', 'React Frontend Development', 'Building dynamic UIs with React', {'react', 'frontend', 'javascript'}, toTimestamp(now()));
INSERT INTO videos (video_id, author_username, title, description, tags, upload_timestamp)
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fea6, 'fiona', 'Advanced CSS Techniques', 'Master modern CSS for responsive design', {'css', 'frontend', 'design'}, toTimestamp(now()));
INSERT INTO videos (video_id, author_username, title, description, tags, upload_timestamp)
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fea7, 'fiona', 'JavaScript Async Programming', 'Understanding promises, async/await', {'javascript', 'frontend', 'async'}, toTimestamp(now()));

-- ===== VIDEO_FOLLOWERS TABLE =====
INSERT INTO video_followers (video_id, follower_username, followed_at) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe95, 'bob', toTimestamp(now()));
INSERT INTO video_followers (video_id, follower_username, followed_at) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe95, 'charlie', toTimestamp(now()));
INSERT INTO video_followers (video_id, follower_username, followed_at) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe95, 'diana', toTimestamp(now()));
INSERT INTO video_followers (video_id, follower_username, followed_at) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe95, 'evan', toTimestamp(now()));
INSERT INTO video_followers (video_id, follower_username, followed_at) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe95, 'fiona', toTimestamp(now()));
INSERT INTO video_followers (video_id, follower_username, followed_at) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe96, 'alice', toTimestamp(now()));
INSERT INTO video_followers (video_id, follower_username, followed_at) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe96, 'charlie', toTimestamp(now()));
INSERT INTO video_followers (video_id, follower_username, followed_at) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe96, 'diana', toTimestamp(now()));
INSERT INTO video_followers (video_id, follower_username, followed_at) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe97, 'alice', toTimestamp(now()));
INSERT INTO video_followers (video_id, follower_username, followed_at) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe97, 'bob', toTimestamp(now()));
INSERT INTO video_followers (video_id, follower_username, followed_at) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe97, 'evan', toTimestamp(now()));
INSERT INTO video_followers (video_id, follower_username, followed_at) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe97, 'fiona', toTimestamp(now()));
INSERT INTO video_followers (video_id, follower_username, followed_at) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe97, 'george', toTimestamp(now()));
INSERT INTO video_followers (video_id, follower_username, followed_at) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe98, 'hannah', toTimestamp(now()));
INSERT INTO video_followers (video_id, follower_username, followed_at) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe98, 'isaac', toTimestamp(now()));
INSERT INTO video_followers (video_id, follower_username, followed_at) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe98, 'julia', toTimestamp(now()));
INSERT INTO video_followers (video_id, follower_username, followed_at) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe99, 'kevin', toTimestamp(now()));
INSERT INTO video_followers (video_id, follower_username, followed_at) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe99, 'lucy', toTimestamp(now()));
INSERT INTO video_followers (video_id, follower_username, followed_at) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe99, 'mike', toTimestamp(now()));
INSERT INTO video_followers (video_id, follower_username, followed_at) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe99, 'nancy', toTimestamp(now()));

-- ===== VIDEO_EVENTS TABLE =====
INSERT INTO video_events (video_id, username, event_timestamp, event_type, video_timestamp) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe95, 'alice', toTimestamp(now()), 'play', 0);
INSERT INTO video_events (video_id, username, event_timestamp, event_type, video_timestamp) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe95, 'alice', toTimestamp(now()), 'pause', 120);
INSERT INTO video_events (video_id, username, event_timestamp, event_type, video_timestamp) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe95, 'alice', toTimestamp(now()), 'play', 120);
INSERT INTO video_events (video_id, username, event_timestamp, event_type, video_timestamp) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe95, 'alice', toTimestamp(now()), 'stop', 600);
INSERT INTO video_events (video_id, username, event_timestamp, event_type, video_timestamp) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe96, 'bob', toTimestamp(now()), 'play', 0);
INSERT INTO video_events (video_id, username, event_timestamp, event_type, video_timestamp) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe96, 'bob', toTimestamp(now()), 'pause', 300);
INSERT INTO video_events (video_id, username, event_timestamp, event_type, video_timestamp) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe96, 'bob', toTimestamp(now()), 'stop', 300);
INSERT INTO video_events (video_id, username, event_timestamp, event_type, video_timestamp) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe97, 'charlie', toTimestamp(now()), 'play', 0);
INSERT INTO video_events (video_id, username, event_timestamp, event_type, video_timestamp) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe97, 'charlie', toTimestamp(now()), 'stop', 800);
INSERT INTO video_events (video_id, username, event_timestamp, event_type, video_timestamp) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe98, 'diana', toTimestamp(now()), 'play', 0);
INSERT INTO video_events (video_id, username, event_timestamp, event_type, video_timestamp) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe98, 'diana', toTimestamp(now()), 'pause', 250);
INSERT INTO video_events (video_id, username, event_timestamp, event_type, video_timestamp) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe98, 'diana', toTimestamp(now()), 'play', 250);
INSERT INTO video_events (video_id, username, event_timestamp, event_type, video_timestamp) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe98, 'diana', toTimestamp(now()), 'pause', 500);
INSERT INTO video_events (video_id, username, event_timestamp, event_type, video_timestamp) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe99, 'evan', toTimestamp(now()), 'play', 0);
INSERT INTO video_events (video_id, username, event_timestamp, event_type, video_timestamp) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe99, 'evan', toTimestamp(now()), 'stop', 1200);
INSERT INTO video_events (video_id, username, event_timestamp, event_type, video_timestamp) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe95, 'fiona', toTimestamp(now()), 'play', 0);
INSERT INTO video_events (video_id, username, event_timestamp, event_type, video_timestamp) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe95, 'fiona', toTimestamp(now()), 'pause', 150);
INSERT INTO video_events (video_id, username, event_timestamp, event_type, video_timestamp) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe96, 'george', toTimestamp(now()), 'play', 0);
INSERT INTO video_events (video_id, username, event_timestamp, event_type, video_timestamp) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe97, 'hannah', toTimestamp(now()), 'play', 0);
INSERT INTO video_events (video_id, username, event_timestamp, event_type, video_timestamp) VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe97, 'hannah', toTimestamp(now()), 'stop', 400);

-- ===== VIDEO_RATINGS_STATS TABLE =====
-- Counter tables do not support INSERT. Use UPDATE with increments.
UPDATE video_ratings_stats SET total_sum = total_sum + 48, total_votes = total_votes + 10 WHERE video_id = 6c0436f0-5b4f-11eb-b24e-52540054fe95;
UPDATE video_ratings_stats SET total_sum = total_sum + 42, total_votes = total_votes + 9 WHERE video_id = 6c0436f0-5b4f-11eb-b24e-52540054fe96;
UPDATE video_ratings_stats SET total_sum = total_sum + 50, total_votes = total_votes + 10 WHERE video_id = 6c0436f0-5b4f-11eb-b24e-52540054fe97;
UPDATE video_ratings_stats SET total_sum = total_sum + 35, total_votes = total_votes + 8 WHERE video_id = 6c0436f0-5b4f-11eb-b24e-52540054fe98;
UPDATE video_ratings_stats SET total_sum = total_sum + 45, total_votes = total_votes + 9 WHERE video_id = 6c0436f0-5b4f-11eb-b24e-52540054fe99;

-- ===== COMMENTS_BY_VIDEO TABLE =====
-- Note: Using timeuuid() for automatic timestamp generation
INSERT INTO comments_by_video (video_id, comment_id, author_username, content) 
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe95, now(), 'bob', 'Great introduction! Really helpful.');
INSERT INTO comments_by_video (video_id, comment_id, author_username, content) 
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe95, now(), 'charlie', 'Could you provide more examples?');
INSERT INTO comments_by_video (video_id, comment_id, author_username, content) 
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe95, now(), 'diana', 'Excellent work, thanks for sharing!');
INSERT INTO comments_by_video (video_id, comment_id, author_username, content) 
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe96, now(), 'evan', 'This is exactly what I needed.');
INSERT INTO comments_by_video (video_id, comment_id, author_username, content) 
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe96, now(), 'fiona', 'Can you do a follow-up video?');
INSERT INTO comments_by_video (video_id, comment_id, author_username, content) 
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe96, now(), 'george', 'This helped me understand better.');
INSERT INTO comments_by_video (video_id, comment_id, author_username, content) 
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe97, now(), 'hannah', 'Amazing content!');
INSERT INTO comments_by_video (video_id, comment_id, author_username, content) 
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe97, now(), 'isaac', 'Very clear explanation.');
INSERT INTO comments_by_video (video_id, comment_id, author_username, content) 
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe98, now(), 'julia', 'Looking forward to more videos like this.');
INSERT INTO comments_by_video (video_id, comment_id, author_username, content) 
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe98, now(), 'kevin', 'Very informative!');
INSERT INTO comments_by_video (video_id, comment_id, author_username, content) 
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe98, now(), 'lucy', 'Thanks for the tutorial.');
INSERT INTO comments_by_video (video_id, comment_id, author_username, content) 
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe99, now(), 'mike', 'Well explained with good examples.');
INSERT INTO comments_by_video (video_id, comment_id, author_username, content) 
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe99, now(), 'nancy', 'This was exactly what I was looking for.');
INSERT INTO comments_by_video (video_id, comment_id, author_username, content) 
VALUES (6c0436f0-5b4f-11eb-b24e-52540054fe95, now(), 'oscar', 'Top quality content.');

-- ===== COMMENTS_BY_USER TABLE =====
-- These mirror the comments_by_video entries from a user perspective
INSERT INTO comments_by_user (author_username, comment_id, video_id, content) 
VALUES ('bob', now(), 6c0436f0-5b4f-11eb-b24e-52540054fe95, 'Great introduction! Really helpful.');
INSERT INTO comments_by_user (author_username, comment_id, video_id, content) 
VALUES ('charlie', now(), 6c0436f0-5b4f-11eb-b24e-52540054fe95, 'Could you provide more examples?');
INSERT INTO comments_by_user (author_username, comment_id, video_id, content) 
VALUES ('diana', now(), 6c0436f0-5b4f-11eb-b24e-52540054fe95, 'Excellent work, thanks for sharing!');
INSERT INTO comments_by_user (author_username, comment_id, video_id, content) 
VALUES ('evan', now(), 6c0436f0-5b4f-11eb-b24e-52540054fe96, 'This is exactly what I needed.');
INSERT INTO comments_by_user (author_username, comment_id, video_id, content) 
VALUES ('fiona', now(), 6c0436f0-5b4f-11eb-b24e-52540054fe96, 'Can you do a follow-up video?');
INSERT INTO comments_by_user (author_username, comment_id, video_id, content) 
VALUES ('george', now(), 6c0436f0-5b4f-11eb-b24e-52540054fe96, 'This helped me understand better.');
INSERT INTO comments_by_user (author_username, comment_id, video_id, content) 
VALUES ('hannah', now(), 6c0436f0-5b4f-11eb-b24e-52540054fe97, 'Amazing content!');
INSERT INTO comments_by_user (author_username, comment_id, video_id, content) 
VALUES ('isaac', now(), 6c0436f0-5b4f-11eb-b24e-52540054fe97, 'Very clear explanation.');
INSERT INTO comments_by_user (author_username, comment_id, video_id, content) 
VALUES ('julia', now(), 6c0436f0-5b4f-11eb-b24e-52540054fe98, 'Looking forward to more videos like this.');
INSERT INTO comments_by_user (author_username, comment_id, video_id, content) 
VALUES ('kevin', now(), 6c0436f0-5b4f-11eb-b24e-52540054fe98, 'Very informative!');
INSERT INTO comments_by_user (author_username, comment_id, video_id, content) 
VALUES ('lucy', now(), 6c0436f0-5b4f-11eb-b24e-52540054fe98, 'Thanks for the tutorial.');
INSERT INTO comments_by_user (author_username, comment_id, video_id, content) 
VALUES ('mike', now(), 6c0436f0-5b4f-11eb-b24e-52540054fe99, 'Well explained with good examples.');
INSERT INTO comments_by_user (author_username, comment_id, video_id, content) 
VALUES ('nancy', now(), 6c0436f0-5b4f-11eb-b24e-52540054fe99, 'This was exactly what I was looking for.');
INSERT INTO comments_by_user (author_username, comment_id, video_id, content) 
VALUES ('oscar', now(), 6c0436f0-5b4f-11eb-b24e-52540054fe95, 'Top quality content.');
