#!/bin/bash

# Codes for creating the database
# CREATE DATABASE number_guess
# CREATE TABLE users(
# username VARCHAR(22) NOT NULL,
# games_played INT,
# best_game INT)

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# Codes for guessing game
# Setting up the user
echo -e "\nEnter your username:"
read USER
USERNAME=$($PSQL "SELECT username FROM users WHERE username = '$USER'")
if [[ -z $USERNAME ]]
then
  GAMES_PLAYED=0
  BEST_GAME=9999
  INSERT_USERNAME_RESULT=$($PSQL "INSERT INTO users(username) VALUES ('$USER')")
  if [[ $INSERT_USERNAME_RESULT == "INSERT 0 1" ]]
  then
    USERNAME=$($PSQL "SELECT username FROM users WHERE username = '$USER'")
    echo "Welcome, $(echo $USERNAME | sed -E 's/^ *| *$//g')! It looks like this is your first time here."
  fi
else
  GAMES_PLAYED=$($PSQL "SELECT games_played FROM users WHERE username = '$USERNAME'")
  BEST_GAME=$($PSQL "SELECT best_game FROM users WHERE username = '$USERNAME'")
  USERNAME=$($PSQL "SELECT username FROM users WHERE username = '$USER'")
  echo "Welcome back, $(echo $USERNAME | sed -E 's/^ *| *$//g')! You have played $(echo $GAMES_PLAYED | sed -E 's/^ *| *$//g') games, and your best game took $(echo $BEST_GAME | sed -E 's/^ *| *$//g') guesses."
fi

# Preparing information for the game
GAME_NUM=$(( GAMES_PLAYED + 1 ))
SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))
NUMBER_OF_GUESSES=1
echo -e "\nGuess the secret number between 1 and 1000:"

# Setting up the game
GAME() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  # Getting number input
  read NUM_SELECTION

# If input is not a number
  if [[ ! $NUM_SELECTION =~ ^[0-9]+$ ]]
  then
    # Increment NUMBER_OF_GUESSES
    (( NUMBER_OF_GUESSES++ ))
    # Restart game function
    GAME "That is not an integer, guess again:"
  else
    # If the guess is less than the random number
    if [[ $NUM_SELECTION -lt $SECRET_NUMBER ]]
    then
      # Increment NUMBER_OF_GUESSES
      (( NUMBER_OF_GUESSES++ ))
      # Restart game function
      GAME "It's higher than that, guess again:"
    elif [[ $NUM_SELECTION -gt $SECRET_NUMBER ]]
    then
      # Increment NUMBER_OF_GUESSES
      (( NUMBER_OF_GUESSES++ ))
      # Restart game function
      GAME "It's lower than that, guess again:"
    elif [[ $NUM_SELECTION -eq $SECRET_NUMBER ]]
    then
      # Give winning message
      echo "You guessed it in $(echo $NUMBER_OF_GUESSES | sed -E 's/^ *| *$//g') tries. The secret number was $(echo $SECRET_NUMBER | sed -E 's/^ *| *$//g'). Nice job!"
      #Update games_played
      INSERT_GAMES_RESULT=$($PSQL "UPDATE users SET games_played = $GAME_NUM WHERE username = '$USERNAME'")
      if [[ $NUMBER_OF_GUESSES -lt $BEST_GAME ]]
      then
        INSERT_BEST_GAME_RESULT=$($PSQL "UPDATE users SET best_game = $NUMBER_OF_GUESSES WHERE username = '$USERNAME'")
      fi
    fi
  fi
}


GAME
exit
