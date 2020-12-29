#!/bin/bash
clear

   #check if the user has directory to databases or it's the first use of this application
    if ! [ -d ./Databases ]
    then
         mkdir ./Databases
    fi

#creating datbase 
while true
do
      while true
      do
     #Entering the name of the new database with format checking
     echo "please enter the name of your new database"
     read dbname
     export dbname
          if [[ ! "$dbname" =~  ^[[:alpha:]][[:alnum:]]*$  ]] 
          then
                echo Error with Naming Format of Database 
                echo Must start with letter 
                echo Contain no spaces 
                echo Only AlphaNumeric is Allowed
            else
                  break     
          fi
      done

     #check if this name already exist or not
          if [ -d ./Databases/"$dbname" ]
          then
                  echo "Unfortunately, This Name Is Already Exist, Try Again With Another Name 👊"
          else
                  mkdir ./Databases/"$dbname"
                  echo "congratulations, Your Database Added successfully 😀"
                    break
          fi
done

#check which Action the user need after completing his current operation
echo "==========================================================="
echo "please select your next action from the following actions"
PS3="Enter Your Choice:~$ "
select choice in "Add another Database" "Back To Main Menu" "Exit the Application" 
do
   case $REPLY in
    1). ./CreateDatabase.sh
       ;;
    2). ./MainMenu.sh
       ;;
    3) exit
       ;;
    *) echo "Invalid Selection 😱 Please Try again...!"
       ;;
    esac
done

