
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
    "topic": {
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

curl -XPUT "http://localhost:9200/topics/topic/1?pretty=true" -d '{ "users": [], "name" : "Cheese" }'; echo
curl -XPUT "http://localhost:9200/topics/topic/2?pretty=true" -d '{ "users": [], "name" : "Cheesecake" }'; echo
curl -XPUT "http://localhost:9200/topics/topic/3?pretty=true" -d '{ "users": [], "name" : "Cheese plate" }'; echo
curl -XPUT "http://localhost:9200/topics/topic/4?pretty=true" -d '{ "users": [], "name" : "Grilled Cheese"}'; echo
curl -XPUT "http://localhost:9200/topics/topic/5?pretty=true" -d '{ "users": [], "name" : "Grilled Cheese Sandwich" }'; echo
curl -XPUT "http://localhost:9200/topics/topic/6?pretty=true" -d '{ "users": [], "name" : "Dutch Cheese" }'; echo
curl -XPUT "http://localhost:9200/topics/topic/7?pretty=true" -d '{ "users": [], "name" : "Cheese & Crackers" }'; echo
curl -XPUT "http://localhost:9200/topics/topic/8?pretty=true" -d '{ "users": [], "name" : "Cheese Factory" }'; echo
curl -XPUT "http://localhost:9200/topics/topic/9?pretty=true" -d '{ "users": [], "name" : "Cheesecake Factory" }'; echo
curl -XPUT "http://localhost:9200/topics/topic/10?pretty=true" -d '{ "users": [], "name" : "French Cheese" }'; echo
curl -XPUT "http://localhost:9200/topics/topic/11?pretty=true" -d '{ "users": [], "name" : "Soft Cheese" }'; echo
curl -XPUT "http://localhost:9200/topics/topic/12?pretty=true" -d '{ "users": [], "name" : "Cheeseballs" }'; echo
curl -XPUT "http://localhost:9200/topics/topic/12?pretty=true" -d '{ "users": [], "name" : "Crazy" }'; echo
curl -XPUT "http://localhost:9200/topics/topic/13?pretty=true" -d '{ "users": [], "name" : "Crazy" }'; echo
curl -XPUT "http://localhost:9200/topics/topic/13?pretty=true" -d '{ "users": [], "name" : "Cranky" }'; echo
curl -XPUT "http://localhost:9200/topics/topic/14?pretty=true" -d '{ "users": [], "name" : "Cheese Crack" }'; echo
curl -XPUT "http://localhost:9200/topics/topic/15?pretty=true" -d '{ "users": [], "name" : "Crack store" }'; echo

