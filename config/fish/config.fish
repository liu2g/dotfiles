if status is-interactive
    # Commands to run in interactive sessions can go here
    bind \cz push-line
    if not type -q bat
        alias bat="batcat"
    end
    alias ls="eza --group-directories-first --icons"
    alias nv="nvim"
    alias wdump="lynx -width 100000 -dump"
    abbr -a !! --position anywhere --function last_history_item
    function chpwd --on-variable PWD --description 'handler of changing $PWD'
        ls -G
    end
    function fish_greeting
        fastfetch
    end
    zoxide init fish | source
end
