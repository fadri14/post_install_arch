# post_install_arch
Ce répôt stock toutes les étapes à faire pour compléter une installation de arch

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

