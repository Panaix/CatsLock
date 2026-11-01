# CatsLock — Français

[Choisir une autre langue](../../README.md)

CatsLock est une application macOS qui verrouille temporairement le clavier et
détecte les frappes rapides accidentelles. L’interface est disponible en
russe, anglais, allemand, espagnol, français, chinois et japonais.

## Configuration requise

- macOS 13 ou version ultérieure.
- Mac avec processeur Intel ou Apple silicon.

## Installation

Téléchargez [CatsLock-Installer.dmg](https://github.com/Panaix/CatsLock/releases/latest),
ouvrez l’image et faites glisser CatsLock dans le dossier Applications. Au
premier lancement, autorisez l’accès dans **Réglages Système → Confidentialité
et sécurité → Accessibilité**. CatsLock a besoin de cette autorisation pour
traiter les événements clavier et bloquer les frappes pendant le verrouillage.

L’installateur actuel est signé ad hoc et n’est pas notarié par Apple. macOS
peut afficher un avertissement Gatekeeper.

## Confidentialité et sécurité

CatsLock traite les événements clavier localement. Les codes des touches et
leurs horaires sont conservés temporairement dans la mémoire du processus afin
de détecter les frappes rapides. L’application n’enregistre pas le texte saisi,
ne stocke pas l’historique des touches sur le disque et n’envoie pas
d’événements clavier sur le réseau. Les réglages sont conservés localement dans
`UserDefaults` ; macOS distribue les notifications. Il n’y a ni analyse ni
télémétrie.

Signalez les vulnérabilités via le
[canal privé de sécurité GitHub](https://github.com/Panaix/CatsLock/security/advisories/new),
et non dans une Issue publique. N’incluez ni mot de passe, ni donnée personnelle,
ni texte saisi. Consultez la [politique de sécurité](../../SECURITY.md).

## Compiler depuis les sources

Installez les outils de ligne de commande Xcode, puis exécutez :

```sh
xcode-select --install
./scripts/build-release.sh
```

Le script crée une application Universal Binary et un installateur dans `build/`.
Définissez la version avec `VERSION` et `BUILD_NUMBER`. La signature Developer
ID et la notarisation Apple nécessitent un certificat Apple Developer et ne sont
pas encore configurées.

## Raccourcis clavier

- `Control + Option + L` — activer ou désactiver le verrouillage.
- `Control + Option + Escape` — déverrouillage d’urgence.

## Contribution

Utilisez les [formulaires d’Issues](https://github.com/Panaix/CatsLock/issues/new/choose)
pour signaler un problème ou proposer une amélioration. Les pull requests
doivent décrire le changement et sa vérification. Consultez le
[guide de contribution](../../CONTRIBUTING.md).

## Licence

MIT. Le texte juridiquement applicable est le fichier [LICENSE](../../LICENSE)
en anglais.
