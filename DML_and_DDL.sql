/*
NBA Stats Database by Victor Marchesi and Keaton Whitaker
Team - 10
CMPS 4123 Database Management with Dr. Lopamudra Roychoudhuri

The purpose of this database is to serve as a resource in which all of the most recognizable and important statistics involved in the NBA can be accessed.
*/

set FOREIGN_KEY_CHECKS = 0;
DROP TABLE team_T;
DROP TABLE teamStats_T;
DROP TABLE player_T;
DROP TABLE match_T;
DROP TABLE playerStats_T;
set FOREIGN_KEY_CHECKS = 1;

-- Team Information Table
CREATE TABLE team_T (
  teamID   INTEGER NOT NULL,
  city     VARCHAR(50) NOT NULL,
  coach    VARCHAR(50),
  owner    VARCHAR(50),
  teamName VARCHAR(30) NOT NULL,
  CONSTRAINT team_PK PRIMARY KEY (teamID)
);

-- Team Stats Table
CREATE TABLE teamStats_T (
  teamStatsID INTEGER NOT NULL, 
  teamID INTEGER, 
  wins INTEGER,
  losses INTEGER,
  championships INTEGER,
  seasons INTEGER,
  playoffAppearances INTEGER,
  CONSTRAINT teamStats_PK PRIMARY KEY (teamStatsID),
  CONSTRAINT teamStats_FK FOREIGN KEY (teamID) REFERENCES team_T(teamID)
);

-- Individual Player Table
CREATE TABLE player_T (
  playerID INTEGER NOT NULL,
  teamID INTEGER,
  playerName VARCHAR(50) NOT NULL,
  jerseyNumber INTEGER,
  position VARCHAR(2),
  DOB DATE,
  CONSTRAINT player_PK PRIMARY KEY (playerID),
  CONSTRAINT player_FK FOREIGN KEY (teamID) REFERENCES team_T(teamID)
);

-- Individual Match Information Table
CREATE TABLE match_T (
  matchID INTEGER NOT NULL AUTO_INCREMENT,
  team1 INTEGER NOT NULL,
  team2 INTEGER NOT NULL,
  finalScoreT1 INTEGER NOT NULL,
  finalScoreT2 INTEGER NOT NULL,
  winner VARCHAR(50) NOT NULL,
  CONSTRAINT match_PK PRIMARY KEY (matchID),
  CONSTRAINT match_team_FK1 FOREIGN KEY (team1) REFERENCES team_T(teamID),
  CONSTRAINT match_team_FK2 FOREIGN KEY (team2) REFERENCES team_T(teamID)
);

-- Individual Player Stats Table
CREATE TABLE playerStats_T (
  playerStatsID INTEGER NOT NULL,
  playerID INTEGER,
  points DECIMAL(3,1),
  assists DECIMAL(3,1),
  rebounds DECIMAL(3,1),
  RAPTOR DECIMAL(3,1) CHECK (RAPTOR >= -9.0 AND RAPTOR <= 19.0),
  CONSTRAINT playerStats_PK PRIMARY KEY (playerStatsID),
  CONSTRAINT playerStats_FK FOREIGN KEY (playerID) REFERENCES player_T(playerID)
);
-- the lowest RAPTOR score I could find was -6.6 and the highest was 13.1,
-- so the CHECK param will cut out inconsistent outliers

-- Populating the 15 teams in the Western Conference in alphabetical order by city
INSERT INTO team_T (teamID, city, coach, owner, teamName)
VALUES 
(1, 'Dallas', 'Jason Kidd', 'Mark Cuban' , 'Mavericks'),
(2, 'Denver', 'Michael Malone', 'E. Stanley Kroenke' , 'Nuggets'),
(3, 'Golden State', 'Steve Kerr', 'Brandon Schneider' , 'Warriors'),
(4, 'Houston', 'Ime Udoka', 'Tilman Fertitta' , 'Rockets'),
(5, 'Los Angeles', 'Tyronn Lue', 'Steve Ballmer' , 'Clippers'),
(6, 'Los Angeles', 'Darvin Ham', 'Jeanie Buss' , 'Lakers'),
(7, 'Memphis', 'Taylor Jenkins', 'Jason Wexler' , 'Grizzlies'),
(8, 'Minnesota', 'Chris Finch', 'Glen Taylor' , 'Timberwolves'),
(9, 'New Orleans', 'Willie Green', 'Gayle Benson' , 'Pelicans'),
(10, 'Oklahoma City', 'Mark Daigneault', 'Clay Bennett' , 'Thunder'),
(11, 'Phoenix', 'Frank Vogel', 'Mat Ishbia' , 'Suns'),
(12, 'Portland', 'Chauncey Billups', 'Jody Allen' , 'Trailblazers'),
(13, 'Sacramento', 'Mike Brown', 'Vivek Ranadive' , 'Kings'),
(14, 'San Antonio', 'Gregg Popovich', 'Peter John Holt' , 'Spurs'),
(15, 'Utah', 'Will Hardy', 'Ryan Smith' , 'Jazz');

