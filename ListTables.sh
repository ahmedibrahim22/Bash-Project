#!/bin/bash
clear

#List of the available tables
tb=`ls ./Databases/$dbname | wc -l`

if [ "$tb" == 0 ]
then
   echo "Unfortunately, There are no Tables Recorded 😞"

else
   echo "Your available Tables are: "
   ls ./Databases/$dbname | awk '{print NR, "-", $0}'
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
