#!/bin/bash
clear

#check if the user has directory to databases or it's the first use of this application
    if ! [ -d ./Databases ]
    then
         mkdir ./Databases
    fi

#Deleting datbase
db=`ls ./Databases | wc -l`

    if [ "$db" == 0 ]
    then
        echo "Unfortunately, There are no databases Recorded 😞"

    else
        echo "Your available Databases are: "
        ls ./Databases | awk '{print NR, "-", $0}'
        echo "==========================================================="
        while true
        do
            echo "please Enter the Database Name of the Database you want to Delete"
            read deletename
               if [[ ! "$deletename" =~  ^[[:alpha:]][[:alnum:]]*$  ]] 
               then
                echo "Error with Naming Format of Database" 
                echo "Must start with letter" 
                echo "Contain no spaces" 
                echo "Only AlphaNumeric is Allowed"

               elif [ -d ./Databases/"$deletename" ]
               then
                   rm -r ./Databases/"$deletename"
                   clear
                   echo "congratulations, Your Database has been Deleted successfully 😀"
                   break
               else
                   echo "The Name you enterd does't match any existing Databse 👊"
               fi
        done
    fi

#check which Action the user need after completing his current operation
echo "==========================================================="
echo "please select your next action from the following actions"
PS3="Enter Your Choice:~$ "
if [ ! "$db" == 0 ]
then
     select choice in "Delete another Database" "Back To Main Menu" "Exit the Application" 
      do
          case $REPLY in
            1). ./DeleteDatabase.sh
                  ;;
            2). ./MainMenu.sh
                  ;;
            3) exit
                  ;;
            *) echo "Invalid Selection 😱 Please Try again...!"
                  ;;
          esac
      done
else
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
fi
            
