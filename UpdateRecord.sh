#!/bin/bash

clear

tb=`cat ./Databases/$dbname/$tablename | wc -l`
  

if [ "$tb" == 2 ]
then
        echo "Unfortunately, There are no Rows in this table*"

else
    echo "Table: ""$tablename"
    cat ./Databases/$dbname/$tablename


    while true
    do
       echo  "Enter the value of primary key of the row you want to modify"
        read val_prim
        counter=3
        chk=0
     #check if primary key exist
     if [[ "$val_prim" =~  ^[1-9][0-9]*$ ]]
     then
        while [ $counter -le $tb ]
        do
            if  [ $val_prim -eq `awk -F: 'FNR == '$counter' {print $1}' ./Databases/$dbname/$tablename` ]
            then
            chk=1
           break
            fi
            ((counter=counter+1)) 
        done
     fi
record_num=$counter

       if [[ ! "$val_prim" =~  ^[1-9][0-9]*$ ]]
       then
           echo "please enter valid number "
        elif [ $chk == 0 ]
        then
            echo "this primary key not exist" 
        else
            break
        fi
 done

#list all columns to choose
echo "Available columns "
    typeset -i ci=2
    for col in `awk -F: '{i=2; while(i<=NF){if(NR=='$counter'){print $i};i++}}' ./Databases/$dbname/$tablename`
    do
    echo $ci")" $col
    arr[ci]=$ci
    ci=ci+1
    done

    while true
    do
       echo  "Choose Column Need To Update "
        read option

        #check option exist in array
        found=0
        for var in `echo ${arr[@]}`
        do
            if [ "$var" == "$option" ]
            then
                found=1  
            fi
        done

        if [[ ! $option =~  ^[1-9][0-9]*$  ]]
        then
                echo "please enter valid number"
        elif [ $found == 0 ]
        then
            echo "This Option Not Exist . try again"
        else
            break  
        fi
    done

   #get type of option selected 
    type_select=`awk -F: -v i=$option '{if(NR==1){print $i}}' ./Databases/$dbname/$tablename`
    echo "type:"$type_select         
 
   while true
   do  
        echo "enter new value"
        read new

        if [[ $type_select == "String" ]]
        then
        
            if [[ ! "$new" =~  ^[[:alpha:]][[:alnum:]]*$  ]] 
            then
                    echo Error in Naming Format of Column 
                    echo Must start with letter 
                    echo Contain no spaces 
                    echo Only AlphaNumeric is Allowed
            else
                    break
            fi  
        elif [[ $type_select == "Integer" ]]  
        then
    
           if [[ ! $new =~  ^[1-9][0-9]*$  ]]
            then
                    echo "please enter valid number"
            else
                    break
            fi 
        else
           echo "type not exist !!! "        
        fi   
    done
        awk -F : -i inplace -v OFS=: -v ident="$val_prim" -v insert="$new" -v op="$option" '($1==ident){$op=insert} 1' ./Databases/$dbname/$tablename
        echo "congratulations, Your Have Updated Record Successfully "

        echo "new data after update"
        cat ./Databases/$dbname/$tablename
       
fi

#check which Action the user need after completing his current operation
echo "==========================================================="
echo "please select your next action from the following actions"
PS3="Enter Your Choice:~$ "
if [ ! $tb == 2 ]
then
    select choice in "Update Another Record" "Insert Into Table" "Delete From Table" "Back" "Back To Main Menu" "Exit the Application" 
    do
    case $REPLY in
        1) . ./UpdateRecord.sh 
        ;;
        2) . ./InsertIntoTable.sh
        ;;
        3) . ./DeleteFromTable.sh
        ;;
        4). ./ListSpecificTable.sh yes
          ;;  
        5). ./MainMenu.sh
        ;;
        6) exit
        ;;
        *) echo "Invalid Selection * Please Try again...!"
        ;;
        esac
    done 
else
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
