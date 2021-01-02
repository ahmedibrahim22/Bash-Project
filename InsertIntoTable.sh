#!/bin/bash
clear

counter=2
sepeator=":"
NewRecord=""

#adding the primary key values as sequential
PrimaryKey=$(sed '$!d' ./Databases/"$dbname"/"$tablename" | cut -f1 -d:)
expr $PrimaryKey + 0 > /dev/null 2> /dev/null 
id_found=$?
if [ $id_found != 0 ]
then
    PrimaryKey=1
else
    ((PrimaryKey=$PrimaryKey+1))
fi

#adding the value of the record fields
NoOfCloumns=`awk -F: 'END {print NF}' ./Databases/"$dbname"/"$tablename"`
while [ $counter -le $NoOfCloumns ] 
do
    ColumnName=`awk -F: 'FNR == 2 {print $'$counter'}' ./Databases/"$dbname"/"$tablename"`
    echo "enter the value of "$ColumnName 
    read data

    #data type check
    data_type=`awk -F: 'FNR == 1 {print $'$counter'}' ./Databases/"$dbname"/"$tablename"`
      if [ $data_type == Integer ]
      then
          if [[ ! $data =~  ^[0-9][0-9]*$  ]]
          then
           echo "It's Not Integer Value, Please Enter Integer Value 👊"
           continue
           fi
      fi

      if [ $data_type == String ]
      then
          if [[ ! $data =~  ^[[:alpha:]]*$  ]]
          then
           echo "It's Not String Value,Please Enter String Value 👊"
           continue
           fi
      fi

       #To check if it's the last field or not
       if [ $counter -eq $NoOfCloumns ]
       then
           NewRecord=$NewRecord$data
       else
           NewRecord=$NewRecord$data$sepeator
        fi
    ((counter=counter+1))
done
NewRecord=$PrimaryKey$sepeator$NewRecord
echo $NewRecord >> ./Databases/"$dbname"/"$tablename"

clear
echo "congratulations, Your Record has been Added successfully 😀"
echo "==========================================================="

#printing the table after the adding operation
echo "Your Table After Your adding operaion become as following"
cat ./Databases/"$dbname"/"$tablename"

echo "==========================================================="
echo "please select your next action from the following actions"
PS3="Enter Your Choice:~$ "
select choice in "Add another Record" "Delete Record" "Update Into Table" "Back" "Back To Main Menu" "Exit the Application" 
do
   case $REPLY in
    1). ./InsertIntoTable.sh
       ;;
    2). ./DeleteFromTable.sh
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