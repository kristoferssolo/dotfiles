function __last_history_item
    echo $history[1]
end

abbr --add !! --position anywhere --function __last_history_item
