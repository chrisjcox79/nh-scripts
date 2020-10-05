#!/bin/bash

banner(){
    printf "[+]==================================================================[+]"
    printf "\e[100m"
    cat Logo.txt
    printf "\e[0m"
    printf "\n[+]==================================================================[+]\n\n"
}

clear
banner
printf "1. wlan0 (NeXus5 WiFi)\n"
pri

read -p "Select (1-3) ====> " mi
case $mi in
    
