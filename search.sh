curl -XGET "http://localhost:9200/topics/topic/_search?pretty=true" -d '{
   "fields": ["name"],
   "query": {
       "bool": {
            "must": [
                { "text_phrase": { "name.start": "cra" } }
            ],
            "should": [
                { "term": { "users": "stefan" } }
            ],
            "minimum_number_should_match" : 0
       }
   },
   "script_fields": {
      "personalized": {
         "script": "1+1"
      }
   }
}'; echo

