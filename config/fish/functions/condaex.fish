function condaex --description 'Export conda environment portably'
    set pip_packages (conda env export | grep -A9999 ".*- pip:" | grep -v "^prefix: ")
    conda env export --from-history | grep -v "^prefix: "
	printf "%s\n" $pip_packages
end
