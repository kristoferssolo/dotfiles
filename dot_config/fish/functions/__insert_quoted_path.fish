function __insert_quoted_path \
    --description "Insert a path as a shell-safe string" \
    --argument-names completion

    set -l path (
        string unescape --style=script -- "$completion"
    )

    if string match -q -- "$HOME/*" "$path"
        set -l suffix (
            string replace -- "$HOME/" "" "$path"
        )

        set path "~/"(string escape --style=script -- "$suffix")
    else if string match -q -- '~/*' "$path"
        set -l suffix (
            string replace --regex '^~/' '' "$path"
        )

        set path "~/"(string escape --style=script -- "$suffix")
    else
        set path (string escape --style=script -- "$path")
    end

    commandline --current-token --replace -- "$path"
end