-- Populating the 15 teams with their most key players in no particular order
INSERT INTO player_T (playerID, playerName, jerseyNumber, position, teamID, DOB)
VALUES 
(1, 'Luka Doncic', 77, 'SG', 01, '1999-2-28'),
(2, 'Nikola Jokic', 15, 'C', 02, '1995-2-19'),
(3, 'Stephen Curry', 30, 'PG', 03, '1988-3-14'),
(4, 'Alperen Sengun', 28, 'C', 04, '2002-7-25'),
(5, 'Kawhi Leonard', 02, 'SF', 05, '1991-6-29'),
(6, 'Anthony Davis', 03, 'PF', 06, '1993-3-11'),
(7, 'Ja Morant', 12, 'PG', 07, '1999-8-10'),
(8, 'Anthony Edwards', 05, 'SG', 08, '2001-8-5'),
(9, 'Zion Williamson', 01, 'PF', 09, '2000-7-6'),
(10 , 'Shai Gilgeous-Alexander', 02, 'SG', 10, '1998-10-12'),
(11, 'Kevin Durant', 35, 'SG', 11, '1988-9-29'),
(12, 'Malcolm Brogdon', 11, 'SG', 12, '1992-12-11'),
(13, 'DeAaron Fox', 05, 'PG', 13, '1997-12-20'),
(14, 'Victor Wembanyama', 01, 'PF', 14, '2004-1-4'),
(15, 'Lauri Markkanen', 23, 'PF', 15, '1997-5-22');

-- Inserting statistics from the above players
INSERT INTO playerStats_T (playerStatsID, playerID, points, rebounds, assists, RAPTOR)
VALUES 
(1, 1, 31.4, 8.4, 8.4, 7.8),
(2, 2, 29.0, 12.8, 9.8, 13.2),
(3, 3, 29.1, 5.0, 4.7, 6.3),
(4, 4, 21.0, 9.2, 5.5, 1.9),
(5, 5, 21.8, 6.0, 3.4, 6.8),
(6, 6, 23.0, 12.6, 3.1, 7.2),
(7, 7, 22.4, 4.8, 7.4, 5.5),
(8, 8, 26.2, 5.9, 5.0, 2.3),
(9, 9, 22.7, 5.8, 4.9, 0.0),
(10, 10, 29.9, 5.7, 6.3, 5.2),
(11, 11, 31.0, 6.5, 5.7, 5.0),
(12, 12, 18.2, 4.2, 6.4, 4.5),
(13, 13, 30.3, 4.7, 6.4, 2.5),
(14, 14, 19.3, 9.7, 2.6, 0.0),
(15, 15, 23.7, 8.7, 1.1, 4.5);

-- Inserting team statistics data
INSERT INTO teamStats_T (teamStatsID, teamID, wins, losses, championships, seasons, playoffAppearances)
VALUES 
(1, 1, 12, 8, 3, 12, 6),
(2, 2, 14, 7, 5, 15, 10),
(3, 3, 9, 1, 7, 20, 11),
(4, 4, 9, 9, 7, 13, 12),
(5, 5, 9, 10, 4, 9, 7),
(6, 6, 14, 7, 3, 6, 9),
(7, 7, 6, 14, 4, 8, 15),
(8, 8, 16, 4, 13, 17, 19),
(9, 9, 12, 10, 12, 25, 15),
(10, 10, 13, 7, 12, 20, 15),
(11, 11, 12, 9, 7, 15, 11),
(12, 12, 6, 13, 6, 20, 12),
(13, 13, 11, 8, 9, 20, 17),
(14, 14, 3, 14, 12, 21, 27),
(15, 15, 7, 14, 8, 18, 14);

-- creating 5 example matches
INSERT INTO match_T (team1, team2, finalScoreT1, finalScoreT2, winner)
VALUES 
(1, 2, 99, 93, 'Dallas Mavericks'),
(3, 4, 121, 120, 'Houston Rockets'),
(7, 12, 123, 141, 'Portland Trailblazers'),
(11, 15, 111, 145, 'Utah Jazz'),
(5, 1, 75, 74, 'LA Clippers');

-- describes table and attributes
  select ""'Table definition - team_T';
  describe team_T;
  select ""'Table definition - teamStats_T';
  describe teamStats_T;
  select ""'Table definition - match_T';
  describe match_T;
  select ""'Table definition - player_T';
  describe player_T;
  select ""'Table definition - playerStats_T';
  describe playerStats_T;

-- shows the contents of each table
  select ""'Table contents - team_T';
  select * from team_T;
  select ""'Table contents - teamStats_T';
  select * from teamStats_T;
  select ""'Table contents - match_T';
  select * from match_T;
  select ""'Table contents - player_T';
  select * from player_T;
  select ""'Table contents - playerStats_T';
  select * from playerStats_T;