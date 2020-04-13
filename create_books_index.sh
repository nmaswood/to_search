http DELETE localhost:9200/books &> /dev/null
echo "Creating Mapping For Books"
cat books-mapping.json | jq . 
set -x
http PUT localhost:9200/books < books-mapping.json 
