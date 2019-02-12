# Présentation

L'objectif de ce projet est de permettre la construction automatisée de VM pour les formations. Il s'appuie sur 
Packer et VirtualBox pour créer les VM, et sur Ansible pour automatiser la configuration.

TODO :

  * décliner l'image principale pour faire des images spécialisées pour les stacks techniques des formations

# Organisation du dépôt

Le dépôt git [images-academie](https://github.com/valeuriad-techlab/images-academie) contient :

    │   .gitignore # Configuré pour éviter de publier sur Git les fichiers
    │              # temporaires de Packer, l'exécutable Packer, les fichiers de l'IDE etc.                                   
    │   README.md  # La documentation que vous êtes en train de lire
    │
    ├───doc               # Un répertoire où ranger la documentation complémentaire (notamment pour les personnes formées)
    │       schemas.pptx  # Des diapositives pour expliquer le fonctionnement de Packer en schémas
    │
    └───packer                      # Le répertoire principal du projet
        │   anaconda-ks.cfg         # Un fichier Kickstart pour automatiser la construction d'une VM CentOS 7
        │   CentOS-7-x86_64.json    # Un fichier Packer pour créer une VM CentOS 7 de formation de base
        │   (packer.exe)            # Vous pouvez installer l'exécutable Packer ici, ou bien le mettre sur le PATH
        │   validate.sh             # Un script utilitaire pour vérifier les fichiers Kickstart et Packer
        │
        ├───install
        │       LINUX_install-packer-and-virtualbox.yml  # Un playbook pour automatiser l'installation de
        │                                                # VirtualBox et de Packer sur une machine CentOS/RHEL 7 
        │
        ├───(output-virtualbox-iso) # Le répertoire où Packer publiera la VM une fois buildée
        │       (*.ova)             # Vous pouvez configurer le type OVA pour obtenir des fichiers d'archive de VM
        │
        ├───(packer_cache)          # Le répertoire où Packer téléchargera l'ISO qui sert à construire la VM 
        │       (*.iso)             # Pensez à purger les fichiers ISO dont vous n'avez plus besoin...
        │
        └───provisionning-playbooks # Un répertoire contenant tout le nécessaire pour provisionner correctement la VM
            │   formation.yml       # Le playbook pour une VM de base sans fioritures
            │
            └───roles                  # Les playbooks peuvent s'appuyer sur des rôles standardisés rangés ici
                └───user-formation     # Ce rôle standardise la manière de configurer l'utilisateur de formation
                    └───tasks
                            main.yml

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

Le playbook est disponible dans le dossier `packer/install`, et il s'exécute de la manière suivante :

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
