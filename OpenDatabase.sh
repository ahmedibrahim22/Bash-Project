#!/bin/bash
clear

#check if the user has directory to databases or it's the first use of this application
    if ! [ -d ./Databases ]
    then
         mkdir ./Databases
    fi

#Open Specific datbase
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
          if [ "$1" == "yes" ]
          then
            dbname = $dbname
          else
            echo "please Enter the Database Name of the Database you want to open"
            read dbname
          fi  
               #check the name format
               if [[ ! "$dbname" =~  ^[[:alpha:]][[:alnum:]]*$  ]] 
               then
                echo "Error with Naming Format of Database *" 
                echo "Must start with letter" 
                echo "Contain no spaces" 
                echo "Only AlphaNumeric is Allowed"

                #check if this name exist or not
               elif [ ! -d ./Databases/"$dbname" ]
               then
                   echo "The Name you enterd does't match any existing Databse 👊"
               
               else
                     clear
                     echo "you opened the Database you want successfully 😀"
                     break

                fi
        done
    fi

#Operations on Specific datbase
echo "==================================================================================="
echo "Please Enter the choice you want to do in this Database From the Following Choices "

if [ ! "$db" == 0 ]
then
    select choice in "Create New Table" "Delete Specific Table" "List Specific Table" "List All Available Database Tables" "Back To Choose Another DB" "Back To Main Menu" "Exit the Application"
    do
       case $REPLY in
       1) . ./CreateTable.sh
            ;;
       2) . ./DeleteTable.sh
            ;;
       3) . ./ListSpecificTable.sh no
            ;;
       4) . ./ListTables.sh
            ;;
       5) . ./OpenDatabase.sh no  
            ;;
       6) . ./MainMenu.sh  
            ;;
       7)    exit
            ;;
       *)  echo "Invalid Selection 😱 Please Try again...!"
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


