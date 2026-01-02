USE FIFAAnalytics;
GO

-------------------------------------------------
-- 11. Rank players by total goals (Window Function)
-------------------------------------------------
SELECT
    p.name,
    SUM(ps.goals) AS total_goals,
    RANK() OVER (ORDER BY SUM(ps.goals) DESC) AS goal_rank
FROM player_stats ps
JOIN players p ON ps.player_id = p.player_id
GROUP BY p.name;


-------------------------------------------------
-- 12. Running total of goals per player
-------------------------------------------------
SELECT
    p.name,
    ps.match_id,
    ps.goals,
    SUM(ps.goals) OVER (PARTITION BY p.name ORDER BY ps.match_id) AS running_goals
FROM player_stats ps
JOIN players p ON ps.player_id = p.player_id;


-------------------------------------------------
-- 13. CTE: Player performance summary
-------------------------------------------------
WITH player_summary AS (
    SELECT
        player_id,
        SUM(goals) AS total_goals,
        SUM(assists) AS total_assists,
        COUNT(match_id) AS matches_played
    FROM player_stats
    GROUP BY player_id
)
SELECT
    p.name,
    ps.total_goals,
    ps.total_assists,
    ps.matches_played
FROM player_summary ps
JOIN players p ON ps.player_id = p.player_id
ORDER BY ps.total_goals DESC;


-------------------------------------------------
-- 14. Players scoring above average goals
-------------------------------------------------
SELECT
    p.name,
    SUM(ps.goals) AS total_goals
FROM player_stats ps
JOIN players p ON ps.player_id = p.player_id
GROUP BY p.name
HAVING SUM(ps.goals) >
       (SELECT AVG(goals) FROM player_stats);


-------------------------------------------------
-- 15. Best goal contribution (Goals + Assists)
-------------------------------------------------
SELECT
    p.name,
    SUM(ps.goals + ps.assists) AS goal_contribution
FROM player_stats ps
JOIN players p ON ps.player_id = p.player_id
GROUP BY p.name
ORDER BY goal_contribution DESC;


-------------------------------------------------
-- 16. Most consistent players (minutes played)
-------------------------------------------------
SELECT
    p.name,
    AVG(ps.minutes_played) AS avg_minutes
FROM player_stats ps
JOIN players p ON ps.player_id = p.player_id
GROUP BY p.name
ORDER BY avg_minutes DESC;


-------------------------------------------------
-- 17. Team-wise total goals (Home + Away)
-------------------------------------------------
SELECT team, SUM(goals) AS total_goals
FROM (
    SELECT home_team AS team, home_score AS goals FROM matches
    UNION ALL
    SELECT away_team AS team, away_score AS goals FROM matches
) t
GROUP BY team
ORDER BY total_goals DESC;


-------------------------------------------------
-- 18. Matches where goal difference > 2
-------------------------------------------------
SELECT
    match_id,
    home_team,
    away_team,
    ABS(home_score - away_score) AS goal_difference
FROM matches
WHERE ABS(home_score - away_score) > 2;


-------------------------------------------------
-- 19. Players with zero disciplinary records
-------------------------------------------------
SELECT
    p.name
FROM players p
LEFT JOIN player_stats ps ON p.player_id = ps.player_id
GROUP BY p.name
HAVING SUM(ps.yellow_cards + ps.red_cards) = 0;


-------------------------------------------------
-- 20. Top scorer per club
-------------------------------------------------
WITH club_goals AS (
    SELECT
        p.club,
        p.name,
        SUM(ps.goals) AS total_goals
    FROM player_stats ps
    JOIN players p ON ps.player_id = p.player_id
    GROUP BY p.club, p.name
)
SELECT *
FROM (
    SELECT *,
           RANK() OVER (PARTITION BY club ORDER BY total_goals DESC) AS club_rank
    FROM club_goals
) ranked
WHERE club_rank = 1;
