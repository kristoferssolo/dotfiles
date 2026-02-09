function vi_append_accept --description "Accept autosuggestion and append in vi mode"
    commandline -f accept-autosuggestion
    commandline -f end-of-line
    set fish_bind_mode insert
    fish_vi_cursor insert
    commandline -f end-of-line
    commandline -f repaint
end
