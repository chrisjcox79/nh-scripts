#!/bin/bash

##########################################
#  NetHunter update user-fiendly script  #
##########################################

########## FUNCTIONS ##########

main_menu(){
    clear
    printf "[*] Welcome to the NH updater\n\n"
    printf "[*] You can update/upgrade NetHunter here\n\n"
    read -p "[*] Start NetHunter Update? (Y/n): " update
    case $update in
        [yY][eE][sS]|[yY])
            sleep 0.5
            printf "\n\n[*] Starting update... This can take some time, Wait!\n\n"
            sleep 2
            apt-get update
            apt-get full-upgrade -y
            pip3 install --upgrade pip
            pip install --upgrade pip
            apt-get autoremove -y
            printf "\n\n[*] DONE!!!\n\n"
            sleep 3
            read -p "[*] Press [ENTER] to exit..." click
            exit
            ;;
        [nN][oO]|[nN])
            printf "\n\n"
            exit
            ;;
        *) printf "[!] Wrong number! Try again...\n"; main_menu ;;
    esac
}

####### Run #######

main_menu