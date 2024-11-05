if status is-interactive
    # Commands to run in interactive sessions can go here
    bind \cz push-line
    if not type -q bat
        alias bat="batcat"
    end
    alias ls="eza --group-directories-first --icons"
    alias nv="nvim"
    alias wdump="lynx -width 100000 -dump"
    abbr --add mt --position command trap '"jobs -p | xargs kill ; trap - INT"' INT ';' 
    abbr -a !! --position anywhere --function last_history_item
    function chpwd --on-variable PWD --description 'handler of changing $PWD'
        ls -G
    end
    function fish_greeting
        fastfetch
    end
    zoxide init fish | source
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f $HOME/.local/lib/miniforge3/bin/conda
    eval $HOME/.local/lib/miniforge3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

