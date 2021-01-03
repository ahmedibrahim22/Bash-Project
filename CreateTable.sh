#!/bin/bash
clear

#function to write the instructions of the naming format
function name_format_check(){
     echo Must start with letter 
     echo Contain no spaces 
     echo Only AlphaNumeric is Allowed
}


while true
do
    while true
    do
     #Entering the name of the new Table with format checking
     echo "please enter the name of your new Table"
     read tablename
     export tablename
          if [[ ! "$tablename" =~  ^[[:alpha:]][[:alnum:]]*$  ]] 
          then
                echo Error with Naming Format of the table name
                #function to write the requird format 
                name_format_check
            else
                  break     
            fi
    done

     #check if this name already exist or not
        if [ -f ./Databases/$dbname/"$tablename" ]
        then
            echo "Unfortunately, This Name Is Already Exist, Try Again With Another Name "
        else
            counter=1
            sepeator=":"

            #determing number of columns
            while true
            do
               echo "Please Enter the Number of coulmns : At least 2 columns"
               read nocoulms
               export nocoulms
                  if [[ ! "$nocoulms" =~  ^[2-9][0-9]*$  ]]
                  then
                        echo "please enter valid number"
                  else
                           break
                  fi
            done

            #name of the primary key
            while true
            do
             #checking of the primary key name format
               echo "please enter the name of your primary key"
               read PKName
               if [[ ! "$PKName" =~  ^[[:alpha:]][[:alnum:]]*$  ]] 
               then
                   echo Error with Naming Format of the Primary key
                   #function to write the requird format 
                   name_format_check
                else
                      break     
               fi
            done
            metadatatypes="Integer"
            metadatanames=$PKName  
                  

            #datatype of the primary key
            #Primary key data type always integer 
 
            #input the data of other columns
            while [ $counter -lt $nocoulms ]
            do
              while true
              do
                  echo "Please Enter the Name of coulmn Number $(( $counter+1 )) "
                  read columnname
                           
                  if [[ ! "$columnname" =~  ^[[:alpha:]][[:alnum:]]*$  ]] 
                  then
                     echo Error in Naming Format of Column name 
                     #function to write the requird format 
                     name_format_check 
                  else
                        break
                  fi  
               done
                 #check if the input column name is exist or not
                 coulmnNameFound=0
                  for var in `echo ${column[@]} $PKName`
                  do
                     if [ $var == $columnname ]
                     then  
                           coulmnNameFound=1
                           break
                     fi                     
                  done

                  if [ $coulmnNameFound == 1 ]
                  then
                     echo "Unfortunately, This name is already exist 😞"
                     continue
                  fi
                      column[$counter]=$columnname;

                  #determine the columns data type
                  echo "Please Determine your column Data Type"
                  while true
                  do
	                  echo "1) Integer"
	                  echo "2) String"
	                  read option
	                     case $option in
	                        1)
		                        columntype="Integer" 
                                 break
		                              ;;
	                        2)
		                        columntype="String" 
                                 break
		                              ;;
	                        *)
		                        echo "Invalid Option"
		                              ;;
	                        esac
                  done
                        metadatatypes=$metadatatypes$sepeator$columntype
                        metadatanames=$metadatanames$sepeator$columnname
                        
                              ((counter=counter+1))
            done
                  touch ./Databases/$dbname/"$tablename"
                  echo $metadatatypes >> ./Databases/$dbname/"$tablename"
                  echo $metadatanames >> ./Databases/$dbname/"$tablename"
                  clear
                  echo "congratulations, Your Table Added successfully 😀"
                  echo "your available tables after your adding operation become as following"
                  ls ./Databases/$dbname | awk '{print NR, "-", $0}'
                  unset column
                   break
        fi
done
#check which Action the user need after completing his current operation
echo "==========================================================="
echo "please select your next action from the following actions"
PS3="Enter Your Choice:~$ "

select choice in "Add another Table" "Back" "Back To Main Menu" "Exit the Application" 
do
   case $REPLY in
    1). ./CreateTable.sh
       ;;
    2). ./OpenDatabase.sh yes
       ;;
    3). ./MainMenu.sh
       ;;
    4) exit
       ;;
    *) echo "Invalid Selection 😱 Please Try again...!"
       ;;
    esac
done