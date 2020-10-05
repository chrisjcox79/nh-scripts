#!/bin/bash

##########################################
#  NetHunter Hydra user-fiendly script   #
#       SSH Bruteforce only for now!     #
##########################################


hydra_check(){
    command -v hydra >/dev/null 2>&1 || { clear; printf >&2 "THC-Hydra\e[91m is not installed!\n\e[0m"; hydra_install;exit; }
}

hydra_install(){
    read -p "[*] Install hydra? (Y/n): "  install
    case $install in
        [yY][eE][sS]|[yY])
            clear
            printf "\e[92m[*] Installing...\n\e[0m"
            apt-get update
            apt-get install hydra -y
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

menu(){
    clear
    printf "[*] Welcome to THC-Hydra\n\n"
    printf "[*] You can setup ssh bruteforce here\n\n"
    
    username(){
        read -p "[?] Username: " username
        if [ -z $username ]; then printf "\n[!] Username cannot be empty! Try again...\n"; sleep 2; username; fi
    }
    
    ip_f(){
        read -p "[?] Target IP addres: " setip
        if [ -z $setip ]; then printf "\n[!] IP cannot be empty! Try again...\n"; sleep 2; setip; fi
    }
    
    wordlist(){
        read -p "[*] Use default wordlist? (Y/n): " def
        case $def in
            [yY][eE][sS]|[yY])
                wordlist="/root/nh-scripts/default-ssh.txt"
                ;;
            [nN][oO]|[nN])
                printf "\n"
                read -p "[?] Wordlist path: " wordlist
                ;;
            *)
                printf "\n[!] Wrong answer! Try again...\n"; sleep 2; wordlist ;;
        esac
    }
    
    start()
    {
        printf "\n[*] Setup done!\n\n"
        read -p "Start attack (Y/n): " startattack
        case $startattack in
            [yY][eE][sS]|[yY])
                printf "\n\nTarget = $setip\nUsername = $username\nWordlist = $wordlist\n\nLaunching Hydra...\n\n"; sleep 2; hydra -l $username -P $wordlist $ip_f ssh ;;
            [nN][oO]|[nN])
                printf "\n\n"
                exit
                ;;
            *)
                printf "\n[!] Wrong answer! Try again...\n"; sleep 2; start ;;
        esac
    }
    
}

#start#
hydra_check
menu
ip_f
username
wordlist
start
