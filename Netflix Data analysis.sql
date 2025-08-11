SELECT * FROM netflix.netflix_titles;

SELECT count(*) as Total_count FROM netflix.netflix_titles;


select distinct type from netflix_titles;

SELECT * FROM netflix.netflix_titles;

-- 15 problems --

-- 1. Count th total number of movies vs tv shows

select type , count(*) as Total_content from netflix_titles group by type;

-- 2. Most common rating for movies and tv shows

select type , rating ,count(*) from netflix_titles group by 1,2 order by 1,3 desc;

select type , rating ,count(*) , rank() over(partition by type order by count(*) desc ) as Ranking
from  netflix_titles group by 1,2 ;

select type , rating 
from
 ( select type , rating ,count(*) , rank() over(partition by type order by count(*) desc ) as Ranking
from  netflix_titles group by 1,2
) as t1 where ranking =1 ;


-- 3 . List all movies released in a specific year 

select * from netflix_titles;

select * from netflix_titles where type = 'Movie' AND release_year = 2020 ;

-- 4 . Find the top 5 countries with most content on netflix

select * from netflix_titles ;

select country from netflix_titles;

SELECT 
    STR_TO_ARR(country , ',') AS new_country 
FROM netflix_titles;

-- 5. Identify longest movie?

select * from netflix_titles where type = 'movie' AND 
duration = (select max(duration) from netflix_titles);

-- 6. Find the content added in the last 5 years

SELECT * 
FROM netflix_titles 
WHERE date_added >= CURDATE() - INTERVAL 5 YEAR;

SELECT * 
FROM netflix_titles 
WHERE STR_TO_DATE(date_added, '%M %d, %Y') >= CURDATE() - INTERVAL 5 YEAR;

SELECT *  , TO_DATE(date_added ,'Month DD ,YYYY')
FROM netflix_titles 
WHERE STR_TO_DATE(date_added, '%M %d, %Y') >= CURDATE() - INTERVAL 5 YEAR;


SELECT *, 
       STR_TO_DATE(date_added, '%M %d, %Y') AS formatted_date
FROM netflix_titles
WHERE STR_TO_DATE(date_added, '%M %d, %Y') >= CURDATE() - INTERVAL 5 YEAR;

-- 7. FInd the all movies/ TV shows by director 'rajiv chilaka' 

select * from netflix_titles where director = 'Rajiv Chilaka';

select * from netflix_titles where director like  '%Rajiv Chilaka%';

select * from netflix_titles where director LIKE  '%Rajiv Chilaka%';


-- 8. list all tv shows with more than 5 seasons .

select * from netflix_titles where type = 'TV Show';


SELECT *
FROM netflix_titles
WHERE type = 'TV Show' and  SUBSTRING_INDEX(duration, ' ', 1) :: numeric > 5;



SELECT *
FROM netflix_titles
WHERE type = 'TV Show'
  AND CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) > 5;
  
  
-- 9 . Count the number of content items in each genre

select unnest (STRING_TO_ARRAY( listed_in , ',')) as list_genre , 
count(show_id)  from netflix_titles group by 1 ;
  


-- 10 . Find each year and the average numbers of content release in India on netflix.

SELECT 
    country,
    release_year,
    COUNT(show_id) AS total_release,
    ROUND(
        COUNT(show_id)::numeric /
        (SELECT COUNT(show_id) FROM netflix WHERE country = 'India')::numeric * 100, 2) AS avg_release
FROM netf
WHERE country = 'India'
GROUP BY country, release_year
ORDER BY avg_release DESC
LIMIT 5;

-- 11. List All Movies that are Documentaries

SELECT * FROM netflix_titles
WHERE listed_in LIKE '%Documentaries';


-- 12. Find All Content Without a Director

SELECT * 
FROM netflix_titles
WHERE director IS NULL;


-- 13. Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years

SELECT * 
FROM netflix_titles
WHERE casts LIKE '%Salman Khan%'
  AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;
  
  
-- 14. Find the Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in India

SELECT 
    UNNEST(STRING_TO_ARRAY(casts, ',')) AS actor,
    COUNT(*)
FROM netflix_titles
WHERE country = 'India'
GROUP BY actor
ORDER BY COUNT(*) DESC
LIMIT 10;


-- 15. Categorize Content Based on the Presence of 'Kill' and 'Violence' Keywords

SELECT 
    category,
    COUNT(*) AS content_count
FROM (
    SELECT 
        CASE 
            WHEN description LIKE '%kill%' OR description LIKE '%violence%' THEN 'Bad'
            ELSE 'Good'
        END AS category
    FROM netflix_titles
) AS categorized_content
GROUP BY category;