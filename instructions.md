# Projet : Script de Configuration Automatisée pour Machine Linux
Objectifs:
- Créer un script Bash pour permettre aux utilisateurs de configurer automatiquement une machine Linux.
- Ce script doit permettre aux utilisateurs de :  
    - personnaliser facilement le nom d'hôte
    - de créer des utilisateurs
    - d'installer des logiciels 
    - de configurer les paramètres réseau (Bonus).

# Cahier des chargesS
- ✅Le script doit afficher un menu avec les options suivantes :
- ✅Configuration du nom d'hôte.
- ✅Création d'un nouvel utilisateur.
- ✅Installation de logiciels.
- 🔥Configuration réseau (objectif bonus).
- ✅Quitter.

## Configuration du Nom d'Hôte
Permet à l'utilisateur de spécifier un nouveau nom d'hôte pour la machine.
Le script met à jour le nom d'hôte de la machine avec la nouvelle valeur.

## Création d'un Nouvel Utilisateur
Permet à l'utilisateur de spécifier le nom et le mot de passe d'un nouvel utilisateur.
Le script crée un nouvel utilisateur avec les informations fournies.

## Installation de Logiciels
Permet à l'utilisateur de spécifier les noms des logiciels à installer (par exemple, Apache, MySQL, PHP).
Le script utilise le gestionnaire de paquets de la distribution Linux pour installer les logiciels demandés.

## Configuration Réseau (Bonus)
Cette fonctionnalité, en tant qu’objectif bonus, permet à l’utilisateur de configurer les paramètres réseau de la machine.

# Gestion des Erreurs
Gère les erreurs telles que la saisie incorrecte d'options ou de valeurs.
Affiche des messages d'erreur et d'information clairs et informatifs.

# Livrables
Un script Bash fonctionnel.
Un guide d'utilisation pour les utilisateurs finaux.

# Contraintes
Le script doit être développé en Bash.
Il doit être testé et fonctionner sous un environnement Linux.
Le script doit être documenté avec des commentaires expliquant chaque section du code.
