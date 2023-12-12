#!/bin/bash
##! VARIABLES
# Ajout des variables de couleur
blue='\033[0;34m'
cyan='\033[0;36m'
green='\033[0;32m'
magenta='\033[0;35m'
red='\033[0;31m'
yellow='\033[0;33m'
# Couleur standard
clear='\033[0m'

##! FONCTIONS PERSONNALISEES
# Demander confirmation avant de passer à la suite
pause(){
  printf "Appuyez sur la touche ${yellow}[Entrée]${clear} pour $1..."
  read fackEnterKey
}

# Afficher le menu 
show_menu()
{	
    clear
	printf "${blue}~~~~~~~~~~~~~~~~~~~~~~~~~~~${clear}\n"
	printf "${cyan}Menu Principal${clear}\n"
	printf "${blue}~~~~~~~~~~~~~~~~~~~~~~~~~~~${clear}\n"
	printf "${cyan}1${blue}.${clear} Configurer le nom d'hôte\n"
	printf "${cyan}2${blue}.${clear} Ajouter un utilisateur\n"
	printf "${cyan}3${blue}.${clear} Ajouter un logiciel\n"
	printf "${cyan}4${blue}.${clear} Configurer le réseau\n"
	printf "${cyan}5${blue}.${clear} Quitter\n"
}

# Option 1: editer le nom d'hote
edit_hostname()
{
    #Début de la fonction
    printf "${cyan}Configuration du nom d'hôte${clear}\n"
    pause "continuer"
    # Aller chercher le nom d'hôte actuel et le print
    printf "Votre nom d'hôte est : ${green}$(hostnamectl | grep hostname | cut -d':' -f2)${clear}\n"
    # Demande de saisie utlisateur
    printf "Entrez votre nouveau nom d'hôte : "
    read new_hostname
    # Remplacer les espaces par des dash
    cleared_hostname=$(echo $new_hostname | sed 's/\s\+/-/')
    # Demande de confirmation
    printf "Voulez vous définir ${magenta}$cleared_hostname${clear} comme nouveau nom d'hôte ? ${green}Y${clear}/${red}N${clear} : "
    read validation
    case $validation in
    # Execution de la commande d'ajout
    [Yy]* )
        hostnamectl set-hostname $cleared_hostname && printf "Votre nom d'hôte à bien été mis à jour\n" || printf "Une erreur est survenue lors de la mise à jour\n"
        pause "revenir au menu principal"
    ;;
    # Annulation et retour au menu
    * )
        echo "Annulation du changement"
        pause "revenir au menu principal"
    esac
}

# Option 2: ajouter un utilisateur
add_user()
{
    # Début de la fonction
    printf "${cyan}Ajout d'un nouvel utilisateur${clear}\n"
    pause "continuer"
    # Demande de saisie utilisateur
    printf "Saisissez le nom du nouvel utilisateur : "
    read user_name
    # Passage en minuscules et sans espaces de l'entrée
    user_name_lowercase=$(echo ${user_name,,} | sed 's/\s\+/-/')
    printf "Vous allez créer l'utilisateur ${green}$user_name_lowercase${clear} \n"
    pause "valider"
    # Vérification de la présence de l'utilisateur sur le système
    if grep -q "^$user_name_lowercase" /etc/passwd
    # S'il est présent : Annulation et retour au menu
    then
        printf "L'utilisateur existe déjà\n"
        pause "revenir au menu principal"
    # S'il n'est pas présent, poursuite de l'exécution
    else
        # Demande de saisie utilisateur
        printf "Saisissez le mot de passe du nouvel utilisateur :\n"
        read -s user_password
        # Demande de saisie utilisateur pour vérification
        printf "Confirmez le mot de passe :\n"
        read -s user_passwordcheck
        # Évaluation des deux saisies
        if [ "$user_password" = "$user_passwordcheck" ]
        then
            # Ajout de l'utilisateur et attribution du mot de passe
            adduser $user_name --gecos "Prenom Nom,Adresse,Tel travail,Tel perso" --disabled-password
            echo "$user_name:$user_password" | chpasswd
            # Retour d'action réalisée
            printf "L'utilisateur ${green}$user_name_lowercase${clear} à bien été créé\n"
            pause "revenir au menu principal"
        else
            # Fin de l'exécution et retour au menu
            printf "Les mots de passe ne coresspondent pas\n"
            pause "revenir au menu principal"
        fi
    fi
}

# Option 3: ajouter un logiciel
add_apt()
{   
    # Début de la fonction
    printf "${cyan}Ajout de paquets${clear}\n"
    pause "continuer"
    # Vérification de la présence de mises à jour pour les paquets déjà installés
    printf "${green}Mise à jour des dépôts${clear}\n"
    apt update
    # Installation des mises à jour nécéssaires
    printf "${green}Installation des mises à jours${clear}\n"
    apt upgrade -y
    # Demande de saisie utilisateur
    printf "${green}Le système est prêt à recevoir des nouveaux paquets\nQue souhaitez vous installer ?${clear}\n"
    read package
    # installation du paquet saisi
    apt install $package
    printf "${green}$package à bien été installé${clear}\n"
    pause "revenir au menu principal"
}

# Option 4: configurer le réseau
edit_network()
{
    echo "Configuration du réseau"
    pause
}

# Lire la sélection
read_option()
{
    # Demande de saisie utilisateur
	printf "\nChoisissez une option ${blue}[ ${cyan}1 ${blue}- ${cyan}5 ${blue}] ${clear}: "
    read option
    # Options executant les fonctions pré-écrites correspondantes
	case $option in
		1) edit_hostname ;;
		2) add_user ;;
		3) add_apt ;;
		4) edit_network ;;
		5) printf "${red}Arret du script${clear}\n" ; exit 0 ;;
		*) echo "Selection invalide"; pause "revenir au menu principal"
	esac
}

##! SCRIPT
# Vérification de l'exécution du script en tant que root
if [ $(id -u) -eq 0 ]
# Si oui lance la boucle de traitement
then
    while true
    do
	    show_menu
	    read_option	
    done
# Si non message d'erreur et fin du script
else
    printf "Ce script nécéssite les ${red}privilèges administrateurs${clear}, relancez le avec ${green}sudo${clear}\n"
    exit 2
fi