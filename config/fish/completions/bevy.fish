# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_bevy_global_optspecs
	string join \n v/verbose h/help V/version
end

function __fish_bevy_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_bevy_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_bevy_using_subcommand
	set -l cmd (__fish_bevy_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c bevy -n "__fish_bevy_needs_command" -s v -l verbose -d 'Use verbose output'
complete -c bevy -n "__fish_bevy_needs_command" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c bevy -n "__fish_bevy_needs_command" -s V -l version -d 'Print version'
complete -c bevy -n "__fish_bevy_needs_command" -f -a "new" -d 'Create a new Bevy project from a specified template'
complete -c bevy -n "__fish_bevy_needs_command" -f -a "build" -d 'Build your Bevy app'
complete -c bevy -n "__fish_bevy_needs_command" -f -a "b" -d 'Build your Bevy app'
complete -c bevy -n "__fish_bevy_needs_command" -f -a "run" -d 'Run your Bevy app'
complete -c bevy -n "__fish_bevy_needs_command" -f -a "r" -d 'Run your Bevy app'
complete -c bevy -n "__fish_bevy_needs_command" -f -a "lint" -d 'Check the current project using Bevy-specific lints'
complete -c bevy -n "__fish_bevy_needs_command" -f -a "completions" -d 'Prints the auto-completion script for a specific shell'
complete -c bevy -n "__fish_bevy_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c bevy -n "__fish_bevy_using_subcommand new" -s t -l template -d 'The name of the template to use for generating the project' -r
complete -c bevy -n "__fish_bevy_using_subcommand new" -l branch -d 'Branch to use when installing from git' -r
complete -c bevy -n "__fish_bevy_using_subcommand new" -l tag -d 'Tag to use when installing from git' -r
complete -c bevy -n "__fish_bevy_using_subcommand new" -l revision -d 'Git revision to use when installing from git (e.g. a commit hash)' -r
complete -c bevy -n "__fish_bevy_using_subcommand new" -l yes -d 'Confirm all prompts automatically'
complete -c bevy -n "__fish_bevy_using_subcommand new" -s v -l verbose -d 'Use verbose output'
complete -c bevy -n "__fish_bevy_using_subcommand new" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -l config -d 'Override a configuration value' -r
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -l rustflags -d 'custom flags to pass to all compiler invocations' -r
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -s Z -d 'Unstable (nightly-only) flags to Cargo, see `cargo -Z help` for details' -r
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -s p -l package -d 'Package to build (see `cargo help pkgid`)' -r
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -l exclude -d 'Exclude packages from the build' -r
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -l bin -d 'Build only the specified binary' -r
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -l example -d 'Build only the specified example' -r
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -l test -d 'Build only the specified test target' -r
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -l bench -d 'Build only the specified bench target' -r
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -s F -l features -d 'Space or comma separated list of features to activate' -r
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -l profile -d 'Build artifacts with the specified profile' -r
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -s j -l jobs -d 'Number of parallel jobs, defaults to # of CPUs' -r
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -l target -d 'Build for the target triple' -r
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -l target-dir -d 'Directory for all generated artifacts' -r
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -l manifest-path -d 'Path to Cargo.toml' -r
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -l yes -d 'Confirm all prompts automatically'
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -l workspace -d 'Build all packages in the workspace'
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -l lib -d 'Build only this package\'s library'
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -l bins -d 'Build all binaries'
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -l examples -d 'Build all examples'
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -l tests -d 'Build all tests'
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -l benches -d 'Build all benches'
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -l all-targets -d 'Build all benches'
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -l all-features -d 'Activate all available features'
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -l no-default-features -d 'Do not activate the `default` feature'
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -s r -l release -d 'Build artifacts in release mode, with optimizations'
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -l keep-going -d 'Do not abort the build as soon as there is an error'
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -l ignore-rust-version -d 'Ignore `rust-version` specification in packages'
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -l locked -d 'Assert that `Cargo.lock` will remain unchanged'
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -l offline -d 'Run without accessing the network'
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -l frozen -d 'Equivalent to specifying both --locked and --offline'
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -s v -l verbose -d 'Use verbose output'
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -f -a "web" -d 'Build your app for the browser'
complete -c bevy -n "__fish_bevy_using_subcommand build; and not __fish_seen_subcommand_from web help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c bevy -n "__fish_bevy_using_subcommand build; and __fish_seen_subcommand_from web" -l wasm-opt -d 'Use `wasm-opt` to optimize the wasm binary' -r
complete -c bevy -n "__fish_bevy_using_subcommand build; and __fish_seen_subcommand_from web" -s U -l unstable -d 'Enable unstable web features' -r -f -a "multi-threading\t'Enable building and running multi-threaded Wasm apps'"
complete -c bevy -n "__fish_bevy_using_subcommand build; and __fish_seen_subcommand_from web" -s b -l bundle -d 'Bundle all web artifacts into a single folder'
complete -c bevy -n "__fish_bevy_using_subcommand build; and __fish_seen_subcommand_from web" -s v -l verbose -d 'Use verbose output'
complete -c bevy -n "__fish_bevy_using_subcommand build; and __fish_seen_subcommand_from web" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c bevy -n "__fish_bevy_using_subcommand build; and __fish_seen_subcommand_from help" -f -a "web" -d 'Build your app for the browser'
complete -c bevy -n "__fish_bevy_using_subcommand build; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -l config -d 'Override a configuration value' -r
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -l rustflags -d 'custom flags to pass to all compiler invocations' -r
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -s Z -d 'Unstable (nightly-only) flags to Cargo, see `cargo -Z help` for details' -r
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -s p -l package -d 'Package to build (see `cargo help pkgid`)' -r
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -l exclude -d 'Exclude packages from the build' -r
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -l bin -d 'Build only the specified binary' -r
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -l example -d 'Build only the specified example' -r
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -l test -d 'Build only the specified test target' -r
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -l bench -d 'Build only the specified bench target' -r
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -s F -l features -d 'Space or comma separated list of features to activate' -r
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -l profile -d 'Build artifacts with the specified profile' -r
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -s j -l jobs -d 'Number of parallel jobs, defaults to # of CPUs' -r
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -l target -d 'Build for the target triple' -r
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -l target-dir -d 'Directory for all generated artifacts' -r
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -l manifest-path -d 'Path to Cargo.toml' -r
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -l yes -d 'Confirm all prompts automatically'
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -l workspace -d 'Build all packages in the workspace'
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -l lib -d 'Build only this package\'s library'
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -l bins -d 'Build all binaries'
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -l examples -d 'Build all examples'
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -l tests -d 'Build all tests'
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -l benches -d 'Build all benches'
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -l all-targets -d 'Build all benches'
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -l all-features -d 'Activate all available features'
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -l no-default-features -d 'Do not activate the `default` feature'
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -s r -l release -d 'Build artifacts in release mode, with optimizations'
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -l keep-going -d 'Do not abort the build as soon as there is an error'
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -l ignore-rust-version -d 'Ignore `rust-version` specification in packages'
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -l locked -d 'Assert that `Cargo.lock` will remain unchanged'
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -l offline -d 'Run without accessing the network'
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -l frozen -d 'Equivalent to specifying both --locked and --offline'
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -s v -l verbose -d 'Use verbose output'
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -f -a "web" -d 'Build your app for the browser'
complete -c bevy -n "__fish_bevy_using_subcommand b; and not __fish_seen_subcommand_from web help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c bevy -n "__fish_bevy_using_subcommand b; and __fish_seen_subcommand_from web" -l wasm-opt -d 'Use `wasm-opt` to optimize the wasm binary' -r
complete -c bevy -n "__fish_bevy_using_subcommand b; and __fish_seen_subcommand_from web" -s U -l unstable -d 'Enable unstable web features' -r -f -a "multi-threading\t'Enable building and running multi-threaded Wasm apps'"
complete -c bevy -n "__fish_bevy_using_subcommand b; and __fish_seen_subcommand_from web" -s b -l bundle -d 'Bundle all web artifacts into a single folder'
complete -c bevy -n "__fish_bevy_using_subcommand b; and __fish_seen_subcommand_from web" -s v -l verbose -d 'Use verbose output'
complete -c bevy -n "__fish_bevy_using_subcommand b; and __fish_seen_subcommand_from web" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c bevy -n "__fish_bevy_using_subcommand b; and __fish_seen_subcommand_from help" -f -a "web" -d 'Build your app for the browser'
complete -c bevy -n "__fish_bevy_using_subcommand b; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c bevy -n "__fish_bevy_using_subcommand run; and not __fish_seen_subcommand_from web help" -l config -d 'Override a configuration value' -r
complete -c bevy -n "__fish_bevy_using_subcommand run; and not __fish_seen_subcommand_from web help" -l rustflags -d 'custom flags to pass to all compiler invocations' -r
complete -c bevy -n "__fish_bevy_using_subcommand run; and not __fish_seen_subcommand_from web help" -s Z -d 'Unstable (nightly-only) flags to Cargo, see `cargo -Z help` for details' -r
complete -c bevy -n "__fish_bevy_using_subcommand run; and not __fish_seen_subcommand_from web help" -s p -l package -d 'Package with the target to run' -r
complete -c bevy -n "__fish_bevy_using_subcommand run; and not __fish_seen_subcommand_from web help" -l bin -d 'Build only the specified binary' -r
complete -c bevy -n "__fish_bevy_using_subcommand run; and not __fish_seen_subcommand_from web help" -l example -d 'Build only the specified example' -r
complete -c bevy -n "__fish_bevy_using_subcommand run; and not __fish_seen_subcommand_from web help" -s F -l features -d 'Space or comma separated list of features to activate' -r
complete -c bevy -n "__fish_bevy_using_subcommand run; and not __fish_seen_subcommand_from web help" -l profile -d 'Build artifacts with the specified profile' -r
complete -c bevy -n "__fish_bevy_using_subcommand run; and not __fish_seen_subcommand_from web help" -s j -l jobs -d 'Number of parallel jobs, defaults to # of CPUs' -r
complete -c bevy -n "__fish_bevy_using_subcommand run; and not __fish_seen_subcommand_from web help" -l target -d 'Build for the target triple' -r
complete -c bevy -n "__fish_bevy_using_subcommand run; and not __fish_seen_subcommand_from web help" -l target-dir -d 'Directory for all generated artifacts' -r
complete -c bevy -n "__fish_bevy_using_subcommand run; and not __fish_seen_subcommand_from web help" -l manifest-path -d 'Path to Cargo.toml' -r
complete -c bevy -n "__fish_bevy_using_subcommand run; and not __fish_seen_subcommand_from web help" -l yes -d 'Confirm all prompts automatically'
complete -c bevy -n "__fish_bevy_using_subcommand run; and not __fish_seen_subcommand_from web help" -l all-features -d 'Activate all available features'
complete -c bevy -n "__fish_bevy_using_subcommand run; and not __fish_seen_subcommand_from web help" -l no-default-features -d 'Do not activate the `default` feature'
complete -c bevy -n "__fish_bevy_using_subcommand run; and not __fish_seen_subcommand_from web help" -s r -l release -d 'Build artifacts in release mode, with optimizations'
complete -c bevy -n "__fish_bevy_using_subcommand run; and not __fish_seen_subcommand_from web help" -l keep-going -d 'Do not abort the build as soon as there is an error'
complete -c bevy -n "__fish_bevy_using_subcommand run; and not __fish_seen_subcommand_from web help" -l ignore-rust-version -d 'Ignore `rust-version` specification in packages'
complete -c bevy -n "__fish_bevy_using_subcommand run; and not __fish_seen_subcommand_from web help" -l locked -d 'Assert that `Cargo.lock` will remain unchanged'
complete -c bevy -n "__fish_bevy_using_subcommand run; and not __fish_seen_subcommand_from web help" -l offline -d 'Run without accessing the network'
complete -c bevy -n "__fish_bevy_using_subcommand run; and not __fish_seen_subcommand_from web help" -l frozen -d 'Equivalent to specifying both --locked and --offline'
complete -c bevy -n "__fish_bevy_using_subcommand run; and not __fish_seen_subcommand_from web help" -s v -l verbose -d 'Use verbose output'
complete -c bevy -n "__fish_bevy_using_subcommand run; and not __fish_seen_subcommand_from web help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c bevy -n "__fish_bevy_using_subcommand run; and not __fish_seen_subcommand_from web help" -a "web" -d 'Run your app in the browser'
complete -c bevy -n "__fish_bevy_using_subcommand run; and not __fish_seen_subcommand_from web help" -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c bevy -n "__fish_bevy_using_subcommand run; and __fish_seen_subcommand_from web" -s p -l port -d 'The port to run the web server on' -r
complete -c bevy -n "__fish_bevy_using_subcommand run; and __fish_seen_subcommand_from web" -l host -d 'The host address to run the web server on' -r
complete -c bevy -n "__fish_bevy_using_subcommand run; and __fish_seen_subcommand_from web" -s H -l headers -d 'Headers to add to the web-server responses, in the format `name:value` or `name=value`' -r
complete -c bevy -n "__fish_bevy_using_subcommand run; and __fish_seen_subcommand_from web" -l wasm-opt -d 'Use `wasm-opt` to optimize the wasm binary' -r
complete -c bevy -n "__fish_bevy_using_subcommand run; and __fish_seen_subcommand_from web" -s U -l unstable -d 'Enable unstable web features' -r -f -a "multi-threading\t'Enable building and running multi-threaded Wasm apps'"
complete -c bevy -n "__fish_bevy_using_subcommand run; and __fish_seen_subcommand_from web" -s o -l open -d 'Open the app in the browser'
complete -c bevy -n "__fish_bevy_using_subcommand run; and __fish_seen_subcommand_from web" -s b -l bundle -d 'Bundle all web artifacts into a single folder'
complete -c bevy -n "__fish_bevy_using_subcommand run; and __fish_seen_subcommand_from web" -s v -l verbose -d 'Use verbose output'
complete -c bevy -n "__fish_bevy_using_subcommand run; and __fish_seen_subcommand_from web" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c bevy -n "__fish_bevy_using_subcommand run; and __fish_seen_subcommand_from help" -f -a "web" -d 'Run your app in the browser'
complete -c bevy -n "__fish_bevy_using_subcommand run; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c bevy -n "__fish_bevy_using_subcommand r; and not __fish_seen_subcommand_from web help" -l config -d 'Override a configuration value' -r
complete -c bevy -n "__fish_bevy_using_subcommand r; and not __fish_seen_subcommand_from web help" -l rustflags -d 'custom flags to pass to all compiler invocations' -r
complete -c bevy -n "__fish_bevy_using_subcommand r; and not __fish_seen_subcommand_from web help" -s Z -d 'Unstable (nightly-only) flags to Cargo, see `cargo -Z help` for details' -r
complete -c bevy -n "__fish_bevy_using_subcommand r; and not __fish_seen_subcommand_from web help" -s p -l package -d 'Package with the target to run' -r
complete -c bevy -n "__fish_bevy_using_subcommand r; and not __fish_seen_subcommand_from web help" -l bin -d 'Build only the specified binary' -r
complete -c bevy -n "__fish_bevy_using_subcommand r; and not __fish_seen_subcommand_from web help" -l example -d 'Build only the specified example' -r
complete -c bevy -n "__fish_bevy_using_subcommand r; and not __fish_seen_subcommand_from web help" -s F -l features -d 'Space or comma separated list of features to activate' -r
complete -c bevy -n "__fish_bevy_using_subcommand r; and not __fish_seen_subcommand_from web help" -l profile -d 'Build artifacts with the specified profile' -r
complete -c bevy -n "__fish_bevy_using_subcommand r; and not __fish_seen_subcommand_from web help" -s j -l jobs -d 'Number of parallel jobs, defaults to # of CPUs' -r
complete -c bevy -n "__fish_bevy_using_subcommand r; and not __fish_seen_subcommand_from web help" -l target -d 'Build for the target triple' -r
complete -c bevy -n "__fish_bevy_using_subcommand r; and not __fish_seen_subcommand_from web help" -l target-dir -d 'Directory for all generated artifacts' -r
complete -c bevy -n "__fish_bevy_using_subcommand r; and not __fish_seen_subcommand_from web help" -l manifest-path -d 'Path to Cargo.toml' -r
complete -c bevy -n "__fish_bevy_using_subcommand r; and not __fish_seen_subcommand_from web help" -l yes -d 'Confirm all prompts automatically'
complete -c bevy -n "__fish_bevy_using_subcommand r; and not __fish_seen_subcommand_from web help" -l all-features -d 'Activate all available features'
complete -c bevy -n "__fish_bevy_using_subcommand r; and not __fish_seen_subcommand_from web help" -l no-default-features -d 'Do not activate the `default` feature'
complete -c bevy -n "__fish_bevy_using_subcommand r; and not __fish_seen_subcommand_from web help" -s r -l release -d 'Build artifacts in release mode, with optimizations'
complete -c bevy -n "__fish_bevy_using_subcommand r; and not __fish_seen_subcommand_from web help" -l keep-going -d 'Do not abort the build as soon as there is an error'
complete -c bevy -n "__fish_bevy_using_subcommand r; and not __fish_seen_subcommand_from web help" -l ignore-rust-version -d 'Ignore `rust-version` specification in packages'
complete -c bevy -n "__fish_bevy_using_subcommand r; and not __fish_seen_subcommand_from web help" -l locked -d 'Assert that `Cargo.lock` will remain unchanged'
complete -c bevy -n "__fish_bevy_using_subcommand r; and not __fish_seen_subcommand_from web help" -l offline -d 'Run without accessing the network'
complete -c bevy -n "__fish_bevy_using_subcommand r; and not __fish_seen_subcommand_from web help" -l frozen -d 'Equivalent to specifying both --locked and --offline'
complete -c bevy -n "__fish_bevy_using_subcommand r; and not __fish_seen_subcommand_from web help" -s v -l verbose -d 'Use verbose output'
complete -c bevy -n "__fish_bevy_using_subcommand r; and not __fish_seen_subcommand_from web help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c bevy -n "__fish_bevy_using_subcommand r; and not __fish_seen_subcommand_from web help" -a "web" -d 'Run your app in the browser'
complete -c bevy -n "__fish_bevy_using_subcommand r; and not __fish_seen_subcommand_from web help" -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c bevy -n "__fish_bevy_using_subcommand r; and __fish_seen_subcommand_from web" -s p -l port -d 'The port to run the web server on' -r
complete -c bevy -n "__fish_bevy_using_subcommand r; and __fish_seen_subcommand_from web" -l host -d 'The host address to run the web server on' -r
complete -c bevy -n "__fish_bevy_using_subcommand r; and __fish_seen_subcommand_from web" -s H -l headers -d 'Headers to add to the web-server responses, in the format `name:value` or `name=value`' -r
complete -c bevy -n "__fish_bevy_using_subcommand r; and __fish_seen_subcommand_from web" -l wasm-opt -d 'Use `wasm-opt` to optimize the wasm binary' -r
complete -c bevy -n "__fish_bevy_using_subcommand r; and __fish_seen_subcommand_from web" -s U -l unstable -d 'Enable unstable web features' -r -f -a "multi-threading\t'Enable building and running multi-threaded Wasm apps'"
complete -c bevy -n "__fish_bevy_using_subcommand r; and __fish_seen_subcommand_from web" -s o -l open -d 'Open the app in the browser'
complete -c bevy -n "__fish_bevy_using_subcommand r; and __fish_seen_subcommand_from web" -s b -l bundle -d 'Bundle all web artifacts into a single folder'
complete -c bevy -n "__fish_bevy_using_subcommand r; and __fish_seen_subcommand_from web" -s v -l verbose -d 'Use verbose output'
complete -c bevy -n "__fish_bevy_using_subcommand r; and __fish_seen_subcommand_from web" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c bevy -n "__fish_bevy_using_subcommand r; and __fish_seen_subcommand_from help" -f -a "web" -d 'Run your app in the browser'
complete -c bevy -n "__fish_bevy_using_subcommand r; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -l config -d 'Override a configuration value' -r
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -l rustflags -d 'custom flags to pass to all compiler invocations' -r
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -s Z -d 'Unstable (nightly-only) flags to Cargo, see `cargo -Z help` for details' -r
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -s p -l package -d 'Package to check (see `cargo help pkgid`)' -r
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -l exclude -d 'Exclude packages from the check' -r
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -l bin -d 'Check only the specified binary' -r
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -l example -d 'Check only the specified example' -r
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -l test -d 'Check only the specified test target' -r
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -l bench -d 'Check only the specified bench target' -r
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -s F -l features -d 'Space or comma separated list of features to activate' -r
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -l profile -d 'Build artifacts with the specified profile' -r
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -s j -l jobs -d 'Number of parallel jobs, defaults to # of CPUs' -r
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -l target -d 'Build for the target triple' -r
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -l target-dir -d 'Directory for all generated artifacts' -r
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -l manifest-path -d 'Path to Cargo.toml' -r
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -l version -d 'Show version information'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -l fix -d 'Automatically fix lint warnings reported by bevy_lint'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -l workspace -d 'Check all packages in the workspace'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -l lib -d 'Check only this package\'s library'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -l bins -d 'Check all binaries'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -l examples -d 'Check all examples'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -l tests -d 'Check all tests'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -l benches -d 'Check all benches'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -l all-targets -d 'Check all benches'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -l all-features -d 'Activate all available features'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -l no-default-features -d 'Do not activate the `default` feature'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -s r -l release -d 'Build artifacts in release mode, with optimizations'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -l keep-going -d 'Do not abort the build as soon as there is an error'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -l ignore-rust-version -d 'Ignore `rust-version` specification in packages'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -l locked -d 'Assert that `Cargo.lock` will remain unchanged'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -l offline -d 'Run without accessing the network'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -l frozen -d 'Equivalent to specifying both --locked and --offline'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -s v -l verbose -d 'Use verbose output'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -a "web" -d 'Lint your app for the browser'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -a "install" -d 'Install a `bevy_lint` version'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -a "list" -d 'List all available `bevy_lint` versions'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and not __fish_seen_subcommand_from web install list help" -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and __fish_seen_subcommand_from web" -s v -l verbose -d 'Use verbose output'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and __fish_seen_subcommand_from web" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and __fish_seen_subcommand_from install" -l yes -d 'Confirm all prompts automatically'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and __fish_seen_subcommand_from install" -s v -l verbose -d 'Use verbose output'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and __fish_seen_subcommand_from install" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and __fish_seen_subcommand_from list" -s v -l verbose -d 'Use verbose output'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and __fish_seen_subcommand_from help" -f -a "web" -d 'Lint your app for the browser'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and __fish_seen_subcommand_from help" -f -a "install" -d 'Install a `bevy_lint` version'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and __fish_seen_subcommand_from help" -f -a "list" -d 'List all available `bevy_lint` versions'
complete -c bevy -n "__fish_bevy_using_subcommand lint; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c bevy -n "__fish_bevy_using_subcommand completions" -s v -l verbose -d 'Use verbose output'
complete -c bevy -n "__fish_bevy_using_subcommand completions" -s h -l help -d 'Print help (see more with \'--help\')'
complete -c bevy -n "__fish_bevy_using_subcommand help; and not __fish_seen_subcommand_from new build run lint completions help" -f -a "new" -d 'Create a new Bevy project from a specified template'
complete -c bevy -n "__fish_bevy_using_subcommand help; and not __fish_seen_subcommand_from new build run lint completions help" -f -a "build" -d 'Build your Bevy app'
complete -c bevy -n "__fish_bevy_using_subcommand help; and not __fish_seen_subcommand_from new build run lint completions help" -f -a "run" -d 'Run your Bevy app'
complete -c bevy -n "__fish_bevy_using_subcommand help; and not __fish_seen_subcommand_from new build run lint completions help" -f -a "lint" -d 'Check the current project using Bevy-specific lints'
complete -c bevy -n "__fish_bevy_using_subcommand help; and not __fish_seen_subcommand_from new build run lint completions help" -f -a "completions" -d 'Prints the auto-completion script for a specific shell'
complete -c bevy -n "__fish_bevy_using_subcommand help; and not __fish_seen_subcommand_from new build run lint completions help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c bevy -n "__fish_bevy_using_subcommand help; and __fish_seen_subcommand_from build" -f -a "web" -d 'Build your app for the browser'
complete -c bevy -n "__fish_bevy_using_subcommand help; and __fish_seen_subcommand_from run" -f -a "web" -d 'Run your app in the browser'
complete -c bevy -n "__fish_bevy_using_subcommand help; and __fish_seen_subcommand_from lint" -f -a "web" -d 'Lint your app for the browser'
complete -c bevy -n "__fish_bevy_using_subcommand help; and __fish_seen_subcommand_from lint" -f -a "install" -d 'Install a `bevy_lint` version'
complete -c bevy -n "__fish_bevy_using_subcommand help; and __fish_seen_subcommand_from lint" -f -a "list" -d 'List all available `bevy_lint` versions'
