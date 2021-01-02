#!/bin/bash
clear

echo "Table: ""$tablename"
cat ./Databases/"$dbname"/"$tablename"
echo "======================================================================="

NoOfRecords=`awk -F: 'END {print NR}' ./Databases/"$dbname"/"$tablename"`
counter=3

#check if this table contain data or not
if [ $NoOfRecords == 2 ]
then
    echo "Unfortunately, There are no Data Recorded in this table 😞"
else
   #getting the value of the primary key of the record that the user want to delete 
   while true
   do
     echo "please Enter the primary key of the record you want to delete"
     read PK
      if [[ ! "$PK" =~  ^[1-9][0-9]*$ ]]
      then
        echo "please enter valid number 👊"
      else
        break
      fi
   done

   #looping till find that number of that primary key and delete this record
   while [ $counter -le $NoOfRecords ]
   do
     if  [ $PK -eq `awk -F: 'FNR == '$counter' {print $1}' ./Databases/"$dbname"/"$tablename"` ]
     then
        sed --in-place "/$PK/d" ./Databases/"$dbname"/"$tablename"
        break
     fi
        ((counter=counter+1)) 
   done
   clear
  echo "congratulations, Your Record has been deleted successfully 😀"
fi

echo "========================================================================"

if [ ! $NoOfRecords == 2 ]
then
 #printing the table after the deleting operation
  echo "Your Table After Your deleting operaion become as following"
  cat ./Databases/"$dbname"/"$tablename"

  echo "======================================================================="
  echo "please select your next action from the following actions"
  PS3="Enter Your Choice:~$ "
    select choice in "Delete another Record" "Add New Record" "Update Into Table" "Back" "Back To Main Menu" "Exit the Application" 
    do
       case $REPLY in
        1). ./DeleteFromTable.sh
          ;;
        2). ./InsertIntoTable.sh
          ;;
        3) . ./UpdateRecord.sh 
         ;; 
        4). ./ListSpecificTable.sh yes
          ;;  
        5). ./MainMenu.sh
          ;;
        6) exit
          ;;
        *) echo "Invalid Selection 😱 Please Try again...!"
          ;;
       esac
    done
    
else
 echo "please select your next action from the following actions"
    PS3="Enter Your Choice:~$ "
    select choice in "Add New Record" "Back" "Back To Main Menu" "Exit the Application" 
    do
       case $REPLY in
        1). ./InsertIntoTable.sh
          ;;
        2). ./ListSpecificTable.sh yes
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
