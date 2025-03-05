#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# Note: much of the code included here is adapted from the SQL Student Databases 1 exercise on freeCodeCamp
echo $($PSQL "CREATE TABLE teams(
team_id SERIAL NOT NULL PRIMARY KEY,
name VARCHAR(30) NOT NULL UNIQUE)")
echo $($PSQL "CREATE TABLE games(
game_id SERIAL NOT NULL PRIMARY KEY,
year INT NOT NULL,
round VARCHAR(30) NOT NULL,
winner_id INT NOT NULL,
opponent_id INT NOT NULL,
winner_goals INT NOT NULL,
opponent_goals INT NOT NULL)")
echo $($PSQL "ALTER TABLE games ADD FOREIGN KEY (winner_id) REFERENCES teams(team_id)")
echo $($PSQL "ALTER TABLE games ADD FOREIGN KEY (opponent_id) REFERENCES teams(team_id)")
echo $($PSQL "TRUNCATE teams, games")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  # setting up teams table  
  if [[ $WINNER != "winner" ]]
  then
    # get winner_id
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")

    # if not found
    if [[ -z $WINNER_ID ]]
    then
      # insert team
      INSERT_WINNER_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      if [[ $INSERT_WINNER_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into teams, $WINNER
      fi
      # get new winner_id
      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    fi
  fi
  
  if [[ $OPPONENT != "opponent" ]]
  then
    # get opponent_id
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

    # if not found
    if [[ -z $OPPONENT_ID ]]
    then
      # insert team
      INSERT_OPPONENT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
      if [[ $INSERT_OPPONENT_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into teams, $OPPONENT
      fi
      # get new opponent_id
      OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    fi
  fi

  # Setting up games table
  if [[ YEAR != "year" ]]
  then
    INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals)
     VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
    if [[ $INSERT_GAME_RESULT == "INSERT 0 1" ]]
    then
      echo Inserted into games, $YEAR, $ROUND, $WINNER, $OPPONENT, $WINNER_GOALS, and $OPPONENT_GOALS
    fi
  fi
done