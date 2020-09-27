#!/bin/bash

#This script is using wifite2 tool

########## FUNCTIONS ##########

interface()
{
    clear
    printf "############################\n"
    printf "#          WIFITE          #\n"
    printf "############################\n"
    printf "1. wlan0 - internal wireless\n"
    printf "2. wlan1 - external wireless\n"
    printf "3. exit\n\n"
    read -p "Select interface: " iface
    case $iface in 
        1) run_wlan0 ;;
        2) run_wlan1 ;;
        3) exit ;;
        *) printf "Bad number! Try again..." && sleep 3 && interface ;;
    esac
}

run_wlan0()
{
    clear
    printf "Starting nexmon on wlan0...\n"
	sleep 1
	. monstart-nh
	printf "Launching wifite...\n"
	sleep 1
	wifite -i wlan0
	printf "\nStopping nexmon on wlan0...\n"
	sleep 1
	. monstop-nh
}

run_wlan1()
{
        clear
	printf "Turning on wlan1...\n"
	sleep 1
        ifconfig wlan1 up
        printf "Launching wifite...\n"
        sleep 1
	wifite -i wlan1
        printf "Turning off wlan1...\n"
        sleep 1
        ifconfig wlan1 down
}

########## RUN SCRIPT ##########

interface
