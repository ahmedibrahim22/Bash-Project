#!/bin/bash
clear

#check if the user has directory to databases or it's the first use of this application
    if ! [ -d ./Databases ]
    then
         mkdir ./Databases
    fi

#List of the available databases
db=`ls ./Databases | wc -l`

if [ "$db" == 0 ]
then
   echo "Unfortunately, There are no databases Recorded 😞"

else
   echo "Your available Databases are: "
   ls ./Databases | awk '{print NR, "-", $0}'
fi


#check which Action the user need after completing his current operation
echo "==========================================================="
echo "please select your next action from the following actions"
PS3="Enter Your Choice:~$ "
select choice in "Back To Main Menu" "Exit the Application"
do
   case $REPLY in
    1). ./MainMenu.sh
       ;;
    2) exit
       ;;
    *) echo "Invalid Selection 😱 Please Try again...!"
       ;;
    esac
done
