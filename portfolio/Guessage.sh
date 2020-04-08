#!/bin/bash
#Student name: Hong Ye  Student ID: 10470951
echo "Welcome to Guess age game"
#introducing the user to this game
typeset -i count=1
#setting a variable count to take note of how many turns it takes for the user to guess the number
((answer = RANDOM % 100 + 1))

#setting a variable answer and make it a random number between 1 to 100
read -p "Guess how old I am: " Guess
#prompting the users to guess a number and storing to variable Guess


until ! [[ -z "$Guess" ]]; do   #creating a until statement, until varible guess is not empty it will continuously prompt user for an input
    echo "No inputs determined."    #notifty the user that there no data inputed
    read -p "Please try again: " Guess  #prompting user for an input and storing into variable Guess
done    

while (("$answer" != "$Guess" )); do    #a while loops that continues to loop if variable answer is not equal to variabe guess

    count=count+1 #setting the count variable to increase by one for each time this loop is executed

        if ! [[ "$Guess" =~ ^[0-9]+$ ]]; then
        #an if statement under the condition if the users had entered inputs that are not integers 
            echo "Invalid input (positive integers only)"
            #providing a message to let the user know that their input was invalid and hinting the correct input format
        elif (($Guess > $answer)); then
        #if the input was in correct format then it compares the users input and the $answer to determine if his/her guess was too big
            echo "Sorry, your guess was too high."
            #providing a message to tell the users that their guess was too high
        elif (($Guess < $answer)); then
        #if the previous condition were not met then it compares the two variable guess and answer, if guess is lower than answer then proceed witht the following script
            echo "Sorry, your guess was too low." #telling the user tha their input was smaller than the answer
        fi  

        read -p "Please try again: " Guess #giving the users another chance to guess the age

        #an until statement where it continuously to loop until the variable guess is not empty. 
        #it tells the user that they havent provided anyinputs
        #prompting the user for a new input and storing it  as the variable Guess
        until ! [[ -z "$Guess" ]]; do
            echo "No inputs determined."
            read -p "Please try again: " Guess
        done
    
done

echo "Bingo, I'm $answer years old and it took you $count entries." #telling the user that they correctly guess the age and information how many entries they taken
echo -e "To play again press 1\nTo end press Enter"  #\n allows to seperate the two phrase into two lines
read -p "" playagain    #prompting for an input to determine whether to continue playing or end the game

#if statement ending the game on the condition if variable playagain is an empty string
# giving out the message thankyou for playing
#exit ending the script
if  [[ -z "$playagain" ]]; then
    echo "Thankyou for playing."
    exit    
elif [ $playagain == 1 ]; then  #if the previous condition is not met then it checks if variable playagain is equal to 1  
    ./Guessage.sh   #is the condition is met then it runs the script Guessage.sh
else #if the two previous conditions didnt succeed then terminate the script
    echo "Thankyou for playing" 
    exit
fi
                                                                                                                                           