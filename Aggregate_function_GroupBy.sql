/* 
===================================
1.Apply aggregate functions on numeric columns
===================================
*/
SELECT 
    AVG(score) AS average_score,
    MAX(score) AS highest_score,
    MIN(score) AS lowest_score
FROM ExerciseResults;

/* 
===================================
2.Use GROUP BY to categorize
===================================
*/
SELECT 
    user_id,
    AVG(mood_level) AS avg_mood
FROM MoodLogs
GROUP BY user_id;


/* 
===================================
3.Filter groups using HAVING
===================================
*/
SELECT 
    user_id,
    AVG(mood_level) AS avg_mood
FROM MoodLogs
GROUP BY user_id
HAVING AVG(mood_level) > 7;

SELECT 
    start_time::DATE AS session_day,
    COUNT(*) AS session_count
FROM Sessions
GROUP BY start_time::DATE
HAVING start_time::DATE > '2023-09-01';






