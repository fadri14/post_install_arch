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

## Décompresser l'archive
- Installer zip et unzip
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
- Déplacer les fichiers de configuration dans $HOME/.config
- Relancer le config de sway

```
mv -f ~/Téléchargements/post_install_arch-main/myconfig/* $HOME/.config
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

## Zsh

### Réinstaller enhancd pour zsh
(à vérifier)
- Éfface l'ancien
- Retélécharge le nouveau

```
rm -fr ~/.oh-my-zsh/custom/plugins/enhancd
$ git clone https://github.com/b4b4r07/enhancd.git $ZSH_CUSTOM/plugins/enhancd
```

### Changer de shell
- Choisis zsh comme shell par défaut

```
chsh -s /bin/zsh $USER
```

## Configuration de pacman
- Active la couleur
- Active le mode verbeux
- Active le téléchargement en parallèle

```
sudo sed -i "34 s/.*/Color/" /etc/pacman.conf
sudo sed -i "37 s/.*/VerbosePkgLists/" /etc/pacman.conf
sudo sed -i "38 s/.*/ParallelDownloads = 5\n/" /etc/pacman.conf
sudo sed -i 's/#MAKEFLAGS=\"-j2\"/MAKEFLAGS=\"-j\$(nproc)\"/' /etc/makepkg.conf" "Enabling multithread compilation
```

## Gérer la cache de pacman
(voir pour changer les paramètres du timer)
- Active le timer de paccache

```
sudo systemctl enable --now paccache.timer
```

## Mettre à jour les mirroirs
- Mets à jour les meilleurs dépôts miroirs
- Active le timer de reflector pour mettre à jour chaque semaine

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

