# Dotrc #

## About ##

The goal of this project is to keep all my rc files in sync regardless of the computer I'm using (granted it has git installed).

## Installation ##

1. Clone the project :

    `$ git clone git://github.com/jrottenberg/dotrc ~/dotrc`

1. Run the symlink helper :

    `$ ~/dotrc/createSymLinks.sh`

1. Enjoy !


Note : All your previous rc files are saved with date suffix, `.bashrc.20110625-0049`




## Usage ##

You should fork the project if you want to keep track of your files and have your own preferences ;-)

New software that requires a config file ?

1. Put that config file (minus the . in the dotrc fodlder)
1. Run 
     $ ~/dotrc/createSymLinks.sh
1. From any of your computer installation propagate the good stuff through git transport (git push, git pull). I've made few aliases to make it easy :

    `alias dotup="cd ~/dotrc && git pull origin master && cd -"`
    `alias dotpush="cd ~/dotrc && git push && cd -"`
    `alias dotci="git commit ~/dotrc"`



### Example : htop ###

1. Run htop, the first time it will save default settings in ~/.htoprc
1. Configure htop until ~/.htoprc describes really how you like it to be configured
1. Copy .htoprc to the dotrc folder without the trailing dot
       `$ cp ~/.htoprc dotrc/htoptrc`
1. git add and commit the file so we can start tracking the change
1. Run the createSymlinks script
1. You now have that htop configure to your liking everywhere you ran the createSymlinks script

