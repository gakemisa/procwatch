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
    echo "Choix invalide!!"
    echo "Votre choix doit etre entre 0 a 9."

elif [ $choix -eq 1 ]; then # 1
    ps aux --sort=-%cpu | head -n 11

elif [ $choix -eq 2 ]; then # 2
    ps aux --sort=-%mem | head -n 11

elif [ $choix -eq 3 ]; then # 3
    echo "Rechercher un processus par nom" 
    echo "Inserer le NOM du processus : "
    read processus 
    if ! pgrep "$processus"; then
        echo "Processus $processus introuvable !"
    else
        pgrep -a $processus 
    fi

elif [ $choix -eq 4 ]; then # 4
    echo "Afficher les processus d'un utilisateur"
    echo "Inserer le nom de l'utilisateur : "
    read utilisateur
    result=$(grep $utilisateur /etc/passwd)
    # echo $result
    if [ -z "$result" ]; then
        echo "L'utilisateur $utilisateur n'existe pas."
    elif [ -n "$result" ]; then
        ps -u $utilisateur -f
    fi

elif [ $choix -eq 5 ]; then # 5
    echo "Inserer le PID du processus : "
    read pid
    if [ -z "$pid" ]; then
        echo "Processus $pid inexistant"
    elif [ ! -d "/proc/$pid" ]; then
        echo "$pid inexistant"
    elif [ "$pid" = "" ]; then
            echo "PID vide"
    else
        kill -SIGTERM $pid
    fi

elif [ $choix -eq 6 ]; then # 6
    echo "Inserer le PID du processus : "
    read pid
    if [ -z "$pid" ]; then
        echo "Processus $pid inexistant"
    elif [ ! -d "/proc/$pid" ]; then
        echo "Processus $pid inexistant"
    elif [ "$pid" = "" ]; then
        echo "PID vide"
    elif [ $pid != "" ]; then
        echo "Etes-vous sure de forcer l'arret du processus $pid ? O/n"
        read reponse
        if [ $reponse != "O" ] && [ $reponse != "o" ]; then
            echo "Commande echouer"
        elif [ $reponse -eq "O" ] && [ $reponse -eq "o" ]; then
            kill -SIGKILL $pid
        fi
    fi

elif [ $choix -eq 7 ]; then # 7
    echo "Inserer le PID du processus : "
    read pid
    if [ -z "$pid" ]; then
        echo "Processus $pid inexistant"
    elif [ ! -d "/proc/$pid" ]; then
        echo "Processus $pid inexistant"
    elif [ "$pid" = "" ]; then
        echo "PID vide"
    elif [ $pid != "" ]; then
        echo "Valeur: "
        read valeur
        if [ $valeur -lt -20 ] || [ $valeur -gt 19 ]; then
            echo "valeur nice invalide"
        else
            renice $valeur -p $pid
        fi
    fi

elif [ $choix -eq 8 ]; then
    echo "exit"
fi
 

