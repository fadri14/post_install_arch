# post_install_arch
Ce répôt stock toutes les étapes à faire pour compléter une installation de arch

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

## Installer les fonts
- Les télécharger.
- Créer le dossier des fonts s'il n'existe pas.
- Dézipper les fonts dans le dossier que l'on vient de créer.
- Éffacer les zip télécharger.

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

## Réinstaller enhancd pour zsh
- Éfface l'ancien
- Retélécharge le nouveau

```
rm -fr .oh-my-zsh/custom/plugins/enhancd
$ git clone https://github.com/b4b4r07/enhancd.git $ZSH_CUSTOM/plugins/enhancd
```

## Changer de shell
- Choisis zsh comme shell par défaut

```
chsh -s /bin/zsh $USER
```

## Créer un lien vers le thème de zsh

```
ln .oh-my-zsh/themes/agnoster.zsh-theme ~/agnoster.zsh-theme
```

