# post_install_arch
Ce répôt stock toutes les étapes à faire pour compléter une installation de arch

## Installer les fonts
Les télécharger
```wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Hack.zip```

Créer le dossier des fonts s'il n'existe pas
`mkdir -p ~/.local/share/fonts`

Dézipper les fonts dans le dossier que l'on vient de créer
`unzip Hack.zip -d ~/.local/share/fonts`

Effacer les zip télécharger
`rm -fr Hack.zip`
