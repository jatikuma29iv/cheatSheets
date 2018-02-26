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
