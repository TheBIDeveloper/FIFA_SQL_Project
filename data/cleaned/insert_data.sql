USE FIFAAnalytics;
GO

-- Players
INSERT INTO players VALUES
(1, 'Lionel Messi', 36, 'Argentina', 'Inter Miami', 93, 93, 'RW', 50000000),
(2, 'Cristiano Ronaldo', 38, 'Portugal', 'Al Nassr', 91, 91, 'ST', 45000000),
(3, 'Kylian Mbappe', 25, 'France', 'PSG', 92, 95, 'ST', 180000000),
(4, 'Erling Haaland', 23, 'Norway', 'Manchester City', 91, 95, 'ST', 150000000),
(5, 'Kevin De Bruyne', 32, 'Belgium', 'Manchester City', 91, 91, 'CM', 100000000);

-- Matches
INSERT INTO matches VALUES
(101, '2023/24', '2023-09-15', 'Inter Miami', 'Al Nassr', 2, 1),
(102, '2023/24', '2023-09-16', 'PSG', 'Manchester City', 1, 3),
(103, '2023/24', '2023-09-20', 'Inter Miami', 'PSG', 0, 2),
(104, '2023/24', '2023-09-22', 'Manchester City', 'Al Nassr', 4, 2);

-- Player Stats
INSERT INTO player_stats VALUES
(1, 1, 101, 2, 1, 90, 0, 0),
(2, 2, 101, 1, 0, 90, 1, 0),
(3, 3, 102, 1, 0, 85, 0, 0),
(4, 4, 102, 3, 1, 90, 0, 0),
(5, 5, 102, 0, 2, 90, 1, 0),
(6, 1, 103, 0, 1, 90, 0, 0),
(7, 3, 103, 2, 0, 90, 0, 0),
(8, 4, 104, 2, 1, 90, 0, 0),
(9, 2, 104, 0, 1, 90, 0, 0),
(10, 5, 104, 1, 0, 90, 0, 0);
