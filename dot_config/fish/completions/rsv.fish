complete -c rsv -n "__fish_use_subcommand" -l generate -d 'Generate completion scripts for a given type of shell' -r -f -a "bash elvish fish zsh"
complete -c rsv -n "__fish_use_subcommand" -s t -l timeout -r
complete -c rsv -n "__fish_use_subcommand" -s v -l verbose
complete -c rsv -n "__fish_use_subcommand" -s h -l help -d 'Prints help information'
complete -c rsv -n "__fish_use_subcommand" -s V -l version -d 'Prints version information'
complete -c rsv -n "__fish_use_subcommand" -f -a "enable" -d 'Enable a service'
complete -c rsv -n "__fish_use_subcommand" -f -a "disable" -d 'Disable a service'
complete -c rsv -n "__fish_use_subcommand" -f -a "start" -d 'Start a service'
complete -c rsv -n "__fish_use_subcommand" -f -a "stop" -d 'Stop a service'
complete -c rsv -n "__fish_use_subcommand" -f -a "restart" -d 'Restart a service'
complete -c rsv -n "__fish_use_subcommand" -f -a "status" -d 'Get the status of a service'
complete -c rsv -n "__fish_use_subcommand" -f -a "once" -d 'Start if service is not running. Do not restart if it stops'
complete -c rsv -n "__fish_use_subcommand" -f -a "pause" -d 'Send SIGSTOP if the service is running'
complete -c rsv -n "__fish_use_subcommand" -f -a "continue" -d 'Send SIGCONT if the service is running'
complete -c rsv -n "__fish_use_subcommand" -f -a "term" -d 'Send SIGTERM if the service is running'
complete -c rsv -n "__fish_use_subcommand" -f -a "hup" -d 'Send SIGHUP if the service is running'
complete -c rsv -n "__fish_use_subcommand" -f -a "alarm" -d 'Send SIGALARM if the service is running'
complete -c rsv -n "__fish_use_subcommand" -f -a "interrupt" -d 'Send SIGINT if the service is running'
complete -c rsv -n "__fish_use_subcommand" -f -a "kill" -d 'Send SIGKILL if the service is running'
complete -c rsv -n "__fish_use_subcommand" -f -a "list" -d 'List services'
complete -c rsv -n "__fish_use_subcommand" -f -a "help" -d 'Prints this message or the help of the given subcommand(s)'
complete -c rsv -n "__fish_seen_subcommand_from enable" -d 'Specify the service' -r
complete -c rsv -n "__fish_seen_subcommand_from enable" -s t -l timeout -r
complete -c rsv -n "__fish_seen_subcommand_from enable" -s v -l verbose
complete -c rsv -n "__fish_seen_subcommand_from enable" -s h -l help -d 'Prints help information'
complete -c rsv -n "__fish_seen_subcommand_from enable" -s V -l version -d 'Prints version information'
complete -c rsv -n "__fish_seen_subcommand_from disable" -d 'Specify the service' -r
complete -c rsv -n "__fish_seen_subcommand_from disable" -s t -l timeout -r
complete -c rsv -n "__fish_seen_subcommand_from disable" -s v -l verbose
complete -c rsv -n "__fish_seen_subcommand_from disable" -s h -l help -d 'Prints help information'
complete -c rsv -n "__fish_seen_subcommand_from disable" -s V -l version -d 'Prints version information'
complete -c rsv -n "__fish_seen_subcommand_from start" -d 'Specify the service' -r
complete -c rsv -n "__fish_seen_subcommand_from start" -s t -l timeout -r
complete -c rsv -n "__fish_seen_subcommand_from start" -s v -l verbose
complete -c rsv -n "__fish_seen_subcommand_from start" -s h -l help -d 'Prints help information'
complete -c rsv -n "__fish_seen_subcommand_from start" -s V -l version -d 'Prints version information'
complete -c rsv -n "__fish_seen_subcommand_from stop" -d 'Specify the service' -r
complete -c rsv -n "__fish_seen_subcommand_from stop" -s t -l timeout -r
complete -c rsv -n "__fish_seen_subcommand_from stop" -s v -l verbose
complete -c rsv -n "__fish_seen_subcommand_from stop" -s h -l help -d 'Prints help information'
complete -c rsv -n "__fish_seen_subcommand_from stop" -s V -l version -d 'Prints version information'
complete -c rsv -n "__fish_seen_subcommand_from restart" -d 'Specify the service' -r
complete -c rsv -n "__fish_seen_subcommand_from restart" -s t -l timeout -r
complete -c rsv -n "__fish_seen_subcommand_from restart" -s v -l verbose
complete -c rsv -n "__fish_seen_subcommand_from restart" -s h -l help -d 'Prints help information'
complete -c rsv -n "__fish_seen_subcommand_from restart" -s V -l version -d 'Prints version information'
complete -c rsv -n "__fish_seen_subcommand_from status" -d 'Specify the service' -r
complete -c rsv -n "__fish_seen_subcommand_from status" -s t -l timeout -r
complete -c rsv -n "__fish_seen_subcommand_from status" -s v -l verbose
complete -c rsv -n "__fish_seen_subcommand_from status" -s h -l help -d 'Prints help information'
complete -c rsv -n "__fish_seen_subcommand_from status" -s V -l version -d 'Prints version information'
complete -c rsv -n "__fish_seen_subcommand_from once" -d 'Specify the service' -r
complete -c rsv -n "__fish_seen_subcommand_from once" -s t -l timeout -r
complete -c rsv -n "__fish_seen_subcommand_from once" -s v -l verbose
complete -c rsv -n "__fish_seen_subcommand_from once" -s h -l help -d 'Prints help information'
complete -c rsv -n "__fish_seen_subcommand_from once" -s V -l version -d 'Prints version information'
complete -c rsv -n "__fish_seen_subcommand_from pause" -d 'Specify the service' -r
complete -c rsv -n "__fish_seen_subcommand_from pause" -s t -l timeout -r
complete -c rsv -n "__fish_seen_subcommand_from pause" -s v -l verbose
complete -c rsv -n "__fish_seen_subcommand_from pause" -s h -l help -d 'Prints help information'
complete -c rsv -n "__fish_seen_subcommand_from pause" -s V -l version -d 'Prints version information'
complete -c rsv -n "__fish_seen_subcommand_from continue" -d 'Specify the service' -r
complete -c rsv -n "__fish_seen_subcommand_from continue" -s t -l timeout -r
complete -c rsv -n "__fish_seen_subcommand_from continue" -s v -l verbose
complete -c rsv -n "__fish_seen_subcommand_from continue" -s h -l help -d 'Prints help information'
complete -c rsv -n "__fish_seen_subcommand_from continue" -s V -l version -d 'Prints version information'
complete -c rsv -n "__fish_seen_subcommand_from term" -d 'Specify the service' -r
complete -c rsv -n "__fish_seen_subcommand_from term" -s t -l timeout -r
complete -c rsv -n "__fish_seen_subcommand_from term" -s v -l verbose
complete -c rsv -n "__fish_seen_subcommand_from term" -s h -l help -d 'Prints help information'
complete -c rsv -n "__fish_seen_subcommand_from term" -s V -l version -d 'Prints version information'
complete -c rsv -n "__fish_seen_subcommand_from hup" -d 'Specify the service' -r
complete -c rsv -n "__fish_seen_subcommand_from hup" -s t -l timeout -r
complete -c rsv -n "__fish_seen_subcommand_from hup" -s v -l verbose
complete -c rsv -n "__fish_seen_subcommand_from hup" -s h -l help -d 'Prints help information'
complete -c rsv -n "__fish_seen_subcommand_from hup" -s V -l version -d 'Prints version information'
complete -c rsv -n "__fish_seen_subcommand_from alarm" -d 'Specify the service' -r
complete -c rsv -n "__fish_seen_subcommand_from alarm" -s t -l timeout -r
complete -c rsv -n "__fish_seen_subcommand_from alarm" -s v -l verbose
complete -c rsv -n "__fish_seen_subcommand_from alarm" -s h -l help -d 'Prints help information'
complete -c rsv -n "__fish_seen_subcommand_from alarm" -s V -l version -d 'Prints version information'
complete -c rsv -n "__fish_seen_subcommand_from interrupt" -d 'Specify the service' -r
complete -c rsv -n "__fish_seen_subcommand_from interrupt" -s t -l timeout -r
complete -c rsv -n "__fish_seen_subcommand_from interrupt" -s v -l verbose
complete -c rsv -n "__fish_seen_subcommand_from interrupt" -s h -l help -d 'Prints help information'
complete -c rsv -n "__fish_seen_subcommand_from interrupt" -s V -l version -d 'Prints version information'
complete -c rsv -n "__fish_seen_subcommand_from kill" -d 'Specify the service' -r
complete -c rsv -n "__fish_seen_subcommand_from kill" -s t -l timeout -r
complete -c rsv -n "__fish_seen_subcommand_from kill" -s v -l verbose
complete -c rsv -n "__fish_seen_subcommand_from kill" -s h -l help -d 'Prints help information'
complete -c rsv -n "__fish_seen_subcommand_from kill" -s V -l version -d 'Prints version information'
complete -c rsv -n "__fish_seen_subcommand_from list" -s t -l timeout -r
complete -c rsv -n "__fish_seen_subcommand_from list" -s a -l all
complete -c rsv -n "__fish_seen_subcommand_from list" -s a -l all
complete -c rsv -n "__fish_seen_subcommand_from list" -s u -l up
complete -c rsv -n "__fish_seen_subcommand_from list" -l down
complete -c rsv -n "__fish_seen_subcommand_from list" -s e -l enabled
complete -c rsv -n "__fish_seen_subcommand_from list" -s d -l disabled
complete -c rsv -n "__fish_seen_subcommand_from list" -s v -l verbose
complete -c rsv -n "__fish_seen_subcommand_from list" -s h -l help -d 'Prints help information'
complete -c rsv -n "__fish_seen_subcommand_from list" -s V -l version -d 'Prints version information'
complete -c rsv -n "__fish_seen_subcommand_from help" -s h -l help -d 'Prints help information'
complete -c rsv -n "__fish_seen_subcommand_from help" -s V -l version -d 'Prints version information'
