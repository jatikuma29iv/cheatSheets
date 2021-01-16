# SQL                                                 

```bash
# Jatin Kumar Copyright (C) 2016 - All Rights Reserved. See the LICENSE
# file at the top-level directory of this distribution 
# Author: Jatin Kumar <jatinkr@gmail.com>
```

## Commands
```bash
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
```

```bash
#List all tables                                     #List of stored procedures:
 use DatabaseNameBlahBlahBlah                         use DatabaseNameBlahBlahBlah
 select name from sysobjects where type = 'U'         select name from sysobjects where type = 'P'
 go                                                   go
 ```

### List SP content

```sql
EXEC sp_helptext N'AdventureWorks2012.dbo.uspLogError';  
or
SELECT OBJECT_DEFINITION (OBJECT_ID(N'AdventureWorks2012.dbo.uspLogError'));  
```


### Select a DB
```sql
  use dbname
```

### Creating a DB
```sql
  CREATE DATABASE dbName
  ON (
    NAME = dbName_dat,
    FILENAME = 'D:\path\to\dbName.mdf'
  )
  LOG ON (
    NAME = dbName_log,
    FILENAME = 'D:\path\to\dbName.ldf'
  )
 ```


### create 2
```sql
  sqlcmd -i C:\path\to\file.sql
```

### create 3
```sql
  CREATE DATABASE MYDB
  GO
```

### Change column type
```sql
 ALTER TABLE your_table   your_column varchar(20)
```

### Change column name
```sql
 sp_RENAME 'your_table.old_column', 'new_column', 'COLUMN'
```

### Create User for Login

```sql
USE Master
GO

ALTER LOGIN dev_user WITH PASSWORD = 'sql@123$'
GO

ALTER LOGIN dev_user WITH
  CHECK_POLICY = OFF,
  CHECK_EXPIRATION = OFF;


ALTER LOGIN dev_user ENABLE


USE master
GO

GRANT ALTER ANY DATABASE TO dev_user
GO
```

## Bash Commands
```bash
### Run an SQL script                                           #Run Query and exit
 sqlcmd -U username -S server\instance -e -i script.sql      sqlcmd -S server\instance -Q "cmd" -o "outputfile"

### Login                                               #For Mac OSX
 sqlcmd -U sa -P root -S localhost                    tsql instead of sqlcmd

### installing sql*plus in mac
https://tomeuwork.wordpress.com/2014/05/12/how-to-install-oracle-sqlplus-and-oracle-client-in-mac-os/
```

## Installations

### MsSql Server Client

#### Mac Osx High Sierra

sqlcmd

```bash
brew untap microsoft mssql-preview
brew tap microsoft/mssql-release https://github.com/Microsoft/homebrew-mssql-release
brew update
brew install mssql-tools
```
