# post_install_arch
Ce répôt stock toutes les étapes à faire pour finaliser ma config sur arch
linux avec sway.

## Configurer le clavier de sway

- Créer le dossier de config
- Écrire un fichier de config de base pour changer le clavier
- Relancer la config de sway

```
mkdir -p ~/.config/sway
echo "
input * {
    xkb_layout 'fr'
    xkb_variant 'bepo'
    xkb_numlock enabled
    dwt enabled # suivre le doigt de manière plus précise
    tap enabled # activer la tape rapide
    natural_scroll enabled # activer le défilement naturelle (si haut alors bas)
    middle_emulation enabled # activer l'émulation du bouton du milieu
    xkb_options altwin:swap_lalt_lwin,caps:swapescape
}
" > ~/.config/sway/config
swaymsg reload
```

## Activer root
- Donner un mot de passe à root pour l'activer

```
sudo passwd root
```

## Création des répertoires par défauts
- Installer le paquet nécessaire
- Mettre à jour les répertoires utilisateurs

```
sudo pacman --noconfirm -S xdg-user-dirs
xdg-user-dirs-update
```

## Décompresser l'archive
(Il faut télécharger l'archive)
- Installer zip et unzip ainsi que git
- Se déplacer dans les téléchargements
- Décompresser l'archive
- La supprimer

```
sudo pacman --noconfirm -S zip unzip git
cd ~/Téléchargements
unzip post_install_arch-main.zip
rm -fr post_install_arch-main.zip
```

## Installation de yay
- Installer le paquet nécessaire à la compilation
- Cloner le répôt
- Se déplacer dedans
- Le compiler
- Sortir du répertoire
- Supprimer le répôt

```
sudo pacman --noconfirm -S base-devel
git clone https://aur.archlinux.org/yay.git
cd ~/Téléchargements/yay
makepkg -si
cd ..
rm -fr yay
```

## Installer le répôt flathub
- Installer flatpak
- Ajouter le répôt flathub à la liste des répôts de flatpak

```
sudo pacman --noconfirm -S flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

## Rejoindre les groupes
- Rejoindre le groupe input
- Rejoindre le groupe video
- Rejoindre le groupe audio

```
sudo gpasswd -a $USER input
newgrp input
sudo gpasswd -a $USER video
newgrp video
sudo gpasswd -a $USER audio
newgrp audio
```

## Installer fusuma
- Installer fusuma
- Déplacer l'exécutable

```
sudo gem install fusuma
mv .local/share/gem/ruby/3.0.0/bin/fusuma /usr/local/bin
```

## Installer tous les programmes souhaités

### Avec pacman

- Se déplacer dans le dossier de post installation
- Lancer le script pour installer les paquets

```
cd ~/Téléchargements/post_install_arch-main
sudo ./install_package_arch
```

### Avec yay
- Installation des paquets suivants
    - wlsunset
    - signal-desktop
    - librewolf-bin
    - texstudio
    - flashfocus
    - swayfx
    - btrfs-assistant
    - pacman-contrib
    - downgrade
    - workstyle-git

```
yay -S wlsunset
```
```
yay -S signal-desktop
```
```
yay -S librewolf-bin
```
```
yay -S texstudio
```
```
yay -S flashfocus
```
```
yay -S swayfx
```
```
yay -S btrfs-assistant
```
```
yay -S pacman-contrib
```
```
yay -S downgrade
```
```
yay -S workstyle-git
```

## Installer les fonts
- Les télécharger.
- Créer le dossier des fonts s'il n'existe pas.
- Dézipper les fonts dans le dossier que l'on vient de créer.
- Éffacer les zips téléchargés.

```
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Hack.zip
mkdir -p ~/.local/share/fonts
unzip Hack.zip -d ~/.local/share/fonts
rm -fr Hack.zip
```

## Déplacer les fichiers de configuration
(Vérifier que ce soit le bon thème et la bonne font.
Peut-être utiliser lxappearance)
- Supprimer le dossier de config de sway
- Déplacer les fichiers de configuration dans ~/.config
- Relancer le config de sway

```
rm -fr ~/.config/sway
mv -f ~/Téléchargements/post_install_arch-main/myconfig/* ~/.config
swaymsg reload
```

## Activer l'autologin de sddm
- Créer le dossier de config de sddm s'il n'existe pas
- Créer un fichier de configuration pour se connecter automatiquement

Notez qu'il choisira l'utilisateur actuel ainsi que la session actuelle

```
mkdir /etc/sddm.conf.d
sudo echo "
[Autologin]
User=$USER
Session=$XDG_SESSION_DESKTOP" > /etc/sddm.conf.d/autologin.conf
```

## C'est ici qu'il faut restaurer les scripts

## Ajouter batteriecheck dans cron
- Activer le démon cronie
- Écrire la config pour batteriecheck dans crontab

```
sudo systemctl enable --now cronie
crontab -e
```
Il faut y copier la ligne ci-dessous
```
*/2 * * * * /home/adrien/script/batteriecheck
```

## Ajouter trashTmp dans anacron
- Créer la poubelle
- Écrire la config pour trashTmp dans anacrontab

```
mkdir ~/.Trash
sudo nvim /etc/anacrontab
```
Il faut y copier la ligne ci-dessous
```
1       5       empty_trash     nice run-parts /home/adrien/script/trashTmp
```

## Installation de mon application time_use
- Se déplacer dans les scripts
- Autoriser le programme se s'exécuter
- Lancer l'installation de time_use

```
cd ~/scripts
chmod +x install_time_use
sudo ./install_time_use
```

## Zsh

### Installation de oh-my-zsh
(Il faut refuser de changer de shell)
- Se déplacer dans le dossier personnel
- Télécharger oh-my-zsh
- Le déplacer dans le fichier de config

```
cd ~
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mv .oh-my-zsh .config/oh-my-zsh
```

### Changer la config de base de zsh
- Dire à zsh que la vrai config est dans myzshrc
- Configurer l'envirronement pour les thèmes

```
echo "source ~/.config/myzshrc" > ~/.zshrc
echo "
export NUMBERTHEME=7
source $HOME/.config/mythemes/Dhiver_spatial
" > ~/.zshenv
```

### Installer les plugins pour zsh
- Définir l'emplacement d'installation
- Cloner enhancd
- Cloner vi mode
- Cloner autosuggestions

```
ZSH_CUSTOM="$HOME/.config/oh-my-zsh/custom"
git clone https://github.com/b4b4r07/enhancd.git $ZSH_CUSTOM/plugins/enhancd
git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
```

### Changer de shell
- Choisir zsh comme shell par défaut

```
chsh -s /bin/zsh $USER
```

## Configuration de pacman
- Activer la couleur
- Activer le mode verbeux
- Activer le téléchargement en parallèle

```
sudo sed -i "34 s/.*/Color/" /etc/pacman.conf
sudo sed -i "37 s/.*/VerbosePkgLists/" /etc/pacman.conf
sudo sed -i "38 s/.*/ParallelDownloads = 5\n/" /etc/pacman.conf
sudo sed -i '49 s/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j\$(nproc)\"/' /etc/makepkg.conf
```

## Gérer la cache de pacman
- Activer le timer de paccache

```
sudo systemctl enable --now paccache.timer
```

## Mettre à jour les mirroirs
- Mettre à jour les meilleurs dépôts miroirs
- Activer le timer de reflector pour mettre à jour chaque semaine

```
sudo reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
sudo systemctl enable --now reflector.service
```

## Bluetooth
- Activer le bluetooth

```
sudo systemctl enable --now  bluetooth.service
```

## Imprimantes
- Activer les démons avahi et cups

```
sudo systemctl enable --now avahi-daemon cups
```

## Supprimer le délai dans grub
- Ajouter une valeur de configuration pour le timer dans grub
- Mettre à jour la configuration de grub

```
sudo sed -i "17 s/.*/GRUB_TIMEOUT_STYLE=hidden/" /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

## Activation du pare-feu
- Mettre la configuration par défaut pour les sorties
- Autoriser les connections https
- Autoriser les connections ssh
- Activer le pare-feu
- Activer le service du pare-feu

```
sudo ufw default allow outgoing
sudo ufw allow https
sudo ufw allow ssh
sudo ufw enable
sudo systemctl enable ufw.service
```

## Configuration pour github

### Configuration de git
- Définir l'adresse mail
- Définir le pseudo

```
git config --global user.email "lebotdufutur@proton.me"
git config --global user.name "fadri14"
```

### Créer la clé ssh pour github
- Créer une clé ssh
- Démarrer l'agent ssh
- Ajouter la nouvelle clé à l'agent ssh
- Afficher la clé publique

```
ssh-keygen -t ed25519 -C "lebotdufutur@proton.me"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
```

## Supprimer ce répôt
- Se déplacer dans Téléchargements
- Éffacer le répôt

```
cd ~/Téléchargements
rm -fr post_install_arch-main
```

