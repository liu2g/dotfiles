function push-line                                                                                  
	set -g __fish_pushed_line (commandline)                                                           
	commandline ""                                                                                    
	function after-next-prompt --on-event fish_postexec                                               
		commandline $__fish_pushed_line                                                                 
		functions --erase after-next-prompt                                                             
	end                                                                                               
end
