function query(){
cat << EndOfMessage
{
   "_source": ["name", "author"],
  "query": {
    "simple_query_string" : {
        "query": "\"$@\"",
        "fields": ["body_text"]
    }
  }
}
EndOfMessage
}

tmpfile=$(mktemp /tmp/XXXX)
echo `query $@` >  "$tmpfile"

http GET localhost:9200/books/_search < "$tmpfile" | jq .hits.hits[1]._source
