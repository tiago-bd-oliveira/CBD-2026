CREATE TABLE IF NOT EXISTS users (
    username text PRIMARY KEY,
    name text,
    email text,
    created_at timestamp
);

CREATE TABLE IF NOT EXISTS videos_by_author (
    author_username text,
    video_id uuid,
    title text,
    description text,
    tags set<text>,
    upload_timestamp timestamp,
    PRIMARY KEY (author_username, upload_timestamp, video_id)
) WITH CLUSTERING ORDER BY (upload_timestamp DESC, video_id ASC);

CREATE TABLE IF NOT EXISTS videos (
    video_id uuid PRIMARY KEY,
    author_username text,
    title text,
    description text,
    tags set<text>,
    upload_timestamp timestamp
);

CREATE TABLE IF NOT EXISTS comments_by_video (
    video_id uuid,
    comment_id timeuuid,
    author_username text,
    content text,
    PRIMARY KEY (video_id, comment_id)
) WITH CLUSTERING ORDER BY (comment_id DESC);

CREATE TABLE IF NOT EXISTS comments_by_user (
    author_username text,
    comment_id timeuuid,
    video_id uuid,
    content text,
    PRIMARY KEY (author_username, comment_id)
) WITH CLUSTERING ORDER BY (comment_id DESC);

CREATE TABLE IF NOT EXISTS video_followers (
    video_id uuid,
    follower_username text,
    followed_at timestamp,
    PRIMARY KEY (video_id, followed_at, follower_username)
) WITH CLUSTERING ORDER BY (followed_at DESC);

CREATE TABLE IF NOT EXISTS followed_videos (
    video_id uuid,
    follower_username text,
    followed_at timestamp,
    PRIMARY KEY (follower_username, followed_at, video_id)
) WITH CLUSTERING ORDER BY (followed_at DESC);

CREATE TABLE IF NOT EXISTS video_events (
    video_id uuid,
    username text,
    event_timestamp timestamp,
    event_type text, -- play, pause, stop
    video_timestamp int,
    PRIMARY KEY ((video_id, username), event_timestamp)
) WITH CLUSTERING ORDER BY (event_timestamp DESC);

CREATE TABLE IF NOT EXISTS video_ratings_stats (
    video_id uuid PRIMARY KEY,
    total_sum counter,
    total_votes counter
);