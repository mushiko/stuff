#!/bin/bash

#2016/03/15 Vivian Yean z3414771
#In an ultimate display of laziness, this was created
#Also learning to use .sh slowly
#http://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
#http://stackoverflow.com/questions/255414/why-doesnt-cd-work-in-a-bash-shell-script
echo "$(tput setaf 6)$(tput bold)Hi Viv!" 
echo "Taking you to /srv/scratch/z3414771$(tput sgr0)"
cd /srv/scratch/z3414771
