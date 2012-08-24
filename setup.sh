
curl -XDELETE "http://localhost:9200/topics?pretty=true"; echo

curl -XPOST "http://localhost:9200/topics?pretty=true" -d '{
  "settings": {
    "analysis": {
      "analyzer": {
        "my_start": {
          "tokenizer": "whitespace",
          "filter": ["asciifolding", "lowercase", "my_edge"]
        },
        "my_sort": {
          "tokenizer": "keyword",
          "filter": ["asciifolding", "lowercase"]
        }
      },
      "filter": {
        "my_edge": {
          "type": "edgeNGram",
          "min_gram": 1,
          "max_gram": 10,
          "side": "front"
        }
      }
    }
  },

  "mappings": {
    "global_topic": {
      "properties": {
        "name": {
          "type": "multi_field",
          "fields": {
            "start": { "type": "string", "analyzer": "my_start", "include_in_all": false },
            "sort":  { "type": "string", "analyzer": "my_sort",  "include_in_all": false }
          }
        }
      }
    },
    "user_topic": {
      "properties": {
        "name": {
          "type": "multi_field",
          "fields": {
            "start": { "type": "string", "analyzer": "my_start", "include_in_all": false },
            "sort":  { "type": "string", "analyzer": "my_sort",  "include_in_all": false }
          }
        }
      }
    }
  }
}'; echo

sleep 1

curl -XPUT "http://localhost:9200/topics/global_topic/1?pretty=true" -d '{ "name" : "Cheese" }'; echo
curl -XPUT "http://localhost:9200/topics/global_topic/2?pretty=true" -d '{ "name" : "Cheesecake" }'; echo
curl -XPUT "http://localhost:9200/topics/global_topic/3?pretty=true" -d '{ "name" : "Cheese plate" }'; echo
curl -XPUT "http://localhost:9200/topics/global_topic/4?pretty=true" -d '{ "name" : "Grilled Cheese"}'; echo
curl -XPUT "http://localhost:9200/topics/global_topic/5?pretty=true" -d '{ "name" : "Grilled Cheese Sandwich" }'; echo
curl -XPUT "http://localhost:9200/topics/global_topic/6?pretty=true" -d '{ "name" : "Dutch Cheese" }'; echo
curl -XPUT "http://localhost:9200/topics/global_topic/7?pretty=true" -d '{ "name" : "Cheese & Crackers" }'; echo
curl -XPUT "http://localhost:9200/topics/global_topic/8?pretty=true" -d '{ "name" : "Cheese Factory" }'; echo
curl -XPUT "http://localhost:9200/topics/global_topic/9?pretty=true" -d '{ "name" : "Cheesecake Factory" }'; echo
curl -XPUT "http://localhost:9200/topics/global_topic/10?pretty=true" -d '{ "name" : "French Cheese" }'; echo
curl -XPUT "http://localhost:9200/topics/global_topic/11?pretty=true" -d '{ "name" : "Soft Cheese" }'; echo
curl -XPUT "http://localhost:9200/topics/global_topic/12?pretty=true" -d '{ "name" : "Cheeseballs" }'; echo
curl -XPUT "http://localhost:9200/topics/global_topic/12?pretty=true" -d '{ "name" : "Crazy" }'; echo
curl -XPUT "http://localhost:9200/topics/global_topic/13?pretty=true" -d '{ "name" : "Crazy" }'; echo
curl -XPUT "http://localhost:9200/topics/global_topic/13?pretty=true" -d '{ "name" : "Cranky" }'; echo
curl -XPUT "http://localhost:9200/topics/global_topic/14?pretty=true" -d '{ "name" : "Cheese Crack" }'; echo
curl -XPUT "http://localhost:9200/topics/global_topic/15?pretty=true" -d '{ "name" : "Crack store" }'; echo


curl -XPUT "http://localhost:9200/topics/user_topic/1?pretty=true" -d '{ "user": "stefan", "name" : "Cheesecake" }'; echo
curl -XPUT "http://localhost:9200/topics/user_topic/2?pretty=true" -d '{ "user": "stefan", "name" : "Dutch Cheese" }'; echo
curl -XPUT "http://localhost:9200/topics/user_topic/3?pretty=true" -d '{ "user": "alice", "name" : "Cheesecrab" }'; echo
