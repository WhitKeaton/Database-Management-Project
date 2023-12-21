/*
NBA Stats Database by Victor Marchesi and Keaton Whitaker
Team - 10
CMPS 4123 Database Management with Dr. Lopamudra Roychoudhuri

The purpose of this database is to serve as a resource in which all of the most recognizable and important statistics involved in the NBA can be accessed.
*/

/* Queries Using Single Tables */
-- 1. List All Players with their Positions and Teams
  select ""'Single Query 1';
  SELECT playerName, position, teamID
  FROM player_T;

-- 2. Find All Teams Located in Los Angeles
  select ""'Single Query 2';
  SELECT teamID, teamName
  FROM team_T
  WHERE city = 'Los Angeles';

-- 3. Retrieve Top 10 Players Based on RAPTOR Score
  select ""'Single Query 3';
  SELECT playerID, RAPTOR
  FROM playerStats_T
  ORDER BY RAPTOR DESC
  LIMIT 10;

-- 4. List All Matches with a Final Score Difference of 20 or More
  select ""'Single Query 4';
  SELECT matchID, team1, team2, finalScoreT1, finalScoreT2
  FROM match_T
  WHERE ABS(finalScoreT1 - finalScoreT2) >= 20;

-- 5. Teams with More Than 10 Championships
  select ""'Single Query 5';
  SELECT teamID, championships
  FROM teamStats_T
  WHERE championships > 10;

-- 6. Players Born After 2000:
  select ""'Single Query 6';
  SELECT playerName, DOB
  FROM player_T
  WHERE YEAR(DOB) > 2000;

    /* Queries Using Multiple Tables */
-- 1. Join Players with their Teams
  select ""'Multiple Query 1';
  SELECT player_T.playerName, team_T.teamName
  FROM player_T
  JOIN team_T ON player_T.teamID = team_T.teamID;

-- 2. List Players with their Stats
  select ""'Multiple Query 2';
  SELECT player_T.playerName, playerStats_T.points, playerStats_T.assists, playerStats_T.rebounds
  FROM player_T
  JOIN playerStats_T ON player_T.playerID = playerStats_T.playerID;

-- 3. Teams with Their Win-Loss Record
  select ""'Multiple Query 3';
  SELECT team_T.teamName, teamStats_T.wins, teamStats_T.losses
  FROM team_T
  JOIN teamStats_T ON team_T.teamID = teamStats_T.teamID;

-- 4. Match Details with Team Names:
  select ""'Multiple Query 4';
  SELECT match_T.matchID, t1.teamName AS 'Team 1', t2.teamName AS 'Team 2', match_T.finalScoreT1, match_T.finalScoreT2
  FROM match_T
  JOIN team_T t1 ON match_T.team1 = t1.teamID
  JOIN team_T t2 ON match_T.team2 = t2.teamID;

-- 5. Players and Their Teams with Championships
  select ""'Multiple Query 5';
  SELECT player_T.playerName, team_T.teamName, teamStats_T.championships
  FROM player_T
  JOIN team_T ON player_T.teamID = team_T.teamID
  JOIN teamStats_T ON team_T.teamID = teamStats_T.teamID;

-- 6. List Matches with Winning Teams
  select ""'Multiple Query 6';
  SELECT match_T.matchID, team_T.teamName AS 'Winning Team', match_T.finalScoreT1, match_T.finalScoreT2
  FROM match_T
  JOIN team_T ON (match_T.winner = team_T.teamName);