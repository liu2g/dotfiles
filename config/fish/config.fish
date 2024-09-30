# add function subdirs to fish_function_path
set fish_function_path (path resolve $__fish_config_dir/functions/*/) $fish_function_path

if status is-interactive
    # Commands to run in interactive sessions can go here
end
