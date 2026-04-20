-- 1. Os últimos 3 comentários introduzidos para um vídeos
SELECT * 
FROM comments_by_video 
WHERE video_id=6c0436f0-5b4f-11eb-b24e-52540054fe95
LIMIT 3
;

-- 2. Lista das tags de determinado vídeo
SELECT tags
FROM videos
WHERE video_id=6c0436f0-5b4f-11eb-b24e-52540054fe95
;

-- 3. Todos os vídeos com a tag Aveiro
CREATE INDEX ON videos (tags);
SELECT *
FROM videos
WHERE tags CONTAINS 'python' -- used 'python' instead of 'Aveiro' to actually show results
;

-- The best approach would be to create a new table and make each tag an entry, where the tag is the partition key.
-- For the sake of simplicity, I just created an index.

-- 4.
-- a) Os ultimos 5 eventos de determinado video realizados por um utilizador
SELECT *
FROM video_events
WHERE video_id = 6c0436f0-5b4f-11eb-b24e-52540054fe95
AND username = 'alice'
LIMIT 5
;

-- b) Todos os eventos de determinado utilizador
SELECT *
FROM video_events
WHERE username = 'alice'
ALLOW FILTERING
;

-- the most adequate approach is to create a new table user_events

-- c) Todos os eventos de determinado utilizador do tipo "pause"
SELECT *
FROM video_events
WHERE username = 'alice'
AND event_type = 'pause'
ALLOW FILTERING
;

-- the most adequate approach is to create a new table user_events_by_type

-- 5. Vídeos partilhados por determinado utilizador (maria1987, por exemplo) num determinado período de tempo (Agosto de 2017, por exemplo);

SELECT * FROM videos_by_author 
WHERE author_username = 'alice' 
AND upload_timestamp >= '2026-04-01 00:00:00' 
AND upload_timestamp < '2026-04-30 00:00:00'
;

-- cassandra does a slice on the table, because it is already sorted by upload date.

-- 6. Os últimos 10 vídeos, ordenado inversamente pela data da partilhada;

-- You can't successfully globally order anything in cassandra. The order by with clustering keys only work inside a partition.
-- The only way to globally order a whole table would be to put the whole table in a single partition, which is not efficient at all, and completely invalidates the use of cassandra in the first place.

-- 7. Todos os seguidores (followers) de determinado vídeo;

SELECT follower_username FROM video_followers
WHERE video_id = 6c0436f0-5b4f-11eb-b24e-52540054fe95
;

-- 8. Todos os comentários (dos vídeos) que determinado utilizador está a seguir (following)

-- Step 1) get the followed video_ids for the user
SELECT video_id
FROM followed_videos
WHERE follower_username = 'alice'
;

-- Step 2) then fetch comments for each returned video_id
SELECT *
FROM comments_by_video
WHERE video_id = 6c0436f0-5b4f-11eb-b24e-52540054fe95
LIMIT 5
;

-- Another approach would be to create a table comments_by_follower, with a partition key for the username of the user.
-- However this table would require a lot of updates, and it would probably be very inneficient.

-- query 9: Os 5 vídeos com maior rating
-- The current counter table stores totals per video, but it is not ordered by rating.
-- But even with a table for ratings per video, it would still not be possible to order the videos by ranking.
-- It would again require all rankings to be in the same cluster, which is not at all efficient and defeats the purpose of cassandra.


-- query 10: Uma query que retorne todos os vídeos e que mostre claramente a forma pela qual estão ordenados

SELECT token(author_username), author_username, upload_timestamp, title 
FROM videos_by_author;

-- query 11: Lista com as Tags existentes e o número de vídeos catalogados com cada uma delas
-- Cassandra cannot aggregate across a set<text> column efficiently without a query table.

-- Adequate approach: create a denormalized table with one row per tag.
-- Example query for that model:
-- SELECT tag, video_count
-- FROM videos_by_tag
-- ;



