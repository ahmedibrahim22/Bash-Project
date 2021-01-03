# Nano-DBMS Engine
ITI - Intake 41 - bash script project. 

## Overview
We divided our DBMS Engine into three main levels , Databases level - Tables level - Records level  



## Running the app

This app runs on any linux os. To start the app, simply run the following command inside app directory:

```bash
./MainMenu.sh
```

## Overview about the App

### Where does the the app store its files?

Databases are stored as directories, while tables are stored as files.

The app creates a directory in the user's home path, the directory is called 'Databases'.


Inside that directory there is a directory with the names of the databases

Inside each database directory there are the files that represent the tables.

## Scripts
## Main Menu script
#### (1) MainMenu.sh:
used to atart the application . Mainly to work on the database level then go through tables and records levels

## databases level scripts
#### (1) CreateDatabase.sh:
used to create database

#### (2) DeleteDatabase.sh:
used to delete database

#### (3) ListDatabases.sh:
used to list all available databases

#### (4) OpenDatabase.sh:
used to open a certain database

## Tables level scripts
#### (1) CreateTable.sh:
used to create Table

#### (2) DeleteTable.sh :
used to Remove Table

#### (3) ListTables.sh :
used to list all the available tables in the current database

#### (4) ListSpecificTable.sh :
used to list specific table in the current database

## Records level scripts
#### (1) InsertIntoTable.sh :
Used to insert record into table

#### (2) DeleteFromTable.sh :
Used to delete record from table

#### (3) UpdateRecord.sh :
Used to update specific record from table

## Important Information

we did our best to make our App easy to use so you will find that clearly obvious during your moving from operation to another 

## Authors

Ahmed Ibrahim Mahmoud and Asmaa Abdelnaby Mahmoud


