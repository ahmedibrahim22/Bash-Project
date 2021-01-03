#!/bin/bash
clear


#Open Specific Table
tb=`ls ./Databases/$dbname | wc -l`

    if [ "$tb" == 0 ]
    then
        echo "Unfortunately, There are no Tables Recorded 😞"

    else
        echo "Your available Tables are: "
        ls ./Databases/$dbname | awk '{print NR, "-", $0}'
        echo "==========================================================="
        while true
        do
          if [ "$1" == "yes" ]
          then
            tablename = $tablename
          else
            echo "please Enter the Table Name of the Table you want to List "
            read tablename
          fi  
               if [[ ! "$tablename" =~  ^[[:alpha:]][[:alnum:]]*$  ]] 
               then
                echo "Error with Naming Format of Table Name" 
                echo "Must start with letter" 
                echo "Contain no spaces" 
                echo "Only AlphaNumeric is Allowed"

               elif [  -f ./Databases/$dbname/"$tablename" ]
               then
                   clear
                   echo "Table: ""$tablename"
                   cat ./Databases/$dbname/"$tablename"
                   break
               
               else
                     echo "The Name you enterd does't match any existing Databse 👊"

                fi
        done
    fi

#Operations on Specific datbase
echo "==================================================================================="
echo "Please Enter the choice you want to do in this Database From the Following Choices *"
PS3="Enter Your Choice:~$ "
if [ ! "$tb" == 0 ]
then
        select choice in "Insert Into Table" "Delete From Table" "Update Into Table" "Back To Another Table" "Back To Another Database" "Back To Main Menu" "Exit the Application"
        do
        case $REPLY in
        1) . ./InsertIntoTable.sh
                ;;
        2) . ./DeleteFromTable.sh
                ;;
        3) . ./UpdateRecord.sh 
                ;;
        4). ./ListSpecificTable.sh no
                ;;
        5). ./OpenDatabase.sh no
                ;;
        6) . ./MainMenu.sh
                ;;
        7)    exit
                ;;
        *)  echo "Invalid Selection  Please Try again...!"
                ;;
        esac
    done
else
       select choice in "Back" "Back To Choose Another DB" "Back To Main Menu" "Exit the Application" 
      do
          case $REPLY in
            1). ./OpenDatabase.sh yes
                  ;;
            2) . ./OpenDatabase.sh no  
            ;;
            3). ./MainMenu.sh
                  ;;      
            4) exit
                  ;;
            *) echo "Invalid Selection 😱 Please Try again...!"
                  ;;
          esac
      done
fi    

