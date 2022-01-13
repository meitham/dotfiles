# create a tmux pane containing a vim instance editing a jq query file which is applied
# continuously  to stdin
# demo: https://streamable.com/jwdrqu

# this can easily be modified to accomodate any operation, though it is most natural for
# query DSLs: awk, jq, yq, xpath, css


jq-repl () {
  local query_file data_file new_pane_height nodemon_cmd change_aucmd jq_args

  # store input in file
  query_file=$(mktemp)
  data_file=${query_file}.json
  cat /dev/stdin > $data_file
  new_pane_height=5

  # pass args to jq
  jq_args="$@ -C -f $query_file $data_file"
  nodemon_cmd="clear; jq $jq_args | less"

  # inject autocommand into vim, saving file on each edit, triggering nodemon, which
  # runs jq the corresponding jq command
  change_aucmd="au TextChanged,TextChangedI <buffer> write"
  tmux split-window -l$new_pane_height vim -c "$change_aucmd" -c "set ft=jq" $query_file
  nodemon -q -d 0.3 -w $query_file -x "$nodemon_cmd"
}
