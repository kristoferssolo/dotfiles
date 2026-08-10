Could not find keys file. Creating a new file.
# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_fj_global_optspecs
    string join \n H/host= C/cwd= style= h/help
end

function __fish_fj_needs_command
    # Figure out if the current invocation already has a command.
    set -l cmd (commandline -opc)
    set -e cmd[1]
    argparse -s (__fish_fj_global_optspecs) -- $cmd 2>/dev/null
    or return
    if set -q argv[1]
        # Also print the command, so this can be used to figure out what it is.
        echo $argv[1]
        return 1
    end
    return 0
end

function __fish_fj_using_subcommand
    set -l cmd (__fish_fj_needs_command)
    test -z "$cmd"
    and return 1
    contains -- $cmd[1] $argv
end

complete -c fj -n "__fish_fj_needs_command" -s H -l host -r
complete -c fj -n "__fish_fj_needs_command" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_needs_command" -l style -r -f -a "fancy\t'Use special characters, and colors'
minimal\t'No special characters and no colors. Always used in non-terminal contexts (i.e. pipes)'"
complete -c fj -n "__fish_fj_needs_command" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fj -n "__fish_fj_needs_command" -f -a "repo"
complete -c fj -n "__fish_fj_needs_command" -f -a "issue"
complete -c fj -n "__fish_fj_needs_command" -f -a "pr"
complete -c fj -n "__fish_fj_needs_command" -f -a "wiki"
complete -c fj -n "__fish_fj_needs_command" -f -a "actions"
complete -c fj -n "__fish_fj_needs_command" -f -a "whoami"
complete -c fj -n "__fish_fj_needs_command" -f -a "auth"
complete -c fj -n "__fish_fj_needs_command" -f -a "release"
complete -c fj -n "__fish_fj_needs_command" -f -a "tag"
complete -c fj -n "__fish_fj_needs_command" -f -a "user"
complete -c fj -n "__fish_fj_needs_command" -f -a "org"
complete -c fj -n "__fish_fj_needs_command" -f -a "version"
complete -c fj -n "__fish_fj_needs_command" -f -a "completion"
complete -c fj -n "__fish_fj_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand repo; and not __fish_seen_subcommand_from create fork migrate view readme clone star unstar star-status watch unwatch watch-status delete browse labels edit units help" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand repo; and not __fish_seen_subcommand_from create fork migrate view readme clone star unstar star-status watch unwatch watch-status delete browse labels edit units help" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand repo; and not __fish_seen_subcommand_from create fork migrate view readme clone star unstar star-status watch unwatch watch-status delete browse labels edit units help" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand repo; and not __fish_seen_subcommand_from create fork migrate view readme clone star unstar star-status watch unwatch watch-status delete browse labels edit units help" -f -a "create" -d 'Create a new repository'
complete -c fj -n "__fish_fj_using_subcommand repo; and not __fish_seen_subcommand_from create fork migrate view readme clone star unstar star-status watch unwatch watch-status delete browse labels edit units help" -f -a "fork" -d 'Fork a repository onto your account'
complete -c fj -n "__fish_fj_using_subcommand repo; and not __fish_seen_subcommand_from create fork migrate view readme clone star unstar star-status watch unwatch watch-status delete browse labels edit units help" -f -a "migrate" -d 'Migrate or mirror an existing repository'
complete -c fj -n "__fish_fj_using_subcommand repo; and not __fish_seen_subcommand_from create fork migrate view readme clone star unstar star-status watch unwatch watch-status delete browse labels edit units help" -f -a "view" -d 'View a repo\'s info'
complete -c fj -n "__fish_fj_using_subcommand repo; and not __fish_seen_subcommand_from create fork migrate view readme clone star unstar star-status watch unwatch watch-status delete browse labels edit units help" -f -a "readme" -d 'View a repo\'s README'
complete -c fj -n "__fish_fj_using_subcommand repo; and not __fish_seen_subcommand_from create fork migrate view readme clone star unstar star-status watch unwatch watch-status delete browse labels edit units help" -f -a "clone" -d 'Clone a repo\'s code locally'
complete -c fj -n "__fish_fj_using_subcommand repo; and not __fish_seen_subcommand_from create fork migrate view readme clone star unstar star-status watch unwatch watch-status delete browse labels edit units help" -f -a "star" -d 'Add a star to a repo'
complete -c fj -n "__fish_fj_using_subcommand repo; and not __fish_seen_subcommand_from create fork migrate view readme clone star unstar star-status watch unwatch watch-status delete browse labels edit units help" -f -a "unstar" -d 'Take away a star from a repo'
complete -c fj -n "__fish_fj_using_subcommand repo; and not __fish_seen_subcommand_from create fork migrate view readme clone star unstar star-status watch unwatch watch-status delete browse labels edit units help" -f -a "star-status" -d 'Check your current starring status'
complete -c fj -n "__fish_fj_using_subcommand repo; and not __fish_seen_subcommand_from create fork migrate view readme clone star unstar star-status watch unwatch watch-status delete browse labels edit units help" -f -a "watch" -d 'Subscribe to a repo'
complete -c fj -n "__fish_fj_using_subcommand repo; and not __fish_seen_subcommand_from create fork migrate view readme clone star unstar star-status watch unwatch watch-status delete browse labels edit units help" -f -a "unwatch" -d 'Unsubscribe from a repo'
complete -c fj -n "__fish_fj_using_subcommand repo; and not __fish_seen_subcommand_from create fork migrate view readme clone star unstar star-status watch unwatch watch-status delete browse labels edit units help" -f -a "watch-status" -d 'Check your current watch status'
complete -c fj -n "__fish_fj_using_subcommand repo; and not __fish_seen_subcommand_from create fork migrate view readme clone star unstar star-status watch unwatch watch-status delete browse labels edit units help" -f -a "delete" -d 'Delete a repository'
complete -c fj -n "__fish_fj_using_subcommand repo; and not __fish_seen_subcommand_from create fork migrate view readme clone star unstar star-status watch unwatch watch-status delete browse labels edit units help" -f -a "browse" -d 'Open a repository\'s page in your browser'
complete -c fj -n "__fish_fj_using_subcommand repo; and not __fish_seen_subcommand_from create fork migrate view readme clone star unstar star-status watch unwatch watch-status delete browse labels edit units help" -f -a "labels" -d 'Manage a repo\'s issue labels'
complete -c fj -n "__fish_fj_using_subcommand repo; and not __fish_seen_subcommand_from create fork migrate view readme clone star unstar star-status watch unwatch watch-status delete browse labels edit units help" -f -a "edit" -d 'Edit a repository\'s properties'
complete -c fj -n "__fish_fj_using_subcommand repo; and not __fish_seen_subcommand_from create fork migrate view readme clone star unstar star-status watch unwatch watch-status delete browse labels edit units help" -f -a "units" -d 'Manage a repo\'s units'
complete -c fj -n "__fish_fj_using_subcommand repo; and not __fish_seen_subcommand_from create fork migrate view readme clone star unstar star-status watch unwatch watch-status delete browse labels edit units help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from create" -s d -l description -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from create" -s r -l remote -d 'Creates a new remote with the given name for the new repo' -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from create" -s S -l ssh -d 'Use SSH for the new remote instead of HTTP(S)' -r -f -a "true\t''
false\t''"
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from create" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from create" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from create" -s P -l private
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from create" -s p -l push -d 'Pushes the current branch to the default branch on the new repo'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from create" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from fork" -l name -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from fork" -s R -l remote -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from fork" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from fork" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from fork" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from migrate" -s i -l include -d 'Comma-separated list of items to include. Defaults to nothing but git data' -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from migrate" -s L -l lfs-endpoint -d 'The URL to fetch LFS files from' -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from migrate" -s s -l service -d 'The type of Git service the original repo is on. Defaults to `git`' -r -f -a "git\t''
github\t''
gitlab\t''
forgejo\t''
gitea\t''
gogs\t''
onedev\t''
gitbucket\t''
codebase\t''"
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from migrate" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from migrate" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from migrate" -s m -l mirror -d 'Whether to mirror the repo instead of migrating it'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from migrate" -s p -l private -d 'Whether the new migration should be private'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from migrate" -s t -l token -d 'If enabled, will read an access token in from stdin to use for fetching'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from migrate" -s l -l login -d 'If enabled, will read a username and password from stdin to use for fetching'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from migrate" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from view" -s R -l remote -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from view" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from view" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from view" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from readme" -s R -l remote -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from readme" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from readme" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from readme" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from clone" -s S -l ssh -d 'Clone the repo over SSH instead of HTTP(S)' -r -f -a "true\t''
false\t''"
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from clone" -s I -l identity-file -d 'An SSH key file to use when cloning over SSH' -r -F
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from clone" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from clone" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from clone" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from star" -s R -l remote -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from star" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from star" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from star" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from unstar" -s R -l remote -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from unstar" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from unstar" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from unstar" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from star-status" -s R -l remote -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from star-status" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from star-status" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from star-status" -l list -d 'List all starred repos instead of checking status'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from star-status" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from watch" -s R -l remote -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from watch" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from watch" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from watch" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from unwatch" -s R -l remote -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from unwatch" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from unwatch" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from unwatch" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from watch-status" -s R -l remote -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from watch-status" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from watch-status" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from watch-status" -l list -d 'List all watched repos instead of checking status'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from watch-status" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from delete" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from delete" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from delete" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from browse" -s R -l remote -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from browse" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from browse" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from browse" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from labels" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from labels" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from labels" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from labels" -a "view" -d 'Show a repo\'s labels'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from labels" -a "create" -d 'Create a new label'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from labels" -a "delete" -d 'Delete a label'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from labels" -a "edit" -d 'Edit a label'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from labels" -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from edit" -s a -l archived -d 'Archive or unarchive' -r -f -a "true\t''
false\t''"
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from edit" -l default-branch -d 'Set the default branch' -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from edit" -s d -l description -d 'Set the description' -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from edit" -l enable-prune -d 'Remove obsolete remote-tracking references when mirroring' -r -f -a "true\t''
false\t''"
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from edit" -l mirror-interval -d 'Set the interval for push mirrors. Use a string like 8h30m0s' -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from edit" -l name -d 'Set the repo\'s name' -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from edit" -s p -l private -d 'Set this repository\'s private status' -r -f -a "true\t''
false\t''"
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from edit" -s t -l template -d 'Set if this repository should be a template repository' -r -f -a "true\t''
false\t''"
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from edit" -s w -l website -d 'Set a URL for this repository\'s website' -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from edit" -s a -l avatar -d 'Path of the image to set the repository\'s avatar to' -r -F
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from edit" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from edit" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from edit" -s u -l unset-avatar -d 'Remove the repo\'s currently set avatar'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from edit" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from units" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from units" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from units" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from units" -a "issues" -d 'Manage the issues unit'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from units" -a "prs" -d 'Manage the pull requests unit'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from units" -a "actions" -d 'Manage the actions unit'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from units" -a "wiki" -d 'Manage the wiki unit'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from units" -a "packages" -d 'Manage the packages unit'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from units" -a "projects" -d 'Manage the projects unit'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from units" -a "releases" -d 'Manage the releases unit'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from units" -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from help" -f -a "create" -d 'Create a new repository'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from help" -f -a "fork" -d 'Fork a repository onto your account'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from help" -f -a "migrate" -d 'Migrate or mirror an existing repository'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from help" -f -a "view" -d 'View a repo\'s info'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from help" -f -a "readme" -d 'View a repo\'s README'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from help" -f -a "clone" -d 'Clone a repo\'s code locally'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from help" -f -a "star" -d 'Add a star to a repo'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from help" -f -a "unstar" -d 'Take away a star from a repo'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from help" -f -a "star-status" -d 'Check your current starring status'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from help" -f -a "watch" -d 'Subscribe to a repo'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from help" -f -a "unwatch" -d 'Unsubscribe from a repo'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from help" -f -a "watch-status" -d 'Check your current watch status'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from help" -f -a "delete" -d 'Delete a repository'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from help" -f -a "browse" -d 'Open a repository\'s page in your browser'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from help" -f -a "labels" -d 'Manage a repo\'s issue labels'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from help" -f -a "edit" -d 'Edit a repository\'s properties'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from help" -f -a "units" -d 'Manage a repo\'s units'
complete -c fj -n "__fish_fj_using_subcommand repo; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand issue; and not __fish_seen_subcommand_from create edit comment assign unassign close search view templates browse help" -s R -l remote -d 'The local git remote that points to the repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand issue; and not __fish_seen_subcommand_from create edit comment assign unassign close search view templates browse help" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand issue; and not __fish_seen_subcommand_from create edit comment assign unassign close search view templates browse help" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand issue; and not __fish_seen_subcommand_from create edit comment assign unassign close search view templates browse help" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand issue; and not __fish_seen_subcommand_from create edit comment assign unassign close search view templates browse help" -f -a "create" -d 'Create a new issue on a repo'
complete -c fj -n "__fish_fj_using_subcommand issue; and not __fish_seen_subcommand_from create edit comment assign unassign close search view templates browse help" -f -a "edit" -d 'Edit an issue'
complete -c fj -n "__fish_fj_using_subcommand issue; and not __fish_seen_subcommand_from create edit comment assign unassign close search view templates browse help" -f -a "comment" -d 'Add a comment on an issue'
complete -c fj -n "__fish_fj_using_subcommand issue; and not __fish_seen_subcommand_from create edit comment assign unassign close search view templates browse help" -f -a "assign" -d 'Assign users to an issue'
complete -c fj -n "__fish_fj_using_subcommand issue; and not __fish_seen_subcommand_from create edit comment assign unassign close search view templates browse help" -f -a "unassign" -d 'Unassign users from an issue'
complete -c fj -n "__fish_fj_using_subcommand issue; and not __fish_seen_subcommand_from create edit comment assign unassign close search view templates browse help" -f -a "close" -d 'Close an issue'
complete -c fj -n "__fish_fj_using_subcommand issue; and not __fish_seen_subcommand_from create edit comment assign unassign close search view templates browse help" -f -a "search" -d 'Search for an issue in a repo'
complete -c fj -n "__fish_fj_using_subcommand issue; and not __fish_seen_subcommand_from create edit comment assign unassign close search view templates browse help" -f -a "view" -d 'View an issue\'s info'
complete -c fj -n "__fish_fj_using_subcommand issue; and not __fish_seen_subcommand_from create edit comment assign unassign close search view templates browse help" -f -a "templates" -d 'List the issue templates in a repo'
complete -c fj -n "__fish_fj_using_subcommand issue; and not __fish_seen_subcommand_from create edit comment assign unassign close search view templates browse help" -f -a "browse" -d 'Open an issue in your browser'
complete -c fj -n "__fish_fj_using_subcommand issue; and not __fish_seen_subcommand_from create edit comment assign unassign close search view templates browse help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from create" -l body -d 'The text body of the issue' -r
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from create" -l body-file -d 'The file to read the text body of the issue from' -r -F
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from create" -l template -d 'The template to use when creating an issue' -r
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from create" -s r -l repo -d 'The repo to create this issue on' -r
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from create" -s R -l remote -d 'The local git remote that points to the repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from create" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from create" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from create" -l no-template -d 'Don\'t use a template for this issue'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from create" -l web -d 'Open the issue creation page in your web browser'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from create" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from edit" -s R -l remote -d 'The local git remote that points to the repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from edit" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from edit" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from edit" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from edit" -a "title" -d 'Edit an issue\'s title'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from edit" -a "body" -d 'Edit an issue\'s text content'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from edit" -a "comment" -d 'Edit a comment on an issue'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from edit" -a "labels" -d 'Edit an issue\'s labels'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from edit" -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from comment" -l body-file -d 'The file to read the text content of the comment from' -r -F
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from comment" -s R -l remote -d 'The local git remote that points to the repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from comment" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from comment" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from comment" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from assign" -s R -l remote -d 'The local git remote that points to the repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from assign" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from assign" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from assign" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from unassign" -s R -l remote -d 'The local git remote that points to the repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from unassign" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from unassign" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from unassign" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from close" -s w -l with-msg -d 'A comment to leave on the issue before closing it' -r
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from close" -s R -l remote -d 'The local git remote that points to the repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from close" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from close" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from close" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from search" -s r -l repo -d 'The repo to search in' -r
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from search" -s l -l labels -r
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from search" -s c -l creator -r
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from search" -s a -l assignee -r
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from search" -s s -l state -d 'Filter issues by state. Default: open' -r -f -a "open\t''
closed\t''
all\t''"
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from search" -s R -l remote -d 'The local git remote that points to the repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from search" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from search" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from view" -s R -l remote -d 'The local git remote that points to the repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from view" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from view" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from view" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from view" -a "body" -d 'View an issue\'s title and body. The default'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from view" -a "comment" -d 'View a specific comment'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from view" -a "comments" -d 'List every comment'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from view" -a "assignees" -d 'List the users assigned to this issue'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from view" -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from templates" -s r -l repo -d 'The repo to view the templates of' -r
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from templates" -s R -l remote -d 'The local git remote that points to the repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from templates" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from templates" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from templates" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from browse" -s R -l remote -d 'The local git remote that points to the repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from browse" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from browse" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from browse" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from help" -f -a "create" -d 'Create a new issue on a repo'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from help" -f -a "edit" -d 'Edit an issue'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from help" -f -a "comment" -d 'Add a comment on an issue'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from help" -f -a "assign" -d 'Assign users to an issue'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from help" -f -a "unassign" -d 'Unassign users from an issue'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from help" -f -a "close" -d 'Close an issue'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from help" -f -a "search" -d 'Search for an issue in a repo'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from help" -f -a "view" -d 'View an issue\'s info'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from help" -f -a "templates" -d 'List the issue templates in a repo'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from help" -f -a "browse" -d 'Open an issue in your browser'
complete -c fj -n "__fish_fj_using_subcommand issue; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand pr; and not __fish_seen_subcommand_from search create view status checkout comment assign unassign edit close merge browse review help" -s R -l remote -d 'The local git remote that points to the repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand pr; and not __fish_seen_subcommand_from search create view status checkout comment assign unassign edit close merge browse review help" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand pr; and not __fish_seen_subcommand_from search create view status checkout comment assign unassign edit close merge browse review help" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand pr; and not __fish_seen_subcommand_from search create view status checkout comment assign unassign edit close merge browse review help" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand pr; and not __fish_seen_subcommand_from search create view status checkout comment assign unassign edit close merge browse review help" -f -a "search" -d 'Search a repository\'s pull requests'
complete -c fj -n "__fish_fj_using_subcommand pr; and not __fish_seen_subcommand_from search create view status checkout comment assign unassign edit close merge browse review help" -f -a "create" -d 'Create a new pull request'
complete -c fj -n "__fish_fj_using_subcommand pr; and not __fish_seen_subcommand_from search create view status checkout comment assign unassign edit close merge browse review help" -f -a "view" -d 'View the contents of a pull request'
complete -c fj -n "__fish_fj_using_subcommand pr; and not __fish_seen_subcommand_from search create view status checkout comment assign unassign edit close merge browse review help" -f -a "status" -d 'View the mergability and CI status of a pull request'
complete -c fj -n "__fish_fj_using_subcommand pr; and not __fish_seen_subcommand_from search create view status checkout comment assign unassign edit close merge browse review help" -f -a "checkout" -d 'Checkout a pull request in a new branch'
complete -c fj -n "__fish_fj_using_subcommand pr; and not __fish_seen_subcommand_from search create view status checkout comment assign unassign edit close merge browse review help" -f -a "comment" -d 'Checkout a pull request in a new branch'
complete -c fj -n "__fish_fj_using_subcommand pr; and not __fish_seen_subcommand_from search create view status checkout comment assign unassign edit close merge browse review help" -f -a "assign" -d 'Assign users to a pull request'
complete -c fj -n "__fish_fj_using_subcommand pr; and not __fish_seen_subcommand_from search create view status checkout comment assign unassign edit close merge browse review help" -f -a "unassign" -d 'Unassign users from a pull request'
complete -c fj -n "__fish_fj_using_subcommand pr; and not __fish_seen_subcommand_from search create view status checkout comment assign unassign edit close merge browse review help" -f -a "edit" -d 'Edit the contents of a pull request'
complete -c fj -n "__fish_fj_using_subcommand pr; and not __fish_seen_subcommand_from search create view status checkout comment assign unassign edit close merge browse review help" -f -a "close" -d 'Close a pull request, without merging'
complete -c fj -n "__fish_fj_using_subcommand pr; and not __fish_seen_subcommand_from search create view status checkout comment assign unassign edit close merge browse review help" -f -a "merge" -d 'Merge a pull request'
complete -c fj -n "__fish_fj_using_subcommand pr; and not __fish_seen_subcommand_from search create view status checkout comment assign unassign edit close merge browse review help" -f -a "browse" -d 'Open a pull request in your browser'
complete -c fj -n "__fish_fj_using_subcommand pr; and not __fish_seen_subcommand_from search create view status checkout comment assign unassign edit close merge browse review help" -f -a "review" -d 'Manage reviews on a pull request'
complete -c fj -n "__fish_fj_using_subcommand pr; and not __fish_seen_subcommand_from search create view status checkout comment assign unassign edit close merge browse review help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from search" -s l -l labels -r
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from search" -s c -l creator -r
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from search" -s a -l assignee -r
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from search" -s s -l state -d 'Filter PRs by state. Default: open' -r -f -a "open\t''
closed\t''
all\t''"
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from search" -s r -l repo -d 'The repo to search in' -r
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from search" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from search" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from create" -l base -d 'The branch to merge onto' -r
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from create" -l head -d 'The branch to pull changes from' -r
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from create" -l body -d 'The text body of the pull request' -r
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from create" -l body-file -r -F
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from create" -s r -l repo -d 'The repo to create this pull request on' -r
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from create" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from create" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from create" -s A -l autofill -d 'Automatically populate the PR\'s title and body from its commits'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from create" -s w -l web -d 'Open the PR creation page in your web browser'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from create" -s a -l agit -d 'Open the PR using AGit workflow'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from create" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from view" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from view" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from view" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from view" -a "body" -d 'View the title and body of a pull request'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from view" -a "comment" -d 'View a comment on a pull request'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from view" -a "comments" -d 'View all comments on a pull request'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from view" -a "labels" -d 'View the labels applied to a pull request'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from view" -a "assignees" -d 'List the users assigned to this pull request'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from view" -a "diff" -d 'View the diff between the base and head branches of a pull request'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from view" -a "files" -d 'View the files changed in a pull request'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from view" -a "commits" -d 'View the commits in a pull request'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from view" -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from status" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from status" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from status" -l wait -d 'Wait for all checks to finish before exiting'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from status" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from checkout" -l branch-name -d 'The name to give the newly created branch' -r
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from checkout" -s S -l ssh -d 'Pull the commits using SSH instead of HTTP(S)' -r -f -a "true\t''
false\t''"
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from checkout" -s I -l identity-file -d 'An SSH key file to use when cloning over SSH' -r -F
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from checkout" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from checkout" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from checkout" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from comment" -l body-file -d 'The file to read the text content of the comment from' -r -F
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from comment" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from comment" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from comment" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from assign" -s p -l pr -r
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from assign" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from assign" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from assign" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from unassign" -s p -l pr -r
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from unassign" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from unassign" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from unassign" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from edit" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from edit" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from edit" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from edit" -a "title" -d 'Edit the title'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from edit" -a "body" -d 'Edit the text body'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from edit" -a "comment" -d 'Edit a comment'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from edit" -a "labels" -d 'Edit the applied labels'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from edit" -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from close" -s w -l with-msg -d 'A comment to add before closing' -r
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from close" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from close" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from close" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from merge" -s M -l method -d 'The merge style to use' -r -f -a "merge\t''
rebase\t''
rebase-merge\t''
squash\t''
manual\t''"
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from merge" -s t -l title -d 'The title of the merge or squash commit to be created' -r
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from merge" -s m -l message -d 'The body of the merge or squash commit to be created' -r
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from merge" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from merge" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from merge" -s d -l delete -d 'Option to delete the corresponding branch afterwards'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from merge" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from browse" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from browse" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from browse" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from review" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from review" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from review" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from review" -a "list" -d 'List reviews on a pull request'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from review" -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from help" -f -a "search" -d 'Search a repository\'s pull requests'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from help" -f -a "create" -d 'Create a new pull request'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from help" -f -a "view" -d 'View the contents of a pull request'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from help" -f -a "status" -d 'View the mergability and CI status of a pull request'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from help" -f -a "checkout" -d 'Checkout a pull request in a new branch'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from help" -f -a "comment" -d 'Checkout a pull request in a new branch'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from help" -f -a "assign" -d 'Assign users to a pull request'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from help" -f -a "unassign" -d 'Unassign users from a pull request'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from help" -f -a "edit" -d 'Edit the contents of a pull request'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from help" -f -a "close" -d 'Close a pull request, without merging'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from help" -f -a "merge" -d 'Merge a pull request'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from help" -f -a "browse" -d 'Open a pull request in your browser'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from help" -f -a "review" -d 'Manage reviews on a pull request'
complete -c fj -n "__fish_fj_using_subcommand pr; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand wiki; and not __fish_seen_subcommand_from contents view clone browse help" -s R -l remote -d 'The local git remote that points to the repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand wiki; and not __fish_seen_subcommand_from contents view clone browse help" -s r -l repo -d 'The repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand wiki; and not __fish_seen_subcommand_from contents view clone browse help" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand wiki; and not __fish_seen_subcommand_from contents view clone browse help" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand wiki; and not __fish_seen_subcommand_from contents view clone browse help" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand wiki; and not __fish_seen_subcommand_from contents view clone browse help" -f -a "contents"
complete -c fj -n "__fish_fj_using_subcommand wiki; and not __fish_seen_subcommand_from contents view clone browse help" -f -a "view"
complete -c fj -n "__fish_fj_using_subcommand wiki; and not __fish_seen_subcommand_from contents view clone browse help" -f -a "clone"
complete -c fj -n "__fish_fj_using_subcommand wiki; and not __fish_seen_subcommand_from contents view clone browse help" -f -a "browse"
complete -c fj -n "__fish_fj_using_subcommand wiki; and not __fish_seen_subcommand_from contents view clone browse help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand wiki; and __fish_seen_subcommand_from contents" -s R -l remote -d 'The local git remote that points to the repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand wiki; and __fish_seen_subcommand_from contents" -s r -l repo -d 'The repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand wiki; and __fish_seen_subcommand_from contents" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand wiki; and __fish_seen_subcommand_from contents" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand wiki; and __fish_seen_subcommand_from contents" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand wiki; and __fish_seen_subcommand_from view" -s R -l remote -d 'The local git remote that points to the repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand wiki; and __fish_seen_subcommand_from view" -s r -l repo -d 'The repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand wiki; and __fish_seen_subcommand_from view" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand wiki; and __fish_seen_subcommand_from view" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand wiki; and __fish_seen_subcommand_from view" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand wiki; and __fish_seen_subcommand_from clone" -s p -l path -r -F
complete -c fj -n "__fish_fj_using_subcommand wiki; and __fish_seen_subcommand_from clone" -s S -l ssh -d 'Clone the repo over SSH instead of HTTP(S)' -r -f -a "true\t''
false\t''"
complete -c fj -n "__fish_fj_using_subcommand wiki; and __fish_seen_subcommand_from clone" -s I -l identity-file -d 'An SSH key file to use when cloning over SSH' -r -F
complete -c fj -n "__fish_fj_using_subcommand wiki; and __fish_seen_subcommand_from clone" -s R -l remote -d 'The local git remote that points to the repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand wiki; and __fish_seen_subcommand_from clone" -s r -l repo -d 'The repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand wiki; and __fish_seen_subcommand_from clone" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand wiki; and __fish_seen_subcommand_from clone" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand wiki; and __fish_seen_subcommand_from clone" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand wiki; and __fish_seen_subcommand_from browse" -s R -l remote -d 'The local git remote that points to the repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand wiki; and __fish_seen_subcommand_from browse" -s r -l repo -d 'The repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand wiki; and __fish_seen_subcommand_from browse" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand wiki; and __fish_seen_subcommand_from browse" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand wiki; and __fish_seen_subcommand_from browse" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand wiki; and __fish_seen_subcommand_from help" -f -a "contents"
complete -c fj -n "__fish_fj_using_subcommand wiki; and __fish_seen_subcommand_from help" -f -a "view"
complete -c fj -n "__fish_fj_using_subcommand wiki; and __fish_seen_subcommand_from help" -f -a "clone"
complete -c fj -n "__fish_fj_using_subcommand wiki; and __fish_seen_subcommand_from help" -f -a "browse"
complete -c fj -n "__fish_fj_using_subcommand wiki; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand actions; and not __fish_seen_subcommand_from tasks variables secrets dispatch help" -s R -l remote -d 'The local git remote that points to the repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand actions; and not __fish_seen_subcommand_from tasks variables secrets dispatch help" -s r -l repo -d 'The repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand actions; and not __fish_seen_subcommand_from tasks variables secrets dispatch help" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand actions; and not __fish_seen_subcommand_from tasks variables secrets dispatch help" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand actions; and not __fish_seen_subcommand_from tasks variables secrets dispatch help" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand actions; and not __fish_seen_subcommand_from tasks variables secrets dispatch help" -f -a "tasks" -d 'List the tasks on a repo'
complete -c fj -n "__fish_fj_using_subcommand actions; and not __fish_seen_subcommand_from tasks variables secrets dispatch help" -f -a "variables" -d 'List and manage variables'
complete -c fj -n "__fish_fj_using_subcommand actions; and not __fish_seen_subcommand_from tasks variables secrets dispatch help" -f -a "secrets" -d 'List and manage secrets'
complete -c fj -n "__fish_fj_using_subcommand actions; and not __fish_seen_subcommand_from tasks variables secrets dispatch help" -f -a "dispatch" -d 'Dispatch a workflow'
complete -c fj -n "__fish_fj_using_subcommand actions; and not __fish_seen_subcommand_from tasks variables secrets dispatch help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from tasks" -s p -l page -d 'The page to show. One page always includes up to 20 tasks' -r
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from tasks" -s R -l remote -d 'The local git remote that points to the repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from tasks" -s r -l repo -d 'The repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from tasks" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from tasks" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from tasks" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from variables" -s R -l remote -d 'The local git remote that points to the repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from variables" -s r -l repo -d 'The repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from variables" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from variables" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from variables" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from variables" -f -a "list" -d 'List variables'
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from variables" -f -a "create" -d 'Create a new variable'
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from variables" -f -a "delete" -d 'Delete a variable'
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from variables" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from secrets" -s R -l remote -d 'The local git remote that points to the repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from secrets" -s r -l repo -d 'The repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from secrets" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from secrets" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from secrets" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from secrets" -f -a "list" -d 'List secrets'
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from secrets" -f -a "create" -d 'Create a new actions secret'
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from secrets" -f -a "delete" -d 'Delete an actions secret'
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from secrets" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from dispatch" -s I -l inputs -d 'Values to give as inputs to the run' -r
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from dispatch" -s R -l remote -d 'The local git remote that points to the repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from dispatch" -s r -l repo -d 'The repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from dispatch" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from dispatch" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from dispatch" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from help" -f -a "tasks" -d 'List the tasks on a repo'
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from help" -f -a "variables" -d 'List and manage variables'
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from help" -f -a "secrets" -d 'List and manage secrets'
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from help" -f -a "dispatch" -d 'Dispatch a workflow'
complete -c fj -n "__fish_fj_using_subcommand actions; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand whoami" -s r -l remote -r
complete -c fj -n "__fish_fj_using_subcommand whoami" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand whoami" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand whoami" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand auth; and not __fish_seen_subcommand_from login logout add-token use-ssh list help" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand auth; and not __fish_seen_subcommand_from login logout add-token use-ssh list help" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand auth; and not __fish_seen_subcommand_from login logout add-token use-ssh list help" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand auth; and not __fish_seen_subcommand_from login logout add-token use-ssh list help" -f -a "login" -d 'Log in to an instance'
complete -c fj -n "__fish_fj_using_subcommand auth; and not __fish_seen_subcommand_from login logout add-token use-ssh list help" -f -a "logout" -d 'Deletes login info for an instance'
complete -c fj -n "__fish_fj_using_subcommand auth; and not __fish_seen_subcommand_from login logout add-token use-ssh list help" -f -a "add-token" -d 'Add an application token for an instance'
complete -c fj -n "__fish_fj_using_subcommand auth; and not __fish_seen_subcommand_from login logout add-token use-ssh list help" -f -a "use-ssh" -d 'Enable or disable using SSH by default for certain instances'
complete -c fj -n "__fish_fj_using_subcommand auth; and not __fish_seen_subcommand_from login logout add-token use-ssh list help" -f -a "list" -d 'List all instances you\'re currently logged into'
complete -c fj -n "__fish_fj_using_subcommand auth; and not __fish_seen_subcommand_from login logout add-token use-ssh list help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand auth; and __fish_seen_subcommand_from login" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand auth; and __fish_seen_subcommand_from login" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand auth; and __fish_seen_subcommand_from login" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fj -n "__fish_fj_using_subcommand auth; and __fish_seen_subcommand_from logout" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand auth; and __fish_seen_subcommand_from logout" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand auth; and __fish_seen_subcommand_from add-token" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand auth; and __fish_seen_subcommand_from add-token" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand auth; and __fish_seen_subcommand_from add-token" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fj -n "__fish_fj_using_subcommand auth; and __fish_seen_subcommand_from use-ssh" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand auth; and __fish_seen_subcommand_from use-ssh" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand auth; and __fish_seen_subcommand_from use-ssh" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand auth; and __fish_seen_subcommand_from list" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand auth; and __fish_seen_subcommand_from list" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand auth; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand auth; and __fish_seen_subcommand_from help" -f -a "login" -d 'Log in to an instance'
complete -c fj -n "__fish_fj_using_subcommand auth; and __fish_seen_subcommand_from help" -f -a "logout" -d 'Deletes login info for an instance'
complete -c fj -n "__fish_fj_using_subcommand auth; and __fish_seen_subcommand_from help" -f -a "add-token" -d 'Add an application token for an instance'
complete -c fj -n "__fish_fj_using_subcommand auth; and __fish_seen_subcommand_from help" -f -a "use-ssh" -d 'Enable or disable using SSH by default for certain instances'
complete -c fj -n "__fish_fj_using_subcommand auth; and __fish_seen_subcommand_from help" -f -a "list" -d 'List all instances you\'re currently logged into'
complete -c fj -n "__fish_fj_using_subcommand auth; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand release; and not __fish_seen_subcommand_from create edit delete list view browse asset help" -s R -l remote -r
complete -c fj -n "__fish_fj_using_subcommand release; and not __fish_seen_subcommand_from create edit delete list view browse asset help" -s r -l repo -r
complete -c fj -n "__fish_fj_using_subcommand release; and not __fish_seen_subcommand_from create edit delete list view browse asset help" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand release; and not __fish_seen_subcommand_from create edit delete list view browse asset help" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand release; and not __fish_seen_subcommand_from create edit delete list view browse asset help" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand release; and not __fish_seen_subcommand_from create edit delete list view browse asset help" -f -a "create" -d 'Create a new release'
complete -c fj -n "__fish_fj_using_subcommand release; and not __fish_seen_subcommand_from create edit delete list view browse asset help" -f -a "edit" -d 'Edit a release\'s info'
complete -c fj -n "__fish_fj_using_subcommand release; and not __fish_seen_subcommand_from create edit delete list view browse asset help" -f -a "delete" -d 'Delete a release'
complete -c fj -n "__fish_fj_using_subcommand release; and not __fish_seen_subcommand_from create edit delete list view browse asset help" -f -a "list" -d 'List all the releases on a repo'
complete -c fj -n "__fish_fj_using_subcommand release; and not __fish_seen_subcommand_from create edit delete list view browse asset help" -f -a "view" -d 'View a release\'s info'
complete -c fj -n "__fish_fj_using_subcommand release; and not __fish_seen_subcommand_from create edit delete list view browse asset help" -f -a "browse" -d 'Open a release in your browser'
complete -c fj -n "__fish_fj_using_subcommand release; and not __fish_seen_subcommand_from create edit delete list view browse asset help" -f -a "asset" -d 'Commands on a release\'s attached files'
complete -c fj -n "__fish_fj_using_subcommand release; and not __fish_seen_subcommand_from create edit delete list view browse asset help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from create" -s T -l create-tag -d 'Create a new corresponding tag for this release. Defaults to release\'s name' -r
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from create" -s t -l tag -d 'Pre-existing tag to use' -r
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from create" -s a -l attach -d 'Include a file as an attachment' -r
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from create" -s b -l body -d 'Text of the release body' -r
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from create" -s B -l branch -r
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from create" -s R -l remote -r
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from create" -s r -l repo -r
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from create" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from create" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from create" -s d -l draft
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from create" -s p -l prerelease
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from create" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from edit" -s n -l rename -r
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from edit" -s t -l tag -d 'Corresponding tag for this release' -r
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from edit" -s b -l body -d 'Text of the release body' -r
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from edit" -s d -l draft -r -f -a "true\t''
false\t''"
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from edit" -s p -l prerelease -r -f -a "true\t''
false\t''"
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from edit" -s R -l remote -r
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from edit" -s r -l repo -r
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from edit" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from edit" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from edit" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from delete" -s R -l remote -r
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from delete" -s r -l repo -r
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from delete" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from delete" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from delete" -s t -l by-tag
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from delete" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from list" -s R -l remote -r
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from list" -s r -l repo -r
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from list" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from list" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from list" -s p -l include-prerelease
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from list" -s d -l include-draft
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from view" -s R -l remote -r
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from view" -s r -l repo -r
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from view" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from view" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from view" -s t -l by-tag
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from view" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from browse" -s R -l remote -r
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from browse" -s r -l repo -r
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from browse" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from browse" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from browse" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from asset" -s R -l remote -r
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from asset" -s r -l repo -r
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from asset" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from asset" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from asset" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from asset" -f -a "create" -d 'Create a new attachment on a release'
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from asset" -f -a "delete" -d 'Remove an attachment from a release'
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from asset" -f -a "download" -d 'Download an attached file'
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from asset" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from help" -f -a "create" -d 'Create a new release'
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from help" -f -a "edit" -d 'Edit a release\'s info'
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from help" -f -a "delete" -d 'Delete a release'
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from help" -f -a "list" -d 'List all the releases on a repo'
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from help" -f -a "view" -d 'View a release\'s info'
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from help" -f -a "browse" -d 'Open a release in your browser'
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from help" -f -a "asset" -d 'Commands on a release\'s attached files'
complete -c fj -n "__fish_fj_using_subcommand release; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand tag; and not __fish_seen_subcommand_from create delete list view help" -s R -l remote -d 'The local git remote that points to the repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand tag; and not __fish_seen_subcommand_from create delete list view help" -s r -l repo -d 'The repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand tag; and not __fish_seen_subcommand_from create delete list view help" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand tag; and not __fish_seen_subcommand_from create delete list view help" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand tag; and not __fish_seen_subcommand_from create delete list view help" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand tag; and not __fish_seen_subcommand_from create delete list view help" -f -a "create" -d 'Create a new tag'
complete -c fj -n "__fish_fj_using_subcommand tag; and not __fish_seen_subcommand_from create delete list view help" -f -a "delete" -d 'Delete a tag'
complete -c fj -n "__fish_fj_using_subcommand tag; and not __fish_seen_subcommand_from create delete list view help" -f -a "list" -d 'List all the tags on a repo'
complete -c fj -n "__fish_fj_using_subcommand tag; and not __fish_seen_subcommand_from create delete list view help" -f -a "view" -d 'View a tag\'s info'
complete -c fj -n "__fish_fj_using_subcommand tag; and not __fish_seen_subcommand_from create delete list view help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand tag; and __fish_seen_subcommand_from create" -s b -l body -d 'Text of the tag\'s message' -r
complete -c fj -n "__fish_fj_using_subcommand tag; and __fish_seen_subcommand_from create" -s B -l branch -r
complete -c fj -n "__fish_fj_using_subcommand tag; and __fish_seen_subcommand_from create" -s R -l remote -d 'The local git remote that points to the repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand tag; and __fish_seen_subcommand_from create" -s r -l repo -d 'The repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand tag; and __fish_seen_subcommand_from create" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand tag; and __fish_seen_subcommand_from create" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand tag; and __fish_seen_subcommand_from create" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fj -n "__fish_fj_using_subcommand tag; and __fish_seen_subcommand_from delete" -s R -l remote -d 'The local git remote that points to the repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand tag; and __fish_seen_subcommand_from delete" -s r -l repo -d 'The repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand tag; and __fish_seen_subcommand_from delete" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand tag; and __fish_seen_subcommand_from delete" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand tag; and __fish_seen_subcommand_from delete" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand tag; and __fish_seen_subcommand_from list" -s p -l page -r
complete -c fj -n "__fish_fj_using_subcommand tag; and __fish_seen_subcommand_from list" -s R -l remote -d 'The local git remote that points to the repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand tag; and __fish_seen_subcommand_from list" -s r -l repo -d 'The repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand tag; and __fish_seen_subcommand_from list" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand tag; and __fish_seen_subcommand_from list" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand tag; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand tag; and __fish_seen_subcommand_from view" -s R -l remote -d 'The local git remote that points to the repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand tag; and __fish_seen_subcommand_from view" -s r -l repo -d 'The repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand tag; and __fish_seen_subcommand_from view" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand tag; and __fish_seen_subcommand_from view" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand tag; and __fish_seen_subcommand_from view" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand tag; and __fish_seen_subcommand_from help" -f -a "create" -d 'Create a new tag'
complete -c fj -n "__fish_fj_using_subcommand tag; and __fish_seen_subcommand_from help" -f -a "delete" -d 'Delete a tag'
complete -c fj -n "__fish_fj_using_subcommand tag; and __fish_seen_subcommand_from help" -f -a "list" -d 'List all the tags on a repo'
complete -c fj -n "__fish_fj_using_subcommand tag; and __fish_seen_subcommand_from help" -f -a "view" -d 'View a tag\'s info'
complete -c fj -n "__fish_fj_using_subcommand tag; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand user; and not __fish_seen_subcommand_from search view browse follow unfollow following followers block unblock repos orgs activity edit key gpg help" -s R -l remote -d 'The local git remote that points to the repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand user; and not __fish_seen_subcommand_from search view browse follow unfollow following followers block unblock repos orgs activity edit key gpg help" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand user; and not __fish_seen_subcommand_from search view browse follow unfollow following followers block unblock repos orgs activity edit key gpg help" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand user; and not __fish_seen_subcommand_from search view browse follow unfollow following followers block unblock repos orgs activity edit key gpg help" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand user; and not __fish_seen_subcommand_from search view browse follow unfollow following followers block unblock repos orgs activity edit key gpg help" -f -a "search" -d 'Search for a user by username'
complete -c fj -n "__fish_fj_using_subcommand user; and not __fish_seen_subcommand_from search view browse follow unfollow following followers block unblock repos orgs activity edit key gpg help" -f -a "view" -d 'View a user\'s profile page'
complete -c fj -n "__fish_fj_using_subcommand user; and not __fish_seen_subcommand_from search view browse follow unfollow following followers block unblock repos orgs activity edit key gpg help" -f -a "browse" -d 'Open a user\'s profile page in your browser'
complete -c fj -n "__fish_fj_using_subcommand user; and not __fish_seen_subcommand_from search view browse follow unfollow following followers block unblock repos orgs activity edit key gpg help" -f -a "follow" -d 'Follow a user'
complete -c fj -n "__fish_fj_using_subcommand user; and not __fish_seen_subcommand_from search view browse follow unfollow following followers block unblock repos orgs activity edit key gpg help" -f -a "unfollow" -d 'Unfollow a user'
complete -c fj -n "__fish_fj_using_subcommand user; and not __fish_seen_subcommand_from search view browse follow unfollow following followers block unblock repos orgs activity edit key gpg help" -f -a "following" -d 'List everyone a user\'s follows'
complete -c fj -n "__fish_fj_using_subcommand user; and not __fish_seen_subcommand_from search view browse follow unfollow following followers block unblock repos orgs activity edit key gpg help" -f -a "followers" -d 'List a user\'s followers'
complete -c fj -n "__fish_fj_using_subcommand user; and not __fish_seen_subcommand_from search view browse follow unfollow following followers block unblock repos orgs activity edit key gpg help" -f -a "block" -d 'Block a user'
complete -c fj -n "__fish_fj_using_subcommand user; and not __fish_seen_subcommand_from search view browse follow unfollow following followers block unblock repos orgs activity edit key gpg help" -f -a "unblock" -d 'Unblock a user'
complete -c fj -n "__fish_fj_using_subcommand user; and not __fish_seen_subcommand_from search view browse follow unfollow following followers block unblock repos orgs activity edit key gpg help" -f -a "repos" -d 'List a user\'s repositories'
complete -c fj -n "__fish_fj_using_subcommand user; and not __fish_seen_subcommand_from search view browse follow unfollow following followers block unblock repos orgs activity edit key gpg help" -f -a "orgs" -d 'List the organizations a user is a member of'
complete -c fj -n "__fish_fj_using_subcommand user; and not __fish_seen_subcommand_from search view browse follow unfollow following followers block unblock repos orgs activity edit key gpg help" -f -a "activity" -d 'List a user\'s recent activity'
complete -c fj -n "__fish_fj_using_subcommand user; and not __fish_seen_subcommand_from search view browse follow unfollow following followers block unblock repos orgs activity edit key gpg help" -f -a "edit" -d 'Edit your user settings'
complete -c fj -n "__fish_fj_using_subcommand user; and not __fish_seen_subcommand_from search view browse follow unfollow following followers block unblock repos orgs activity edit key gpg help" -f -a "key" -d 'Manage SSH keys'
complete -c fj -n "__fish_fj_using_subcommand user; and not __fish_seen_subcommand_from search view browse follow unfollow following followers block unblock repos orgs activity edit key gpg help" -f -a "gpg" -d 'Manage GPG keys'
complete -c fj -n "__fish_fj_using_subcommand user; and not __fish_seen_subcommand_from search view browse follow unfollow following followers block unblock repos orgs activity edit key gpg help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from search" -s p -l page -r
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from search" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from search" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from search" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from view" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from view" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from view" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from browse" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from browse" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from browse" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from follow" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from follow" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from follow" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from unfollow" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from unfollow" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from unfollow" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from following" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from following" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from following" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from followers" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from followers" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from followers" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from block" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from block" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from block" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from unblock" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from unblock" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from unblock" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from repos" -l sort -d 'Method by which to sort the list' -r -f -a "name\t''
modified\t''
created\t''
stars\t''
forks\t''"
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from repos" -l page -d 'Page of repos to get' -r
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from repos" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from repos" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from repos" -l starred -d 'List starred repos instead of owned repos'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from repos" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from orgs" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from orgs" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from orgs" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from activity" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from activity" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from activity" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from edit" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from edit" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from edit" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from edit" -f -a "bio" -d 'Set your bio'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from edit" -f -a "name" -d 'Set your full name'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from edit" -f -a "pronouns" -d 'Set your pronouns'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from edit" -f -a "location" -d 'Set your location'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from edit" -f -a "activity" -d 'Set your activity visibility'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from edit" -f -a "email" -d 'Manage the email addresses associated with your account'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from edit" -f -a "website" -d 'Set your linked website'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from edit" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from key" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from key" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from key" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from key" -f -a "list" -d 'List your SSH keys'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from key" -f -a "view" -d 'View an SSH key'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from key" -f -a "delete" -d 'Delete an SSH key'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from key" -f -a "upload" -d 'Upload an SSH key'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from key" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from gpg" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from gpg" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from gpg" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from gpg" -f -a "list" -d 'List your GPG keys'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from gpg" -f -a "view" -d 'View a GPG key'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from gpg" -f -a "delete" -d 'Delete a GPG key. This will un-verify all commits signed with that key!'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from gpg" -f -a "upload" -d 'Upload a GPG key'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from gpg" -f -a "verify" -d 'Verifies a GPG key'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from gpg" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from help" -f -a "search" -d 'Search for a user by username'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from help" -f -a "view" -d 'View a user\'s profile page'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from help" -f -a "browse" -d 'Open a user\'s profile page in your browser'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from help" -f -a "follow" -d 'Follow a user'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from help" -f -a "unfollow" -d 'Unfollow a user'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from help" -f -a "following" -d 'List everyone a user\'s follows'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from help" -f -a "followers" -d 'List a user\'s followers'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from help" -f -a "block" -d 'Block a user'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from help" -f -a "unblock" -d 'Unblock a user'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from help" -f -a "repos" -d 'List a user\'s repositories'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from help" -f -a "orgs" -d 'List the organizations a user is a member of'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from help" -f -a "activity" -d 'List a user\'s recent activity'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from help" -f -a "edit" -d 'Edit your user settings'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from help" -f -a "key" -d 'Manage SSH keys'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from help" -f -a "gpg" -d 'Manage GPG keys'
complete -c fj -n "__fish_fj_using_subcommand user; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand org; and not __fish_seen_subcommand_from list view create edit activity members visibility team label repo help" -s R -l remote -d 'The local git remote that points to the repo to operate on' -r
complete -c fj -n "__fish_fj_using_subcommand org; and not __fish_seen_subcommand_from list view create edit activity members visibility team label repo help" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand org; and not __fish_seen_subcommand_from list view create edit activity members visibility team label repo help" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand org; and not __fish_seen_subcommand_from list view create edit activity members visibility team label repo help" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand org; and not __fish_seen_subcommand_from list view create edit activity members visibility team label repo help" -f -a "list" -d 'List all organizations'
complete -c fj -n "__fish_fj_using_subcommand org; and not __fish_seen_subcommand_from list view create edit activity members visibility team label repo help" -f -a "view" -d 'View info about an organization'
complete -c fj -n "__fish_fj_using_subcommand org; and not __fish_seen_subcommand_from list view create edit activity members visibility team label repo help" -f -a "create" -d 'Create a new organization'
complete -c fj -n "__fish_fj_using_subcommand org; and not __fish_seen_subcommand_from list view create edit activity members visibility team label repo help" -f -a "edit" -d 'Edit an organization\'s information'
complete -c fj -n "__fish_fj_using_subcommand org; and not __fish_seen_subcommand_from list view create edit activity members visibility team label repo help" -f -a "activity" -d 'Edit an organization\'s information'
complete -c fj -n "__fish_fj_using_subcommand org; and not __fish_seen_subcommand_from list view create edit activity members visibility team label repo help" -f -a "members" -d 'List the members of an organization'
complete -c fj -n "__fish_fj_using_subcommand org; and not __fish_seen_subcommand_from list view create edit activity members visibility team label repo help" -f -a "visibility" -d 'View and change the visibility of your membership in an organization'
complete -c fj -n "__fish_fj_using_subcommand org; and not __fish_seen_subcommand_from list view create edit activity members visibility team label repo help" -f -a "team"
complete -c fj -n "__fish_fj_using_subcommand org; and not __fish_seen_subcommand_from list view create edit activity members visibility team label repo help" -f -a "label"
complete -c fj -n "__fish_fj_using_subcommand org; and not __fish_seen_subcommand_from list view create edit activity members visibility team label repo help" -f -a "repo"
complete -c fj -n "__fish_fj_using_subcommand org; and not __fish_seen_subcommand_from list view create edit activity members visibility team label repo help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from list" -s p -l page -d 'Which page of the results to view' -r
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from list" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from list" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from list" -s o -l only-member-of -d 'Only list organizations you are a member of'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from view" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from view" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from view" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from create" -s f -l full-name -d 'The display name for the organization' -r
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from create" -s d -l description -d 'The organization\'s description' -r
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from create" -s e -l email -d 'Contact email for the organization' -r
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from create" -s l -l location -d 'The organizations\'s location' -r
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from create" -s w -l website -d 'The organization\'s website' -r
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from create" -s v -l visibility -d 'The visibility of the organization' -r -f -a "private\t''
limited\t''
public\t''"
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from create" -s a -l admin-can-change-team-access -d 'Whether the admin of a repo can change org teams\' access to it' -r -f -a "true\t''
false\t''"
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from create" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from create" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from create" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from edit" -s f -l full-name -d 'The display name for the organization' -r
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from edit" -s d -l description -d 'The organization\'s description' -r
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from edit" -s e -l email -d 'Contact email for the organization' -r
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from edit" -s l -l location -d 'The organizations\'s location' -r
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from edit" -s w -l website -d 'The organization\'s website' -r
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from edit" -s v -l visibility -d 'The visibility of the organization' -r -f -a "private\t''
limited\t''
public\t''"
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from edit" -s a -l admin-can-change-team-access -d 'Whether the admin of a repo can change org teams\' access to it' -r -f -a "true\t''
false\t''"
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from edit" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from edit" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from edit" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from activity" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from activity" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from activity" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from members" -s p -l page -d 'Which page of the results to view' -r
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from members" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from members" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from members" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from visibility" -s s -l set -d 'Set a new visibility for yourself' -r -f -a "private\t''
public\t''"
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from visibility" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from visibility" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from visibility" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from team" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from team" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from team" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from team" -f -a "list" -d 'View all the teams in an organization'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from team" -f -a "view" -d 'View info about a single team'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from team" -f -a "create" -d 'Create a new team'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from team" -f -a "edit" -d 'Edit a team\'s information and permissions'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from team" -f -a "delete" -d 'Delete a team from an organization'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from team" -f -a "repo"
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from team" -f -a "member"
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from team" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from label" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from label" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from label" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from label" -f -a "list" -d 'List all the issue labels an organization uses'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from label" -f -a "add" -d 'Add a new issue label to an organization'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from label" -f -a "edit" -d 'Edit an issue label an organization uses'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from label" -f -a "rm" -d 'Remove an issue label from an organization'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from label" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from repo" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from repo" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from repo" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from repo" -f -a "list" -d 'List all the repos owned by this organization'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from repo" -f -a "create" -d 'Create a new repository in this organization'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from repo" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from help" -f -a "list" -d 'List all organizations'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from help" -f -a "view" -d 'View info about an organization'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from help" -f -a "create" -d 'Create a new organization'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from help" -f -a "edit" -d 'Edit an organization\'s information'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from help" -f -a "activity" -d 'Edit an organization\'s information'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from help" -f -a "members" -d 'List the members of an organization'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from help" -f -a "visibility" -d 'View and change the visibility of your membership in an organization'
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from help" -f -a "team"
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from help" -f -a "label"
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from help" -f -a "repo"
complete -c fj -n "__fish_fj_using_subcommand org; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand version" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand version" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand version" -l check -d 'Checks for updates'
complete -c fj -n "__fish_fj_using_subcommand version" -s v -l verbose
complete -c fj -n "__fish_fj_using_subcommand version" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand completion" -l bin-name -r
complete -c fj -n "__fish_fj_using_subcommand completion" -s H -l host -r
complete -c fj -n "__fish_fj_using_subcommand completion" -s C -l cwd -d 'Sets the working directory to <CWD>' -r -F
complete -c fj -n "__fish_fj_using_subcommand completion" -s h -l help -d 'Print help'
complete -c fj -n "__fish_fj_using_subcommand help; and not __fish_seen_subcommand_from repo issue pr wiki actions whoami auth release tag user org version completion help" -f -a "repo"
complete -c fj -n "__fish_fj_using_subcommand help; and not __fish_seen_subcommand_from repo issue pr wiki actions whoami auth release tag user org version completion help" -f -a "issue"
complete -c fj -n "__fish_fj_using_subcommand help; and not __fish_seen_subcommand_from repo issue pr wiki actions whoami auth release tag user org version completion help" -f -a "pr"
complete -c fj -n "__fish_fj_using_subcommand help; and not __fish_seen_subcommand_from repo issue pr wiki actions whoami auth release tag user org version completion help" -f -a "wiki"
complete -c fj -n "__fish_fj_using_subcommand help; and not __fish_seen_subcommand_from repo issue pr wiki actions whoami auth release tag user org version completion help" -f -a "actions"
complete -c fj -n "__fish_fj_using_subcommand help; and not __fish_seen_subcommand_from repo issue pr wiki actions whoami auth release tag user org version completion help" -f -a "whoami"
complete -c fj -n "__fish_fj_using_subcommand help; and not __fish_seen_subcommand_from repo issue pr wiki actions whoami auth release tag user org version completion help" -f -a "auth"
complete -c fj -n "__fish_fj_using_subcommand help; and not __fish_seen_subcommand_from repo issue pr wiki actions whoami auth release tag user org version completion help" -f -a "release"
complete -c fj -n "__fish_fj_using_subcommand help; and not __fish_seen_subcommand_from repo issue pr wiki actions whoami auth release tag user org version completion help" -f -a "tag"
complete -c fj -n "__fish_fj_using_subcommand help; and not __fish_seen_subcommand_from repo issue pr wiki actions whoami auth release tag user org version completion help" -f -a "user"
complete -c fj -n "__fish_fj_using_subcommand help; and not __fish_seen_subcommand_from repo issue pr wiki actions whoami auth release tag user org version completion help" -f -a "org"
complete -c fj -n "__fish_fj_using_subcommand help; and not __fish_seen_subcommand_from repo issue pr wiki actions whoami auth release tag user org version completion help" -f -a "version"
complete -c fj -n "__fish_fj_using_subcommand help; and not __fish_seen_subcommand_from repo issue pr wiki actions whoami auth release tag user org version completion help" -f -a "completion"
complete -c fj -n "__fish_fj_using_subcommand help; and not __fish_seen_subcommand_from repo issue pr wiki actions whoami auth release tag user org version completion help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from repo" -f -a "create" -d 'Create a new repository'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from repo" -f -a "fork" -d 'Fork a repository onto your account'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from repo" -f -a "migrate" -d 'Migrate or mirror an existing repository'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from repo" -f -a "view" -d 'View a repo\'s info'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from repo" -f -a "readme" -d 'View a repo\'s README'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from repo" -f -a "clone" -d 'Clone a repo\'s code locally'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from repo" -f -a "star" -d 'Add a star to a repo'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from repo" -f -a "unstar" -d 'Take away a star from a repo'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from repo" -f -a "star-status" -d 'Check your current starring status'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from repo" -f -a "watch" -d 'Subscribe to a repo'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from repo" -f -a "unwatch" -d 'Unsubscribe from a repo'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from repo" -f -a "watch-status" -d 'Check your current watch status'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from repo" -f -a "delete" -d 'Delete a repository'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from repo" -f -a "browse" -d 'Open a repository\'s page in your browser'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from repo" -f -a "labels" -d 'Manage a repo\'s issue labels'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from repo" -f -a "edit" -d 'Edit a repository\'s properties'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from repo" -f -a "units" -d 'Manage a repo\'s units'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from issue" -f -a "create" -d 'Create a new issue on a repo'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from issue" -f -a "edit" -d 'Edit an issue'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from issue" -f -a "comment" -d 'Add a comment on an issue'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from issue" -f -a "assign" -d 'Assign users to an issue'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from issue" -f -a "unassign" -d 'Unassign users from an issue'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from issue" -f -a "close" -d 'Close an issue'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from issue" -f -a "search" -d 'Search for an issue in a repo'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from issue" -f -a "view" -d 'View an issue\'s info'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from issue" -f -a "templates" -d 'List the issue templates in a repo'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from issue" -f -a "browse" -d 'Open an issue in your browser'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from pr" -f -a "search" -d 'Search a repository\'s pull requests'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from pr" -f -a "create" -d 'Create a new pull request'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from pr" -f -a "view" -d 'View the contents of a pull request'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from pr" -f -a "status" -d 'View the mergability and CI status of a pull request'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from pr" -f -a "checkout" -d 'Checkout a pull request in a new branch'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from pr" -f -a "comment" -d 'Checkout a pull request in a new branch'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from pr" -f -a "assign" -d 'Assign users to a pull request'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from pr" -f -a "unassign" -d 'Unassign users from a pull request'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from pr" -f -a "edit" -d 'Edit the contents of a pull request'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from pr" -f -a "close" -d 'Close a pull request, without merging'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from pr" -f -a "merge" -d 'Merge a pull request'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from pr" -f -a "browse" -d 'Open a pull request in your browser'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from pr" -f -a "review" -d 'Manage reviews on a pull request'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from wiki" -f -a "contents"
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from wiki" -f -a "view"
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from wiki" -f -a "clone"
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from wiki" -f -a "browse"
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from actions" -f -a "tasks" -d 'List the tasks on a repo'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from actions" -f -a "variables" -d 'List and manage variables'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from actions" -f -a "secrets" -d 'List and manage secrets'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from actions" -f -a "dispatch" -d 'Dispatch a workflow'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from auth" -f -a "login" -d 'Log in to an instance'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from auth" -f -a "logout" -d 'Deletes login info for an instance'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from auth" -f -a "add-token" -d 'Add an application token for an instance'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from auth" -f -a "use-ssh" -d 'Enable or disable using SSH by default for certain instances'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from auth" -f -a "list" -d 'List all instances you\'re currently logged into'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from release" -f -a "create" -d 'Create a new release'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from release" -f -a "edit" -d 'Edit a release\'s info'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from release" -f -a "delete" -d 'Delete a release'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from release" -f -a "list" -d 'List all the releases on a repo'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from release" -f -a "view" -d 'View a release\'s info'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from release" -f -a "browse" -d 'Open a release in your browser'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from release" -f -a "asset" -d 'Commands on a release\'s attached files'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from tag" -f -a "create" -d 'Create a new tag'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from tag" -f -a "delete" -d 'Delete a tag'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from tag" -f -a "list" -d 'List all the tags on a repo'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from tag" -f -a "view" -d 'View a tag\'s info'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from user" -f -a "search" -d 'Search for a user by username'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from user" -f -a "view" -d 'View a user\'s profile page'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from user" -f -a "browse" -d 'Open a user\'s profile page in your browser'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from user" -f -a "follow" -d 'Follow a user'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from user" -f -a "unfollow" -d 'Unfollow a user'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from user" -f -a "following" -d 'List everyone a user\'s follows'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from user" -f -a "followers" -d 'List a user\'s followers'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from user" -f -a "block" -d 'Block a user'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from user" -f -a "unblock" -d 'Unblock a user'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from user" -f -a "repos" -d 'List a user\'s repositories'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from user" -f -a "orgs" -d 'List the organizations a user is a member of'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from user" -f -a "activity" -d 'List a user\'s recent activity'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from user" -f -a "edit" -d 'Edit your user settings'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from user" -f -a "key" -d 'Manage SSH keys'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from user" -f -a "gpg" -d 'Manage GPG keys'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from org" -f -a "list" -d 'List all organizations'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from org" -f -a "view" -d 'View info about an organization'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from org" -f -a "create" -d 'Create a new organization'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from org" -f -a "edit" -d 'Edit an organization\'s information'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from org" -f -a "activity" -d 'Edit an organization\'s information'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from org" -f -a "members" -d 'List the members of an organization'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from org" -f -a "visibility" -d 'View and change the visibility of your membership in an organization'
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from org" -f -a "team"
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from org" -f -a "label"
complete -c fj -n "__fish_fj_using_subcommand help; and __fish_seen_subcommand_from org" -f -a "repo"
