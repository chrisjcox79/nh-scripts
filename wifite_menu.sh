#!/bin/bash

#This script is using wifite2 tool

########## FUNCTIONS ##########

interface()
{
    clear
    printf "[*] Welcome to Wifite\n\n"
    printf "[*] Select which interface you using for attack? (1-2)\n\n"
    printf "1. wlan0 - internal wireless\n"
    printf "2. wlan1 - external wireless\n\n"
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

interface
