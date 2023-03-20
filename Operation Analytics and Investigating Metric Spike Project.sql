/* Case Study 1 (Operation Analytics)
A. Number of jobs reviewed */
SELECT COUNT(*)/(24*30) AS 'jobs/hour/day'
FROM job_data
WHERE EXTRACT(MONTH FROM ds) = 11
  AND EXTRACT(YEAR FROM ds) = 2020
GROUP BY EXTRACT(YEAR FROM ds), EXTRACT(MONTH FROM ds);

/* B. Throughput */
SELECT ds AS Date, Events_per_Day,
	   AVG(Events_per_Day) OVER (ORDER BY ds ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS '7-Day_Rolling_Avg'
FROM
	(SELECT ds, COUNT(event) AS Events_per_Day
	 FROM job_data
	 GROUP BY ds
	 ORDER BY ds) sub
ORDER BY 1;

/* C. Percentage share of each language */
SELECT language, COUNT(job_id) AS 'LanguageCount',
	   COUNT(*) * 100 / SUM(COUNT(*)) OVER ( ) AS '%_Share'
FROM (SELECT * 
	  FROM job_data
	  WHERE ds >= DATE_SUB((SELECT MAX(ds) FROM job_data), INTERVAL 30 DAY)) sub
GROUP BY 1
ORDER BY 1;

/* D. Duplicate rows */
select *
from job_data
group by ds, job_id, actor_id, event, language, time_spent, org
having count(*)>1;

/* Case Study 2 (Investigating Metric Spike)
A. User Engagement */
SELECT COUNT(DISTINCT user_id) AS No_of_Users, WEEK(occurred_at) AS Week,
	   CAST(MIN(occurred_at) AS DATE) AS Week_Start, CAST(MAX(occurred_at) AS DATE) AS Week_End
FROM events
GROUP BY 2
ORDER BY 2;

/* B. User Growth */
SELECT CONCAT(SUBSTRING(Month,1,4),'-',SUBSTRING(Month,5,2)) AS Month, New_Users, ((New_Users- Prev_Month)/Prev_Month)*100 AS 'Growth_Rate(%)'
FROM (SELECT *, LAG(New_Users,1) OVER(ORDER BY Month) AS Prev_Month
	  FROM (SELECT EXTRACT(YEAR_MONTH FROM created_at) AS Month, COUNT(user_id) AS New_Users
			FROM users
			GROUP BY 1) sub) sub2
ORDER BY Month;

/* C. Weekly Retention */
SELECT first_login_week,
SUM(CASE WHEN week_number = 0 THEN 1 ELSE 0 END) AS week_0,
SUM(CASE WHEN week_number = 1 THEN 1 ELSE 0 END) AS week_1,
SUM(CASE WHEN week_number = 2 THEN 1 ELSE 0 END) AS week_2,
SUM(CASE WHEN week_number = 3 THEN 1 ELSE 0 END) AS week_3,
SUM(CASE WHEN week_number = 4 THEN 1 ELSE 0 END) AS week_4,
SUM(CASE WHEN week_number = 5 THEN 1 ELSE 0 END) AS week_5,
SUM(CASE WHEN week_number = 6 THEN 1 ELSE 0 END) AS week_6,
SUM(CASE WHEN week_number = 7 THEN 1 ELSE 0 END) AS week_7,
SUM(CASE WHEN week_number = 8 THEN 1 ELSE 0 END) AS week_8,
SUM(CASE WHEN week_number = 9 THEN 1 ELSE 0 END) AS week_9,
SUM(CASE WHEN week_number = 10 THEN 1 ELSE 0 END) AS week_10,
SUM(CASE WHEN week_number = 11 THEN 1 ELSE 0 END) AS week_11,
SUM(CASE WHEN week_number = 12 THEN 1 ELSE 0 END) AS week_12,
SUM(CASE WHEN week_number = 13 THEN 1 ELSE 0 END) AS week_13,
SUM(CASE WHEN week_number = 14 THEN 1 ELSE 0 END) AS week_14,
SUM(CASE WHEN week_number = 15 THEN 1 ELSE 0 END) AS week_15,
SUM(CASE WHEN week_number = 16 THEN 1 ELSE 0 END) AS week_16,
SUM(CASE WHEN week_number = 17 THEN 1 ELSE 0 END) AS week_17,
SUM(CASE WHEN week_number = 18 THEN 1 ELSE 0 END) AS week_18
FROM
(SELECT log.user_id, login_week, first_login_week, login_week - first_login_week AS week_number
FROM (SELECT user_id, EXTRACT(WEEK FROM occurred_at) AS login_week
	  FROM events
	  WHERE event_name = 'login' 
	  GROUP BY 1, 2) log
	 INNER JOIN
	 (SELECT user_id, MIN(EXTRACT(WEEK FROM occurred_at)) AS first_login_week
	  FROM events
	  WHERE event_name = 'login' 
	  GROUP BY 1) first_log
   ON log.user_id = first_log.user_id) sub_week_no
GROUP BY 1
ORDER BY 1;

/* D. Weekly Engagement */
SELECT device, COUNT(DISTINCT user_id) AS No_of_Users, WEEK(occurred_at) AS Week,
	   CAST(MIN(occurred_at) AS DATE) AS Week_Start, CAST(MAX(occurred_at) AS DATE) AS Week_End
FROM events
GROUP BY 1, 3
ORDER BY 1, 3;

/* E. Email Engagement */
/* Weekly engagement */
SELECT COUNT(DISTINCT user_id) AS No_of_Users, WEEK(occurred_at) AS Week,
	   CAST(MIN(occurred_at) AS DATE) AS Week_Start, CAST(MAX(occurred_at) AS DATE) AS Week_End
FROM email_events
GROUP BY 2
ORDER BY 2;

/* Weekly engagement for each action */
SELECT action, COUNT(DISTINCT user_id) AS No_of_Users, WEEK(occurred_at) AS Week,
	   CAST(MIN(occurred_at) AS DATE) AS Week_Start, CAST(MAX(occurred_at) AS DATE) AS Week_End
FROM email_events
GROUP BY 1,3
ORDER BY 1,3;