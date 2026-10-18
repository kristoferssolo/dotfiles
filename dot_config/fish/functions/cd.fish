function cd
    if functions -q z
        z $argv
    else
        builtin cd $argv
    end
    set -l cd_status $status
    if test $cd_status -eq 0; and command -q eza
        eza -a --icons --group-directories-first
    end
    return $cd_status
end
