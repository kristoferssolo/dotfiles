function cd
    if test (count $argv) -eq 0
        z $HOME && eza -a --icons --group-directories-first
    else
        z $argv && eza -a --icons --group-directories-first
    end
end
