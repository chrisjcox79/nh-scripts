#!/bin/bash

#This script is using wifite2 tool

########## FUNCTIONS ##########

interface()
{
    clear
    printf "[*] Welcome to Wifite\n\n"
    printf "[*] Select which interface you using for attack? (1-2)\n\n"
    printf "1. wlan0 (Internal Nexus WiFi)\n"
    printf "2. wlan1 (External WiFi card)\n\n"
    read -p "Choice (1-2): " iface
    case $iface in 
        1) run_wlan0s ;;
        2) run_wlan1s ;;
        *) printf "[!] Wrong number! Try again..." && sleep 1 && interface ;;
    esac
}

run_wlan0s(){
    clear
    read -p "[*] Start attack? (Y/n): " start
    case $start in
        [yY]|[yY][eE][sS])
            run_wlan0
            ;;
        [nN]|[nN][oO])
            exit
            ;;
        *) printf "[!] Wrong number! Try again..." && sleep 1 && interface ;;
    esac
}

run_wlan1s(){
    clear
    read -p "[*] Start attack? (Y/n): " start
    case $start in
        [yY]|[yY][eE][sS])
            run_wlan1
            ;;
        [nN]|[nN][oO])
            exit
            ;;
        *) printf "[!] Wrong number! Try again..." && sleep 1 && interface ;;
    esac
}

run_wlan0()
{
    printf "\n[*] Starting nexmon on wlan0...\n"
	sleep 1
	. monstart-nh
	printf "\n[*] Launching wifite...\n\n"
	sleep 1
	wifite -i wlan0 -ab -mac
	printf "\n[*] Stopping nexmon on wlan0...\n"
	sleep 1
	. monstop-nh
}
check_tools(){
   command -v bully >/dev/null 2>&1 || { clear; printf >&2 "Requied tools\e[91m are not installed!\n\e[0m"; f_install;exit; }
   command -v hcxdumptool >/dev/null 2>&1 || { clear; printf >&2 "Requied tools\e[91m are not installed!\n\e[0m"; f_install;exit; }
   command -v cowpatty >/dev/null 2>&1 || { clear; printf >&2 "Requied tools\e[91m are not installed!\n\e[0m"; f_install;exit; }
   command -v hcxmactool >/dev/null 2>&1 || { clear; printf >&2 "Requied tools\e[91m are not installed!\n\e[0m"; f_install;exit; }
}

f_install(){
    read -p "[*] Install? (Y/n): "  install
    case $install in
        [yY][eE][sS]|[yY])
            clear
            printf "\e[92m[*] Installing...\n\e[0m"
            apt-get update
            apt-get install hcxtools -y
            apt-get install hcxdumptool -y
            apt-get install bully -y
            apt-get install cowpatty -y
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

run_wlan1()
{
        clear
        sleep 1
        ifconfig wlan1 up
        printf "\n[*] Launching wifite...\n"
        sleep 1
      	wifite -i wlan1 -mac
        sleep 1
}

########## RUN SCRIPT ##########

check_tools
interface
