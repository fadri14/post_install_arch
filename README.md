# post_install_arch
Ce répôt stock toutes les étapes à faire pour finaliser ma config sur arch
linux avec sway.

## Configurer le clavier de sway

- créer le dossier de config
- écrire un fichier de config de base pour changer le clavier
- relancer la config de sway

```
mkdir -p ~/.config/sway
echo '
input * {
    xkb_layout "fr"
    xkb_variant "bepo"
    xkb_numlock enabled
    dwt enabled # suivre le doigt de manière plus précise
    tap enabled # activer la tape rapide
    natural_scroll enabled # activer le défilement naturelle (si haut alors bas)
    middle_emulation enabled # activer l'émulation du bouton du milieu
    xkb_options altwin:swap_lalt_lwin,caps:swapescape
}
' >> ~/.config/sway/config
swaymsg reload
```

## Création des répertoires par défauts
- Mettre à jour les répertoires utilisateurs

```
xdg-user-dirs-update
```

## Décompresser l'archive
- Installer zip et unzip
- Se déplacer dans les téléchargements
- Décompresser l'archive
- La supprimer

```
sudo pacman -S zip unzip
cd ~/Téléchargements
unzip post_install_arch-main.zip
rm -fr post_install_arch-main.zip
```

## Installation de yay
(Je suppose que base-devel est installé)
- Cloner le répôt
- Se déplacer dedans
- Le compiler

```
git clone https://aur.archlinux.org/yay.git
cd ~/Téléchargements/yay
makepkg -si
```

## Installer le répôt flathub
- Ajouter le répôt flathub à la liste des répôts de flatpak

```
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

## Prérequis pour fusuma
- S'ajouter au groupe input

```
sudo gpasswd -a $USER input
newgrp input
```

## Installer tous les programmes souhaités

```
cd ~/Téléchargements/post_install_arch
chmod +x install_package_arch
sudo ./install_package_arch
```

## Déplacer les fichiers de configuration
- Déplacer les fichiers de configuration dans ~/.config
- Relancer le config de sway

```
mv -f ~/Téléchargements/post_install_arch-main/myconfig/* ~/.config
swaymsg reload
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

## Activer l'autologin de sddm
- Créer le dossier de config de sddm s'il n'existe pas
- Créer un fichier de configuration pour se connecter automatiquement

Notez qu'il choisira l'utilisateur actuel ainsi que la session actuelle

```
mkdir /etc/sddm.conf.d
echo "
[Autologin]
User=$USER
Session=$XDG_SESSION_DESKTOP" > /etc/sddm.conf.d/autologin.conf
```

## Ajouter batteriecheck dans cron
(Vérifier que son démon est en cours)
- Entrer dans le fichier de config de cron
Copier la ligne suivante:
`*/2 * * * * /home/adrien/script/batteriecheck`

```
crontab -e
```

## Ajouter trashTmp dans anacron
(Vérifier le fonctionnement)
- Créer la poubelle
- Écrire la config pour trashTmp dans anacrontab

```
mkdir ~/.Trash
sudo echo "
1       5       empty_trash     /home/adrien/script/trashTmp" >> /etc/anacrontab
```

## Zsh

### Changer de shell
- Choisir zsh comme shell par défaut

```
chsh -s /bin/zsh $USER
```

### Installation de oh-my-zsh
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
- Relancer l'envirronement de zsh
- Relancer la config de zsh

```
echo "source ~/.config/myzshrc" > ~/.zshrc
echo "
export NUMBERTHEME=7
source $HOME/.config/mythemes/Dhiver_spatial
" > ~/.zshenv
source ~/.zshenv
source ~/.zshrc
```

### Installer enhancd pour zsh
- Cloner le répôt dans les plugins customs de zsh

```
$ git clone https://github.com/b4b4r07/enhancd.git $ZSH_CUSTOM/plugins/enhancd
```

## Configuration de pacman
- Activer la couleur
- Activer le mode verbeux
- Activer le téléchargement en parallèle

```
sudo sed -i "34 s/.*/Color/" /etc/pacman.conf
sudo sed -i "37 s/.*/VerbosePkgLists/" /etc/pacman.conf
sudo sed -i "38 s/.*/ParallelDownloads = 5\n/" /etc/pacman.conf
sudo sed -i 's/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j\$(nproc)\"/' /etc/makepkg.conf" "Enabling multithread compilation
```

## Gérer la cache de pacman
(Vérifier la ligne où se trouve ExecStart)
- Changer la commande pour ne garder que 1 version antérieure et supprimer la cache des paquets désinstallés
- Activer le timer de paccache

```
#sudo sed -i "n s/.*/ExecStart=/usr/bin/paccache -rk1 ; /usr/bin/paccache -ruk0/" /etc/systemd/system/paccache.service.d/override.conf
sudo systemctl enable --now paccache.timer
```

## Mettre à jour les mirroirs
- Mettre à jour les meilleurs dépôts miroirs
- Activer le timer de reflector pour mettre à jour chaque semaine

```
reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist
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
sudo echo "GRUB_TIMEOUT_STYLE=hidden" >> /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

## Activation du pare-feu
- Autoriser les connections http
- Autoriser les connections https$
- Autoriser les connections ssh
- Activer le pare-feu
- Activer le service du pare-feu

```
sudo ufw allow http
sudo ufw allow https
sudo ufw allow ssh
sudo ufw enable
sudo systemctl enable ufw.service
```

