#!/usr/bin/python

from bottle import route, run, request, response, static_file, post
import json
import requests

@route('/')
def root():
    return static_file('search.html', root='.', mimetype='text/html')

@route('/search')
def search():
    r = {
        "fields": [ "name" ],
        "query": {
            "bool": {
                "must": [
                    { "text_phrase": { "name.start": request.query.q } }
                ],
                "should": [
                    { "term": { "users": request.query.user } }
                ],
                "minimum_number_should_match" : 0
            }
        }
    }
    print r
    data = json.dumps(r)
    r = requests.get("http://127.0.0.1:9200/topics/topic/_search?pretty=true", data=data)
    print r.text
    response.content_type = "application/json"
    return r.text

@post('/personalize')
def personalize():
    r = {
        "script" : "ctx._source.users += user",
        "params" : {
            "user" : request.forms.get('user')
        }
    }
    data = json.dumps(r)
    r = requests.post("http://localhost:9200/topics/topic/" + request.forms.get('id') + "/_update", data=data)
    response.content_type = "application/json"
    return r.text

run(host='0.0.0.0', port=8081)
