# Dotrc #

## About ##

The goal of this project is to keep all my rc files in sync regardless of the computer I'm using (granted it has git installed).

## Installation ##

1. Clone the project :

    $ git clone git://github.com/jrottenberg/dotrc ~/dotrc

1. Run the symlink helper :

    $ ~/dotrc/createSymLinks.sh

1. Enjoy !


Note : All your previous rc files are saved with date suffix, ex :


.bashrc.20110625-0049


## Usage ##

You should fork the project if you want to keep track of your files and have your own preferences ;-)

New software that requires a config file ?

1. Put that config file (minus the . in the dotrc fodlder)
2. Run 

     $ ~/dotrc/createSymLinks.sh


