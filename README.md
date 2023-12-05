# post_install_arch
Ce répôt stock toutes les étapes à faire pour compléter une installation de arch

## Copier la config de base de sway
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
' > ~/.config/sway/config
swaymsg reload
```

## Installer les fonts
- Les télécharger.
- Créer le dossier des fonts s'il n'existe pas.
- Dézipper les fonts dans le dossier que l'on vient de créer.
- Effacer les zip télécharger.

```
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Hack.zip
mkdir -p ~/.local/share/fonts
unzip Hack.zip -d ~/.local/share/fonts
rm -fr Hack.zip
```

## Créer un lien vers le thème de zsh

```
ln .oh-my-zsh/themes/agnoster.zsh-theme ~/agnoster.zsh-theme
```

