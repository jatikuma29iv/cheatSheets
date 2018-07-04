# Jatin Kumar Copyright (C) 2016 - All Rights Reserved. See the LICENSE
# file at the top-level directory of this distribution 
# Author: Jatin Kumar <jatinkr@gmail.com>

#SQL                                                 
#List all Databases                 #list table, run stored procedure
  exec sp_databases                   sp_help
  go                                  go
  
#list column details 
select column_name,DATA_TYPE,CHARACTER_MAXIMUM_LENGTH from information_schema.columns where table_name = 'LoggerMaster' order by ordinal_position
or exec sp_columns <tableName>;go
  
#List all Table, Stored Procedure, View or Function
  SELECT schema_Name(schema_id)  as  SchemaName,
    [name],              --  Name of the Table, Stored Procedure or Function
    [type]               --  'V' for Views, 'U' for Table, 'P' for Stored Procedure, 'FN' for function
    FROM sys.objects 
    WHERE [type_desc] IN ( 'USER_TABLE', 'SQL_STORED_PROCEDURE', 'VIEW', 'SQL_SCALAR_FUNCTION')
    AND [name] NOT LIKE 'sp_%'
    AND [name] NOT LIKE 'fn_%'
    ORDER BY 3 DESC,        --  type first
    1 ASC,          --  then schema
    2 ASC           --  then function/table name

#List all tables                                     #List of stored procedures:
 use DatabaseNameBlahBlahBlah                         use DatabaseNameBlahBlahBlah
 select name from sysobjects where type = 'U'         select name from sysobjects where type = 'P'
 go                                                   go

#List SP content
EXEC sp_helptext N'AdventureWorks2012.dbo.uspLogError';  
or
SELECT OBJECT_DEFINITION (OBJECT_ID(N'AdventureWorks2012.dbo.uspLogError'));  

#Login                                               #For Mac OSX
 sqlcmd -U sa -P root -S localhost                    tsql instead of sqlcmd

#Run an SQL script                                           #Run Query and exit
 sqlcmd -U username -S server\instance -e -i script.sql      sqlcmd -S server\instance -Q "cmd" -o "outputfile"

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
 ALTER TABLE your_table   your_column varchar(20)

#Change column name
 sp_RENAME 'your_table.old_column', 'new_column', 'COLUMN'

# installing sql*plus in mac
https://tomeuwork.wordpress.com/2014/05/12/how-to-install-oracle-sqlplus-and-oracle-client-in-mac-os/
