function get_author(){
    echo $1 | sed "s/.*-\(.*\).txt/\1/"
}

function get_book_name(){
    echo $1 | sed "s/books\/\(.*\)-.*\.txt/\1/"
}

for book in books/*; do
    author=`get_author "$book"`
    name=`get_book_name "$book"`
    body_text=`cat "$book" | tr -d '\n' | head -c 200000`
    tmpfile=$(mktemp /tmp/XXXX)

    echo  $( jq -n \
                      --arg name "$name" \
                      --arg author "$author" \
                      --arg body_text "$body_text" \
                  '{name: $name, author: $author, body_text: $body_text}' ) > "$tmpfile"

    http POST localhost:9200/books/books < "$tmpfile" | jq .hits
done
