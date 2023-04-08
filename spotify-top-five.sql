--https://datalemur.com/questions/top-fans-rank
--Top 5 Artists

--Assume there are three Spotify tables containing information about the artists, songs, and music charts. Write a query to determine the top 5 artists whose songs appear in the Top 10 of the global_song_rank table the highest number of times. From now on, we'll refer to this ranking number as "song appearances".

--Output the top 5 artist names in ascending order along with their song appearances ranking (not the number of song appearances, but the rank of who has the most appearances). The order of the rank should take precedence.

--For example, Ed Sheeran's songs appeared 5 times in Top 10 list of the global song rank table; this is the highest number of appearances, so he is ranked 1st. Bad Bunny's songs appeared in the list 4, so he comes in at a close 2nd.

--using CTE and DENSE_Rank() filter. This could probably be cleaned with a having
with t1 as (SELECT a.artist_name,
				dense_rank() OVER(ORDER BY count(*) DESC) rnk
			FROM artists as a
			LEFT JOIN songs as s 
			ON s.artist_id = a.artist_id
			LEFT JOIN global_song_rank as g 
			  ON g.song_id=s.song_id
			WHERE g.rank <= 10
			GROUP BY a.artist_name)

SELECT * from t1
WHERE rnk <= 5;