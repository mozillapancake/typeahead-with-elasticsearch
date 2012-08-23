curl -XPOST 'localhost:9200/test/topic/14/_update' -d '{
    "script" : "ctx._source.users += user",
    "params" : {
        "user" : "stefan"
    }
}'

