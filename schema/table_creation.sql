-- FIFA Analytics Project
-- SQL Server Table Creation Script

CREATE DATABASE FIFAAnalytics;
GO

USE FIFAAnalytics;
GO

-- Players Table
CREATE TABLE players (
    player_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    nationality VARCHAR(50),
    club VARCHAR(100),
    overall_rating INT,
    potential INT,
    position VARCHAR(20),
    value_eur DECIMAL(15,2)
);

-- Matches Table
CREATE TABLE matches (
    match_id INT PRIMARY KEY,
    season VARCHAR(10),
    match_date DATE,
    home_team VARCHAR(50),
    away_team VARCHAR(50),
    home_score INT,
    away_score INT
);

-- Player Stats Table
CREATE TABLE player_stats (
    player_stats_id INT PRIMARY KEY,
    player_id INT,
    match_id INT,
    goals INT,
    assists INT,
    minutes_played INT,
    yellow_cards INT,
    red_cards INT,
    CONSTRAINT fk_player FOREIGN KEY (player_id) REFERENCES players(player_id),
    CONSTRAINT fk_match FOREIGN KEY (match_id) REFERENCES matches(match_id)
);
