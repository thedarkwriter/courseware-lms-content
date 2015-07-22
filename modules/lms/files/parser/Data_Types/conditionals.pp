# Use an `if/elseif/else` to select between the following
notice('This is a virtual machine')
notice('This is a non-virtual Windows Machine')
notice('This is non-virtual non-Windows Machine')

# Use an `unless` statement based on memory
notice('Less than 1GB of memory, using low memory mode')

# Use a `case` statement to show a different message for each operatingsystem
notice('Solaris')
notice('RedHat')
notice('Debian')
notice('Default Case')

# Use a selector statement to assign $rootgroup to different values for each $osfamily 
# 'Solaris' uses 'wheel'
# 'Darwin' uses 'wheel'
# Others use 'root'

notice("The rootgroup for this OS is ${rootgroup}")


