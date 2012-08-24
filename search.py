#!/usr/bin/python


from bottle import route, run, request, response, static_file, post
import json
import requests


@route('/')
def root():
    return static_file('search.html', root='.', mimetype='text/html')


@route('/search')
def search():

    query = {
        "fields": [ "name" ],
        "query": {
            "text_phrase": { "name.start": request.query.q }
        }
    }
    r = requests.get("http://127.0.0.1:9200/topics/global_topic/_search?pretty=true",
                     data=json.dumps(query))
    global_results = json.loads(r.text)

    query = {
        "fields": ["name"],
        "query": {
            "bool": {
               "must": [
                   { "text_phrase": { "name.start": request.query.q } },
                   { "term": { "user": request.query.user } }
               ] 
            }
        }
    }
    r = requests.get("http://127.0.0.1:9200/topics/user_topic/_search?pretty=true",
                     data=json.dumps(query))
    personal_results = json.loads(r.text)

    personal_topics = [hit['fields']['name'] for hit in personal_results['hits']['hits']]

    results = []
    for hit in personal_results['hits']['hits']:
        results.append({ 'id': hit['_id'], 'name': hit['fields']['name'], 'type': 'personal' })
    for hit in global_results['hits']['hits']:
        if hit['fields']['name'] not in personal_topics:
            results.append({ 'id': hit['_id'], 'name': hit['fields']['name'], 'type': 'global' })

    response.content_type = "application/json"
    return json.dumps({'results': results }, sort_keys = False, indent = 4) + "\n"


@post('/personalize')
def personalize():

    document = {
        "name": request.forms.get("name"),
        "user": request.forms.get("user")
    }
    r = requests.post("http://localhost:9200/topics/user_topic/", data=json.dumps(document))

    response.content_type = "application/json"
    return r.text


run(host='0.0.0.0', port=8081)
