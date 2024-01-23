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

## Changer les mot de passes
- Changer le mot de passe utilisateur
- Donner un mot de passe à root

```
passwd
```

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
- Décompresser l'archive dans le home
- La supprimer
- Se déplacer dans le home

```
sudo pacman --noconfirm -S zip unzip git
cd ~/Téléchargements
unzip post_install_arch-main.zip -d ~
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
cd yay
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
sudo gpasswd -a $USER video
sudo gpasswd -a $USER audio
```

## Installer fusuma
- Installer ruby pour utiliser gem
- Installer fusuma
- Déplacer l'exécutable

```
sudo pacman -Syu ruby
gem install fusuma
mv ~/.local/share/gem/ruby/3.0.0/bin/fusuma /usr/local/bin
```

## Installer tous les programmes souhaités

### Avec pacman

- Se déplacer dans le dossier de post installation
- Lancer le script pour installer les paquets

```
cd ~/post_install_arch-main
sudo ./install_package_arch
```

### Avec yay
- Installation des paquets suivants
    - wlsunset
    - light
    - signal-desktop
    - librewolf-bin
    - texstudio
    - melonds
    - flashfocus
    - swayfx
    - arch-update
    - pacman-contrib
    - downgrade
    - workstyle-git
    - todoist-appimage
    - netflix
    - freetube
    - grimshot
    - pdfsam
    - ventoy
    - timeshift
    - timeshift-autosnap

```
yay -S wlsunset
```
```
yay -S light
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
yay -S melonds
```
```
yay -S flashfocus
```
```
yay -S swayfx
```
```
yay -S arch-update
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
```
yay -S todoist-appimage
```
```
yay -S netflix
```
```
yay -S freetube
```
```
yay -S grimshot
```
```
yay -S pdfsam
```
```
yay -S ventoy
```
```
yay -S timeshift
```
```
yay -S timeshift-autosnap
```

## Installer les fonts
- Les télécharger.
- Créer le dossier des fonts s'il n'existe pas.
- Dézipper les fonts dans le dossier que l'on vient de créer.
- Éffacer les zips téléchargés.
- Supprimer la license des fonts
- Supprimer le readme des fonts

```
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Hack.zip
mkdir -p ~/.local/share/fonts
unzip Hack.zip -d ~/.local/share/fonts
rm -fr Hack.zip
rm ~/.local/share/fonts/LICENSE.md
rm ~/.local/share/fonts/README.md
```

## Déplacer les fichiers de configuration
- Supprimer le dossier de config de sway
- Déplacer les fichiers de configuration dans ~/.config

```
rm -fr ~/.config/sway
mv -f ~/post_install_arch-main/myconfig/* ~/.config
```

## Activer l'autologin de sddm
- Créer le dossier de config de sddm s'il n'existe pas
- Créer un fichier de configuration pour se connecter automatiquement

Notez qu'il choisira l'utilisateur actuel ainsi que la session actuelle

```
sudo mkdir /etc/sddm.conf.d
sudo -E bash -c 'echo "
[Autologin]
User=$USER
Session=$XDG_SESSION_DESKTOP" > /etc/sddm.conf.d/autologin.conf'
```

## Initialisation de la zram
- Se déplacer dans les scripts
- Lancer l'installation du service pour zram

```
cd ~/.config/myscripts
sudo ./install_zram_state
```

## Configurer timeshift
- Créer un premier instantané
- Modifier les paramètres de grub
- Mettre à jour la config de grub
- Activer le service de grub-btrfs

```
sudo timeshift --create
sudo sed -i 's|ExecStart=/usr/bin/grub-btrfsd --syslog /.snapshots|ExecStart=/usr/bin/grub-btrfsd --syslog --timeshift-auto|' /usr/lib/systemd/system/grub-btrfsd.service
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo systemctl enable --now grub-btrfsd
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

## Installer les plugins de neovim
- Ouvrir le ficher packer

```
nvim ~/.config/nvim/lua/adrien-config/packer.lua
```

## Configuration de pacman
- Activer la couleur
- Activer le mode verbeux
- Activer le téléchargement en parallèle
- Définir le nombre de processeur à utiliser

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

## Les hooks pour grub
- Créer un hook pour mettre à jour l'installation de grub
- Créer un hook pour mettre à jour la configuration de grub

```
sudo bash -c "echo '[Trigger]
Operation = Upgrade
Type = Package
Target = grub

[Action]
Description = Executing Grub-install...
When = PostTransaction
Exec = /usr/bin/grub-install --target=x86_64-efi --efi-directory=/boot --disable-shim-lock' > /usr/share/libalpm/hooks/99-grub_install.hook"

sudo bash -c "echo '[Trigger]
Operation = Install
Operation = Upgrade
Operation = Remove
Type = File
Target = usr/lib/modules/*/vmlinuz

[Action]
Description = Updating GRUB Config
Depends = grub
When = PostTransaction
Exec = /usr/bin/grub-mkconfig -o /boot/grub/grub.cfg' > /usr/share/libalpm/hooks/99-grub_update_conf.hook"
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
git config --global user.email "fadri1@proton.me"
git config --global user.name "fadri14"
```

## Suppression des paquets inutiles
- Se déplacer dans le répôt
- Exécuter le script

```
cd ~/post_install_arch-main
sudo ./remove_package
```

## Supprimer ce répôt
- Se déplacer dans Téléchargements
- Éffacer le répôt

```
cd ~
rm -fr post_install_arch-main
```

