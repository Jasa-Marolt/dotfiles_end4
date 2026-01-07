function cd 
    # Check if 'z' (zoxide) function is available
    if functions -q z
        # If 'z' is found, try to use it
        z $argv
        # If 'z' fails, fall back to the built-in cd
        if test $status -ne 0
            builtin cd $argv
        end
    else
        # If 'z' is not found, use the built-in cd directly
        builtin cd $argv
    end

    # Check if the last command (z or builtin cd) succeeded
    if test $status -eq 0
        # If the directory change was successful, run the ls/eza logic

        # Check the number of all items (including hidden) using eza
        set countAll (eza -A | wc -l)

        if test $countAll -lt 15
            # If few items, show all, sorted by modified time (eza fix)
            eza -A --sort modified
        else
            # If many items, check only visible ones
            set countVisible (eza | wc -l)
            if test $countVisible -lt 30
                # If few visible items, show them, sorted by modified time (eza fix)
                eza --sort modified
            end
        end
    end
end
