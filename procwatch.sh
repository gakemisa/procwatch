#!/bin/bash

clear 

echo "===== PROCWATCH ====="
echo "1. Afficher les 10 processus les plus consommateurs de CPU"
echo "2. Afficher les 10 processus les plus consommateurs de memoire"
echo "3. Rechercher un processus par nom"
echo "4. Afficher les processus d'un utilisateur"
echo "5. Arreter proprement un processus"
echo "6. Forcer l'arret d'un processus"
echo "7. Modifier la priorite d'un processus"
echo "8. Quitter"
echo "Choix :"

read choix 

if [ $choix != 1 ] && [ $choix != 2 ] && [ $choix != 3 ] && [ $choix != 4 ] && [ $choix != 5 ] && [ $choix != 6 ] && [ $choix != 7 ] && [ $choix != 8 ]; then
    echo "Choix invalide"

elif [ $choix -eq 1 ]; then # 1
    ps aux --sort=-%cpu | head -n 11

elif [ $choix -eq 2 ]; then # 2
    ps aux --sort=-%mem | head -n 11

elif [ $choix -eq 3 ]; then # 3
    echo "Nom de processus: "
    read processus 
    pgrep -a $processus 

elif [ $choix -eq 4 ]; then # 4
    echo "Nom d'utilisateur: "
    read utilisateur
    result=$(grep $utilisateur /etc/passwd)
    echo $result
    if [ -z "$result" ]; then
        echo "L'utilisateur $utilisateur n'existe pas"
    elif [ -n "$result" ]; then
        ps -u $utilisateur -f
    fi

elif [ $choix -eq 5 ]; then # 5
    echo "Votre PID: "
    read pid
    if [ -z "$pid" ]; then
        echo "$pid inexistant"
    elif [ ! -d "/proc/$pid" ]; then
        echo "$pid inexistant"
    elif [ "$pid" = "" ]; then
            echo "PID vide"
    else
        kill -SIGTERM $pid
    fi

elif [ $choix -eq 6 ]; then # 6
    echo "Votre PID: "
    read pid
    if [ -z "$pid" ]; then
        echo "$pid inexistant"
    elif [ ! -d "/proc/$pid" ]; then
        echo "$pid inexistant"
    elif [ "$pid" = "" ]; then
        echo "PID vide"
    elif [ $pid != "" ]; then
        echo "Etes-vous sure $pid ? O/n"
        read reponse
        if [ $reponse != "O" ] && [ $reponse != "o" ]; then
            echo "Commande echouer"
        elif [ $reponse -eq "O" ] && [ $reponse -eq "o" ]; then
            kill -SIGKILL $pid
        fi
    fi

elif [ $choix -eq 7 ]; then # 7
    echo "Votre PID: "
    read pid
    if [ -z "$pid" ]; then
        echo "$pid inexistant"
    elif [ ! -d "/proc/$pid" ]; then
        echo "$pid inexistant"
    elif [ "$pid" = "" ]; then
        echo "PID vide"
    elif [ $pid != "" ]; then
        echo "Valeur: "
        read valeur
        renice $valeur -p $pid
    fi
    
elif [ $choix -eq 8 ]; then # 8
    echo "exit"
fi
 

