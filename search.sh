curl -XGET "http://localhost:9200/topics/global_topic/_search?pretty=true" -d '{
   "fields": ["name"],
   "query": {
      "text_phrase": { "name.start": "cheesec" }
   }
}'; echo

curl -XGET "http://localhost:9200/topics/user_topic/_search?pretty=true" -d '{
   "fields": ["name"],
   "query": {
       "bool": {
            "must": [
                { "text_phrase": { "name.start": "cheesec" } },
                { "term": { "user": "stefan" } }
            ]
       }
   }
}'; echo
