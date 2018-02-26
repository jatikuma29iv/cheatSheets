# Elastic Search

## Commands

** Health **
```rest
GET /_cat/health?v
```

** Nodes **
```rest
GET /_cat/nodes?v
```

** List All Indicesedit **

```rest
GET /_cat/indices?v
```

** Index access general syntax **
```xml
<REST Verb> /<Index>/<Type>/<ID>
```

** Create an Indexedit **

```rest
PUT /customer?pretty

GET /_cat/indices?v
```

** Add Data **
```bash
curl -XPUT 'localhost:9200/user/doc/1?pretty&pretty' -H 'Content-Type: application/json' -d'
{
    "name": "John Doe"
}
'
```

** Query data **

```rest
GET /user/doc/1?pretty
```

** [Update data](https://www.elastic.co/guide/en/elasticsearch/reference/current/_updating_documents.html#_updating_documents) **
```rest
POST /customer/doc/1/_update?pretty
{
    "doc": { "name": "Jane Doe", "age": 20 }
}
```

Updates can also be performed by using simple scripts. This example uses a script to increment the age by 5:

```rest
POST /customer/doc/1/_update?pretty
{
    "script" : "ctx._source.age += 5"
}
```


## Kibana

## Commands

```bash
# index a doc
PUT index/type/1
{
    "body": "here"
}

# and get it ...
GET index/type/1
```

# Getting started with Beats and the Elastic Stack

## How Access
### Elasticsearch
    http://localhost:9200/

### Kibana
    http://localhost:5601/

## How to Push Data into Elasticsearch using Logstash

Install logstash to your dev machine and set `hosts => [“localhost:9200”]`

## How to Run Service on Server

### Elasticsearch

Using elasticsearch service file:
```cmd
Elasticsearch-service restart

Elasticsearch-service start

Elasticsearch-service stop
```

Or using windows sc command

```cmd
sc start elasticsearch-service-x64

sc stop elasticsearch-service-x64
```

### Kibana

```cmd
sc start Elasticsearch-Kibana-6.1.1
```

## How To Run on Command Prompt

### Elasticsearch 

```cmd
cd C:\elk\elasticsearch-6.1.1
bin\elasticsearch.bat
```

### Logstash
```cmd
cd C:\elk\logstash-6.1.1
bin\logstash.bat -f logstash.conf
```

### Kibana
```cmd
cd C:\elk\kibana-6.1.1-windows-x86_64
bin\kibana
```

## Download Install Configure

### Elasticsearch
#### Download

Powershell
```powershell
PS> Invoke-WebRequest -Uri `
"https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.1.1.zip" `
-OutFile .\downloads\elasticsearch-6.1.1.zip
```

#### Install

Powershell
```powershell
unzip .\downloads\elasticsearch-6.1.1.zip
```

#### Install as Service
```cmd
C:\elk\elasticsearch-6.1.1\bin\elasticsearch-service.bat

Usage: service.bat install|remove|start|stop|manager [SERVICE_ID]
```

The commands available are:

```
install    Install Elasticsearch as a service
remove     Remove the installed Elasticsearch service (and stop the service if started)
start      Start the Elasticsearch service (if installed)
stop       Stop the Elasticsearch service (if started)
manager    Start a GUI for managing the installed service
```

Run below command to install (make sure `JAVA_HOME` is set correctly)

```cmd
C:\elk\elasticsearch-6.1.1\bin\elasticsearch-service.bat install
Installing service      :  "elasticsearch-service-x64"
Using JAVA_HOME (64-bit):  "c:\jvm\jdk1.8"
The service 'elasticsearch-service-x64' has been installed.
```
#### How do I enable remote access/request in Elasticsearch
In config/elasticsearch.yml put

```yml
        network.host: 0.0.0.0
```

#### Open Firewall
```powershell
New-NetFirewallRule -DisplayName "Elasticsearch (9200-9300)" -Name "Elasticsearch (9200-9300)" -Profile Any -LocalPort 5601 -Protocol TCP
```

#### Other Configurations

https://www.elastic.co/guide/en/beats/libbeat/6.1/elasticsearch-installation.html

Change the JVM options of Elasticsearch before launch it.
go to your config/jvm.options and change the values of
```yml
    -Xms2g ---> to some megabytes (200 MB)
    -Xmx2g ---> to some megabytes (500 MB)
```

here 2g refers to 2GB so change to 200MB it should 200m
For example change it to below value 
```yml
    -Xms200m 
    -Xmx500m
```

### Logstash

#### Download

Powershell
```powershell
PS> Invoke-WebRequest -Uri `
    "https://artifacts.elastic.co/downloads/logstash/logstash-6.1.1.zip" `
    -outfile  .\downloads\logstash-6.1.1.zip
```

#### Install

Powershell
```powershell
    unzip .\downloads\logstash-6.1.1.zip
```

### Kibana

#### Download

Powershell
```powershell
PS> Invoke-WebRequest -uri `
    "https://artifacts.elastic.co/downloads/kibana/kibana-6.1.1-windows-x86_64.zip" `
    -OutFile .\downloads\kibana-6.1.1-windows-x86_64.zip
```

#### Install
Powershell
```powershell
    unzip .\downloads\kibana-6.1.1-windows-x86_64.zip
```

#### Install as Service
```cmd 
sc create "Elasticsearch-Kibana-6.1.1" binPath= "C:\elk\kibana-6.1.1-windows-x86_64\bin\kibana.bat" DisplayName="Elasticsearch-Kibana-6.1.1" start=auto
```
#### How do I enable remote access/request in Kibana
In config/kibana.yml put
```yml
    server.host: "0.0.0.0"
```

#### Open Firewall
```powershell
New-NetFirewallRule -DisplayName "Kibana (5601)" -Name "Kibana (5601)" -Profile Any -LocalPort 5601 -Protocol TCP
```
## Parsing

### Parsing IIS Log
    https://blog.sstorie.com/importing-iis-logs-into-elasticsearch-with-logstash/

### Parsing Json
    [Best way to parse json input?](https://discuss.elastic.co/t/best-way-to-parse-json-input/29809)

## Beats

- A regular Beats setup consists of:
- Elasticsearch for storage and indexing. See [Install Elasticsearch](https://www.elastic.co/guide/en/beats/libbeat/6.1/elasticsearch-installation.html).
- Logstash (optional) for inserting data into Elasticsearch. See [Installing Logstash](https://www.elastic.co/guide/en/beats/libbeat/6.1/logstash-installation.html).
- Kibana for the UI. See [Install Kibana](https://www.elastic.co/guide/en/beats/libbeat/6.1/kibana-installation.html).
- One or more Beats. You install the Beats on your servers to capture operational data. See [Install Beats](https://www.elastic.co/guide/en/beats/libbeat/6.1/installing-beats.html).
- Kibana dashboards for visualizing the data.
