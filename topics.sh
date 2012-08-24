
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

