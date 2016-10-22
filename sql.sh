# Jatin Kumar Copyright (C) 2016 - All Rights Reserved. See the LICENSE
# file at the top-level directory of this distribution 
# Author: Jatin Kumar <jatinkr@gmail.com>

#SQL                                                 
#List all Databases                                  #list table, run stored procedure
  exec sp_databases                                    sp_help
  go                                                   go
                                                     
#List all tables                                     #List of stored procedures:
 use DatabaseNameBlahBlahBlah                         use DatabaseNameBlahBlahBlah
 select name from sysobjects where type = 'U'         select name from sysobjects where type = 'P'
 go                                                   go

#Login                                               #For Mac OSX
 sqlcmd -U sa -P root -S localhost                    tsql instead of sqlcmd

#Run an SQL script
 sqlcmd -U username -S server\instance -e -i script.sql

#Select a DB
  use dbname

#Creating a DB
  CREATE DATABASE dbName
  ON (
    NAME = dbName_dat,
    FILENAME = 'D:\path\to\dbName.mdf'
  )
  LOG ON (
    NAME = dbName_log,
    FILENAME = 'D:\path\to\dbName.ldf'
  )

# create 2
  sqlcmd -i C:\path\to\file.sql

# create 3
  CREATE DATABASE MYDB
  GO

#Change column type
 ALTER TABLE your_table ALTER COLUMN your_column varchar(20)

#Change column name
 sp_RENAME 'your_table.old_column', 'new_column', 'COLUMN'

