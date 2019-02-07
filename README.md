# Présentation

L'objectif de ce projet est de permettre la construction automatisée de VM pour les formations. Il s'appuie sur 
Packer et VirtualBox pour créer les VM, et sur Ansible pour automatiser la configuration.

# Organisation du dépôt

Le dépôt git [images-academie](https://github.com/valeuriad-techlab/images-academie) contient :

  * TODO

# Prérequis

## Sous Windows

### (Windows) Etape 1 : installer VirtualBox

Installez manuellement VirtualBox pour votre utilisateur. Vous aurez probablement besoin des droits d'administration
du poste. Les binaires d'installation sont disponible [sous forme d'exécutable](https://download.virtualbox.org/virtualbox/6.0.4/VirtualBox-6.0.4-128413-Win.exe)
sur [le site de VirtualBox](https://www.virtualbox.org/wiki/Downloads).

### (Windows) Etape 2 : Installer Git Bash et cloner le projet

Même si vous clonez le projet via un autre moyen, vous aurez probablement besoin de Git Bash pour obtenir une invite
de commande facile à utiliser pour exécuter les commandes Packer. Vous pouvez télécharger Git Bash sur le [site officiel](https://git-scm.com/download/win).

### (Windows) Etape 3 : télécharger le binaire Packer

Vous pouvez télécharger le binaire depuis le [site officiel Packer](https://releases.hashicorp.com/packer/).

Il s'agit d'un ZIP contenant un fichier `packer.exe`. Vous avez deux possibilités :
  1. installer cet exécutable où vous le souhaitez sur la machine et l'ajouter à votre PATH ;
  2. **ou bien** installer cet exécutable dans le répertoire `packer` du projet Git après l'avoir cloné.

## Sous Linux

### (Linux) Etape 1 : installer Ansible et Git

Vous pouvez installer Ansible depuis vos dépôts de paquets habituels. Par exemple pour CentOS/RHEL :

    yum install ansible git
    
### (Linux) Etape 2 : clone le projet Git et exécuter le playbook d'installation de VirtualBox et de Packer

Le playbook est disponible dans le dossier `ansible`, et il s'exécute de la manière suivante :

    ansible-playbook -K LINUX_install-packer-and-virtualbox.yml
    
Vous pourrez alors utiliser l'utilisateur `packer` créé par le playbook pour générer des VM, ou bien votre
propre utilisateur à condition de vous inscrire dans le groupe `packer` de la manière suivante :

    usermod -a -G packer $(whoami)

# Comment builder une VM CentOS 7 basique ?

  1. Se positionner dans le répertoire `packer` du projet
  2. Exécuter la commande `./validate.sh` pour vérifier le format du fichier *Kickstart* `anaconda-ks.cfg`
     et du fichier *Packer* `CentOS-7-x86_64.json`
  3. Exécuter le build packer à l'aide de la commande `packer build CentOS-7-x86_64.json` (exécutable présent
     dans le PATH) ou bien `./packer build CentOS-7-x86_64.json` (exécutable dans le répertoire)

# Références documentaires :

  1. [Fichier `.repo` pour installer VirtualBox sous Linux](https://www.virtualbox.org/wiki/Linux_Downloads)
  2. [Documentation du builder `virtualbox-iso` pour Packer](https://www.packer.io/docs/builders/virtualbox-iso.html)
  3. [Documentation du format de fichier `kickstart` pour CentOS/RHEL 7](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/installation_guide/sect-kickstart-syntax)
  4. [Options pour le boot de l'installeur `anaconda`](https://anaconda-installer.readthedocs.io/en/latest/boot-options.html)
