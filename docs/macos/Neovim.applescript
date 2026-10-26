on open fileList
    launchEditor(fileList)
end open

on run
    launchEditor({})
end run

on launchEditor(fileList)
    if (do shell script "test -x /opt/homebrew/bin/fish && echo yes || echo no") is "yes" then
        set fishPath to "/opt/homebrew/bin/fish"
    else
        set fishPath to "/usr/local/bin/fish"
    end if

    set editorCommand to "exec nvim --"
    set workingDirectory to POSIX path of (path to home folder)
    repeat with fileItem in fileList
        set filePath to POSIX path of fileItem
        set editorCommand to editorCommand & " " & quoted form of filePath
    end repeat
    if (count fileList) > 0 then
        set firstPath to POSIX path of (item 1 of fileList)
        set workingDirectory to do shell script "/usr/bin/dirname " & quoted form of firstPath
    end if

    -- LaunchServices starts a separate Ghostty instance without Automation access.
    -- The login shell supplies the same PATH and editor environment as a terminal.
    set launchCommand to "/usr/bin/open -na /Applications/Ghostty.app --args "
    set launchCommand to launchCommand & quoted form of ("--working-directory=" & workingDirectory)
    set launchCommand to launchCommand & " -e /usr/bin/env -u NO_COLOR " & quoted form of fishPath
    set launchCommand to launchCommand & " --login -c " & quoted form of editorCommand
    do shell script launchCommand
end launchEditor
