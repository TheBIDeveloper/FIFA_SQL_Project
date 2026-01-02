USE FIFAAnalytics;
GO

-------------------------------------------------
-- 1. Top 5 players by overall rating
-------------------------------------------------
SELECT TOP 5
    name,
    overall_rating,
    potential,
    club
FROM players
ORDER BY overall_rating DESC;


-------------------------------------------------
-- 2. Players with potential higher than overall
-------------------------------------------------
SELECT
    name,
    overall_rating,
    potential,
    (potential - overall_rating) AS growth_potential
FROM players
WHERE potential > overall_rating
ORDER BY growth_potential DESC;


-------------------------------------------------
-- 3. Average player age by club
-------------------------------------------------
SELECT
    club,
    AVG(age) AS avg_age
FROM players
GROUP BY club
ORDER BY avg_age;


-------------------------------------------------
-- 4. Most valuable players (Value in EUR)
-------------------------------------------------
SELECT
    name,
    club,
    value_eur
FROM players
ORDER BY value_eur DESC;


-------------------------------------------------
-- 5. Total goals scored by each player
-------------------------------------------------
SELECT
    p.name,
    SUM(ps.goals) AS total_goals
FROM player_stats ps
JOIN players p ON ps.player_id = p.player_id
GROUP BY p.name
ORDER BY total_goals DESC;


-------------------------------------------------
-- 6. Total assists by each player
-------------------------------------------------
SELECT
    p.name,
    SUM(ps.assists) AS total_assists
FROM player_stats ps
JOIN players p ON ps.player_id = p.player_id
GROUP BY p.name
ORDER BY total_assists DESC;


-------------------------------------------------
-- 7. Players who scored in more than one match
-------------------------------------------------
SELECT
    p.name,
    COUNT(DISTINCT ps.match_id) AS matches_scored
FROM player_stats ps
JOIN players p ON ps.player_id = p.player_id
WHERE ps.goals > 0
GROUP BY p.name
HAVING COUNT(DISTINCT ps.match_id) > 1;


-------------------------------------------------
-- 8. Match with highest total goals
-------------------------------------------------
SELECT
    match_id,
    home_team,
    away_team,
    (home_score + away_score) AS total_goals
FROM matches
ORDER BY total_goals DESC;


-------------------------------------------------
-- 9. Average goals per match
-------------------------------------------------
SELECT
    AVG(home_score + away_score) AS avg_goals_per_match
FROM matches;


-------------------------------------------------
-- 10. Discipline analysis (cards per player)
-------------------------------------------------
SELECT
    p.name,
    SUM(ps.yellow_cards) AS yellow_cards,
    SUM(ps.red_cards) AS red_cards
FROM player_stats ps
JOIN players p ON ps.player_id = p.player_id
GROUP BY p.name
ORDER BY red_cards DESC, yellow_cards DESC;
