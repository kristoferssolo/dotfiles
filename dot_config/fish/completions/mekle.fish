# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_mekle_global_optspecs
    string join \n d/depth= v/verbose n/max-results= json 0/null exclude= h/help V/version
end

function __fish_mekle_needs_command
    # Figure out if the current invocation already has a command.
    set -l cmd (commandline -opc)
    set -e cmd[1]
    argparse -s (__fish_mekle_global_optspecs) -- $cmd 2>/dev/null
    or return
    if set -q argv[1]
        # Also print the command, so this can be used to figure out what it is.
        echo $argv[1]
        return 1
    end
    return 0
end

function __fish_mekle_using_subcommand
    set -l cmd (__fish_mekle_needs_command)
    test -z "$cmd"
    and return 1
    contains -- $cmd[1] $argv
end

complete -c mekle -n "__fish_mekle_needs_command" -s d -l depth -d 'Maximum search depth' -r
complete -c mekle -n "__fish_mekle_needs_command" -s n -l max-results -d 'Maximum number of results' -r
complete -c mekle -n "__fish_mekle_needs_command" -l exclude -d 'Exclude entries matching a gitignore-style pattern, relative to each search directory' -r
complete -c mekle -n "__fish_mekle_needs_command" -s v -l verbose -d 'Print search progress'
complete -c mekle -n "__fish_mekle_needs_command" -l json -d 'Print newline-delimited JSON'
complete -c mekle -n "__fish_mekle_needs_command" -s 0 -l null -d 'Print uncontracted paths separated by NUL bytes'
complete -c mekle -n "__fish_mekle_needs_command" -s h -l help -d 'Print help'
complete -c mekle -n "__fish_mekle_needs_command" -s V -l version -d 'Print version'
complete -c mekle -n "__fish_mekle_needs_command" -a "completions" -d 'Generates shell completions'
complete -c mekle -n "__fish_mekle_needs_command" -a "init" -d 'Generates a shell integration that defines `m`'
complete -c mekle -n "__fish_mekle_needs_command" -a "add" -d 'Records a visit to a project directory'
complete -c mekle -n "__fish_mekle_needs_command" -a "pin" -d 'Holds a project above the frecency ranking'
complete -c mekle -n "__fish_mekle_needs_command" -a "unpin" -d 'Returns a project to the frecency ranking'
complete -c mekle -n "__fish_mekle_needs_command" -a "history" -d 'Inspects or changes project history'
complete -c mekle -n "__fish_mekle_needs_command" -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c mekle -n "__fish_mekle_using_subcommand completions" -s h -l help -d 'Print help'
complete -c mekle -n "__fish_mekle_using_subcommand init" -s h -l help -d 'Print help'
complete -c mekle -n "__fish_mekle_using_subcommand add" -s h -l help -d 'Print help'
complete -c mekle -n "__fish_mekle_using_subcommand pin" -s h -l help -d 'Print help'
complete -c mekle -n "__fish_mekle_using_subcommand unpin" -s h -l help -d 'Print help'
complete -c mekle -n "__fish_mekle_using_subcommand history; and not __fish_seen_subcommand_from list show set adjust remove prune clear help" -s h -l help -d 'Print help'
complete -c mekle -n "__fish_mekle_using_subcommand history; and not __fish_seen_subcommand_from list show set adjust remove prune clear help" -f -a "list" -d 'Lists every recorded project'
complete -c mekle -n "__fish_mekle_using_subcommand history; and not __fish_seen_subcommand_from list show set adjust remove prune clear help" -f -a "show" -d 'Shows one recorded project'
complete -c mekle -n "__fish_mekle_using_subcommand history; and not __fish_seen_subcommand_from list show set adjust remove prune clear help" -f -a "set" -d 'Sets a project\'s raw score'
complete -c mekle -n "__fish_mekle_using_subcommand history; and not __fish_seen_subcommand_from list show set adjust remove prune clear help" -f -a "adjust" -d 'Adds a positive or negative amount to a project\'s raw score'
complete -c mekle -n "__fish_mekle_using_subcommand history; and not __fish_seen_subcommand_from list show set adjust remove prune clear help" -f -a "remove" -d 'Removes one project from history'
complete -c mekle -n "__fish_mekle_using_subcommand history; and not __fish_seen_subcommand_from list show set adjust remove prune clear help" -f -a "prune" -d 'Removes projects whose paths no longer exist'
complete -c mekle -n "__fish_mekle_using_subcommand history; and not __fish_seen_subcommand_from list show set adjust remove prune clear help" -f -a "clear" -d 'Removes every project from history'
complete -c mekle -n "__fish_mekle_using_subcommand history; and not __fish_seen_subcommand_from list show set adjust remove prune clear help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c mekle -n "__fish_mekle_using_subcommand history; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c mekle -n "__fish_mekle_using_subcommand history; and __fish_seen_subcommand_from show" -s h -l help -d 'Print help'
complete -c mekle -n "__fish_mekle_using_subcommand history; and __fish_seen_subcommand_from set" -s h -l help -d 'Print help'
complete -c mekle -n "__fish_mekle_using_subcommand history; and __fish_seen_subcommand_from adjust" -s h -l help -d 'Print help'
complete -c mekle -n "__fish_mekle_using_subcommand history; and __fish_seen_subcommand_from remove" -s h -l help -d 'Print help'
complete -c mekle -n "__fish_mekle_using_subcommand history; and __fish_seen_subcommand_from prune" -s h -l help -d 'Print help'
complete -c mekle -n "__fish_mekle_using_subcommand history; and __fish_seen_subcommand_from clear" -s h -l help -d 'Print help'
complete -c mekle -n "__fish_mekle_using_subcommand history; and __fish_seen_subcommand_from help" -f -a "list" -d 'Lists every recorded project'
complete -c mekle -n "__fish_mekle_using_subcommand history; and __fish_seen_subcommand_from help" -f -a "show" -d 'Shows one recorded project'
complete -c mekle -n "__fish_mekle_using_subcommand history; and __fish_seen_subcommand_from help" -f -a "set" -d 'Sets a project\'s raw score'
complete -c mekle -n "__fish_mekle_using_subcommand history; and __fish_seen_subcommand_from help" -f -a "adjust" -d 'Adds a positive or negative amount to a project\'s raw score'
complete -c mekle -n "__fish_mekle_using_subcommand history; and __fish_seen_subcommand_from help" -f -a "remove" -d 'Removes one project from history'
complete -c mekle -n "__fish_mekle_using_subcommand history; and __fish_seen_subcommand_from help" -f -a "prune" -d 'Removes projects whose paths no longer exist'
complete -c mekle -n "__fish_mekle_using_subcommand history; and __fish_seen_subcommand_from help" -f -a "clear" -d 'Removes every project from history'
complete -c mekle -n "__fish_mekle_using_subcommand history; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c mekle -n "__fish_mekle_using_subcommand help; and not __fish_seen_subcommand_from completions init add pin unpin history help" -f -a "completions" -d 'Generates shell completions'
complete -c mekle -n "__fish_mekle_using_subcommand help; and not __fish_seen_subcommand_from completions init add pin unpin history help" -f -a "init" -d 'Generates a shell integration that defines `m`'
complete -c mekle -n "__fish_mekle_using_subcommand help; and not __fish_seen_subcommand_from completions init add pin unpin history help" -f -a "add" -d 'Records a visit to a project directory'
complete -c mekle -n "__fish_mekle_using_subcommand help; and not __fish_seen_subcommand_from completions init add pin unpin history help" -f -a "pin" -d 'Holds a project above the frecency ranking'
complete -c mekle -n "__fish_mekle_using_subcommand help; and not __fish_seen_subcommand_from completions init add pin unpin history help" -f -a "unpin" -d 'Returns a project to the frecency ranking'
complete -c mekle -n "__fish_mekle_using_subcommand help; and not __fish_seen_subcommand_from completions init add pin unpin history help" -f -a "history" -d 'Inspects or changes project history'
complete -c mekle -n "__fish_mekle_using_subcommand help; and not __fish_seen_subcommand_from completions init add pin unpin history help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c mekle -n "__fish_mekle_using_subcommand help; and __fish_seen_subcommand_from history" -f -a "list" -d 'Lists every recorded project'
complete -c mekle -n "__fish_mekle_using_subcommand help; and __fish_seen_subcommand_from history" -f -a "show" -d 'Shows one recorded project'
complete -c mekle -n "__fish_mekle_using_subcommand help; and __fish_seen_subcommand_from history" -f -a "set" -d 'Sets a project\'s raw score'
complete -c mekle -n "__fish_mekle_using_subcommand help; and __fish_seen_subcommand_from history" -f -a "adjust" -d 'Adds a positive or negative amount to a project\'s raw score'
complete -c mekle -n "__fish_mekle_using_subcommand help; and __fish_seen_subcommand_from history" -f -a "remove" -d 'Removes one project from history'
complete -c mekle -n "__fish_mekle_using_subcommand help; and __fish_seen_subcommand_from history" -f -a "prune" -d 'Removes projects whose paths no longer exist'
complete -c mekle -n "__fish_mekle_using_subcommand help; and __fish_seen_subcommand_from history" -f -a "clear" -d 'Removes every project from history'
complete -c mekle -n "__fish_mekle_needs_command" -f
