function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
    set -l normal (set_color normal)
    set -q fish_color_status
    or set -g fish_color_status red

    if not set -q __fish_git_prompt_show_informative_status
        set -g __fish_git_prompt_show_informative_status 1
    end
    if not set -q __fish_git_prompt_color_branch
        set -g __fish_git_prompt_color_branch $fish_color_comment
    end
    if not set -q __fish_git_prompt_showupstream
        set -g __fish_git_prompt_showupstream informative
    end

    set -g fish_prompt_pwd_full_dirs 2
    set -g fish_prompt_pwd_dir_length 1
    set -l color_cwd
    set -l suffix
    if functions -q fish_is_root_user; and fish_is_root_user
        set color_cwd $fish_color_error --bold
        set suffix '#'
    else
        set color_cwd $fish_color_param --bold
        set suffix '$'
    end
    set color_login $fish_color_user --bold

    # Write pipestatus
    # If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
    set -l bold_flag --bold
    set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
    if test $__fish_prompt_status_generation = $status_generation
        set bold_flag
    end
    set __fish_prompt_status_generation $status_generation
    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color $bold_flag $fish_color_status)
    set -l prompt_status (__fish_print_pipestatus "[" "] " "|" "$status_color" "$statusb_color" $last_pipestatus)

    echo -n -s "$prompt_status"(set_color $color_login)(whoami) $normal ' ' (set_color $color_cwd) (prompt_pwd) $normal (fish_vcs_prompt) $normal " $suffix "
end
