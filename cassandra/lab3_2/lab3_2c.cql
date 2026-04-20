-- query 7
SELECT * FROM videos_by_author WHERE author_username='bob';

--query 8
SELECT * FROM comments_by_user WHERE author_username='hannah';

-- query 9
SELECT * FROM comments_by_video WHERE video_id=6c0436f0-5b4f-11eb-b24e-52540054fe98;

-- query 10
SELECT total_sum, total_votes FROM video_ratings_stats WHERE video_id=6c0436f0-5b4f-11eb-b24e-52540054fe95;

-- the average fetching is not possible here
-- the business layer of the application would then calculate the average (total_sum/total_votes)