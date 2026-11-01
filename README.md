# PurrLock

Choose a language below to read the complete project description, installation
guide, privacy and security notes, contribution information, and support
options. PurrLock's interface is available in all seven languages listed here.

<details open>
<summary>🇷🇺 Русский</summary>

## PurrLock — защита клавиатуры для macOS

PurrLock — приложение для macOS, которое временно блокирует клавиатуру и
обнаруживает случайные быстрые нажатия. Используйте блокировку, когда нужно
почистить клавиатуру или защитить компьютер от случайного ввода. Приложение
поддерживает Intel и Apple silicon, а интерфейс — русский, английский,
немецкий, испанский, французский, китайский и японский языки.

### Требования

- macOS 13 или новее.
- Mac с процессором Intel или Apple silicon.

### Установка

Скачайте [PurrLock-Installer.dmg](https://github.com/Panaix/PurrLock/releases/latest),
откройте образ и перетащите PurrLock в папку «Программы» (Applications).
При первом запуске разрешите доступ в **Системные настройки → Конфиденциальность
и безопасность → Универсальный доступ**. Это разрешение необходимо для обработки
клавиатурных событий и временного подавления нажатий при блокировке.

Текущий установщик подписан ad hoc и не нотарифицирован Apple. macOS может
показать предупреждение Gatekeeper.

### Конфиденциальность и безопасность

PurrLock обрабатывает события клавиатуры локально. Коды клавиш и время их
поступления временно хранятся в памяти процесса для обнаружения быстрых нажатий.
Приложение не записывает вводимый текст, не сохраняет историю на диск и не
передаёт события клавиатуры по сети. Настройки хранятся локально в
`UserDefaults`; уведомления доставляет macOS. Аналитики и телеметрии нет.

Сообщайте об уязвимостях через
[приватные сообщения GitHub](https://github.com/Panaix/PurrLock/security/advisories/new),
а не в публичном Issue. Не прикладывайте пароли, личные данные или содержимое
клавиатурного ввода. Подробнее — в [политике безопасности](SECURITY.md).

### Сборка из исходников

Установите Xcode Command Line Tools и выполните:

```sh
xcode-select --install
./scripts/build-release.sh
```

Скрипт создаёт Universal Binary и установщик в `build/`. Версию и номер сборки
можно задать через `VERSION` и `BUILD_NUMBER`. Подпись Developer ID и
нотарификация требуют сертификата Apple Developer и пока не настроены.

### Горячие клавиши

- `Control + Option + L` — переключить блокировку клавиатуры.
- `Control + Option + Escape` — аварийная разблокировка.

### Участие в проекте

Используйте [формы GitHub](https://github.com/Panaix/PurrLock/issues/new/choose),
чтобы сообщить об ошибке или предложить улучшение. Pull request должен описывать
изменение и способ его проверки. Подробнее — в
[руководстве участника](CONTRIBUTING.md).

### Лицензия

PurrLock распространяется по лицензии MIT. Юридически значимый текст находится
в английском файле [LICENSE](LICENSE).

## ☕ Поддержать автора

[![Поддержать автора на Boosty](https://img.shields.io/badge/Boosty-%E2%98%95%20%D0%9F%D0%BE%D0%B4%D0%B4%D0%B5%D1%80%D0%B6%D0%B0%D1%82%D1%8C-ff5c8d?style=for-the-badge)](https://boosty.to/panaix/donate)

Пожертвования добровольные и помогают развивать PurrLock. Перед отправкой
криптовалюты внимательно проверьте адрес и сеть: ETH — ERC20, USDT — TRC20.

**BTC**
```
bc1q259xvrs9gvnr7pzyfaswp73harxnl8hyvwwvqw
```

**ETH (ERC20)**
```
0x646378b62c3e32cb293b61ffb1c84244d8d61f69
```

**USDT (TRC20)**
```
TMkG5Y1yxgPLSEegyYeA8pYTmuagPnrxAJ
```

**Monero (XMR)**
```
4HR2jnRAwm3SFP4r8KzxBxESVHKLvZ29Pxz8Qm3uqHY5aD9Kj1De2Y1W8S18fYjh9acS9NkK4VNje5pC2gVq3aYVZzLEtjf8UnUfkuTri
```

</details>

<details>
<summary>🇬🇧 English</summary>

## PurrLock — keyboard protection for macOS

PurrLock is a macOS app that temporarily locks the keyboard and detects
accidental rapid keystrokes. Use the lock while cleaning your keyboard or
preventing unintended input. PurrLock supports Intel and Apple silicon Macs,
and its interface is available in Russian, English, German, Spanish, French,
Chinese, and Japanese.

### Requirements

- macOS 13 or later.
- An Intel or Apple silicon Mac.

### Install

Download [PurrLock-Installer.dmg](https://github.com/Panaix/PurrLock/releases/latest),
open it, and drag PurrLock to Applications. On first launch, grant access under
**System Settings → Privacy & Security → Accessibility**. PurrLock needs this
permission to process keyboard events and suppress key presses while locked.

The current installer is ad hoc signed and not notarized by Apple. macOS may
show a Gatekeeper warning.

### Privacy and security

PurrLock processes keyboard events locally. Key codes and event times are held
temporarily in process memory to detect rapid keystrokes. The app does not
record typed text, store key history on disk, or send keyboard events over the
network. Settings are stored locally in `UserDefaults`; macOS delivers
notifications. There is no analytics or telemetry.

Report vulnerabilities through
[GitHub private vulnerability reporting](https://github.com/Panaix/PurrLock/security/advisories/new),
not a public Issue. Do not include passwords, personal data, or typed content.
See the [security policy](SECURITY.md).

### Build from source

Install Xcode Command Line Tools, then run:

```sh
xcode-select --install
./scripts/build-release.sh
```

The script creates a Universal Binary app and installer in `build/`. Set
`VERSION` and `BUILD_NUMBER` to customize version metadata. Developer ID signing
and Apple notarization require an Apple Developer certificate and are not
configured yet.

### Keyboard shortcuts

- `Control + Option + L` — toggle the keyboard lock.
- `Control + Option + Escape` — emergency unlock.

### Contributing

Use the [GitHub issue forms](https://github.com/Panaix/PurrLock/issues/new/choose)
to report a bug or suggest an improvement. Pull requests should explain the
change and how it was verified. Read the
[contribution guide](CONTRIBUTING.md).

### License

PurrLock is distributed under the MIT License. The legally authoritative text
is the English [LICENSE](LICENSE) file.

## ☕ Support the Author

[![Support the author on Boosty](https://img.shields.io/badge/Boosty-%E2%98%95%20Support-ff5c8d?style=for-the-badge)](https://boosty.to/panaix/donate)

Donations are voluntary and help support PurrLock's development. Before
sending cryptocurrency, carefully verify the address and network: ETH uses
ERC20 and USDT uses TRC20.

**BTC**
```
bc1q259xvrs9gvnr7pzyfaswp73harxnl8hyvwwvqw
```

**ETH (ERC20)**
```
0x646378b62c3e32cb293b61ffb1c84244d8d61f69
```

**USDT (TRC20)**
```
TMkG5Y1yxgPLSEegyYeA8pYTmuagPnrxAJ
```

**Monero (XMR)**
```
4HR2jnRAwm3SFP4r8KzxBxESVHKLvZ29Pxz8Qm3uqHY5aD9Kj1De2Y1W8S18fYjh9acS9NkK4VNje5pC2gVq3aYVZzLEtjf8UnUfkuTri
```

</details>

<details>
<summary>🇩🇪 Deutsch</summary>

## PurrLock — Tastaturschutz für macOS

PurrLock ist eine macOS-App, die die Tastatur vorübergehend sperrt und
versehentlich schnelle Tastenanschläge erkennt. Verwenden Sie die Sperre beim
Reinigen der Tastatur oder um unbeabsichtigte Eingaben zu verhindern. PurrLock
unterstützt Intel- und Apple-Silicon-Macs. Die Oberfläche ist auf Russisch,
Englisch, Deutsch, Spanisch, Französisch, Chinesisch und Japanisch verfügbar.

### Voraussetzungen

- macOS 13 oder neuer.
- Mac mit Intel- oder Apple-Silicon-Prozessor.

### Installation

Laden Sie [PurrLock-Installer.dmg](https://github.com/Panaix/PurrLock/releases/latest)
herunter, öffnen Sie das Image und ziehen Sie PurrLock in den Ordner Programme.
Erlauben Sie beim ersten Start den Zugriff unter **Systemeinstellungen →
Datenschutz & Sicherheit → Bedienungshilfen**. PurrLock benötigt diese
Berechtigung, um Tastaturereignisse zu verarbeiten und Tasten während der
Sperre zu unterdrücken.

Der aktuelle Installer ist ad hoc signiert und nicht von Apple notariell
beglaubigt. macOS kann eine Gatekeeper-Warnung anzeigen.

### Datenschutz und Sicherheit

PurrLock verarbeitet Tastaturereignisse lokal. Tastencodes und Zeitpunkte
werden zur Erkennung schneller Eingaben vorübergehend im Arbeitsspeicher des
Prozesses gehalten. Die App zeichnet keinen eingegebenen Text auf, speichert
keinen Tastenverlauf auf dem Datenträger und überträgt keine Tastaturereignisse
über das Netzwerk. Einstellungen werden lokal in `UserDefaults` gespeichert;
Benachrichtigungen stellt macOS zu. Es gibt keine Analyse oder Telemetrie.

Melden Sie Sicherheitslücken über
[private Sicherheitsmeldungen auf GitHub](https://github.com/Panaix/PurrLock/security/advisories/new),
nicht über ein öffentliches Issue. Fügen Sie keine Passwörter, persönlichen
Daten oder eingegebenen Inhalte bei. Weitere Informationen finden Sie in der
[Sicherheitsrichtlinie](SECURITY.md).

### Aus dem Quellcode erstellen

Installieren Sie die Xcode Command Line Tools und führen Sie anschließend aus:

```sh
xcode-select --install
./scripts/build-release.sh
```

Das Skript erstellt eine Universal-Binary-App und einen Installer in `build/`.
Die Versionsdaten lassen sich mit `VERSION` und `BUILD_NUMBER` festlegen.
Developer-ID-Signierung und Apple-Notarisierung benötigen ein Apple-
Developer-Zertifikat und sind derzeit nicht eingerichtet.

### Tastenkürzel

- `Control + Option + L` — Tastatursperre umschalten.
- `Control + Option + Escape` — Notfall-Entsperrung.

### Mitwirken

Verwenden Sie die [GitHub-Issue-Formulare](https://github.com/Panaix/PurrLock/issues/new/choose),
um Fehler zu melden oder Verbesserungen vorzuschlagen. Pull Requests sollten
die Änderung und ihre Prüfung beschreiben. Lesen Sie den
[Leitfaden für Mitwirkende](CONTRIBUTING.md).

### Lizenz

PurrLock wird unter der MIT-Lizenz veröffentlicht. Rechtlich maßgeblich ist die
englische Datei [LICENSE](LICENSE).

## ☕ Den Autor unterstützen

[![Autor auf Boosty unterstützen](https://img.shields.io/badge/Boosty-%E2%98%95%20Unterst%C3%BCtzen-ff5c8d?style=for-the-badge)](https://boosty.to/panaix/donate)

Spenden sind freiwillig und unterstützen die Weiterentwicklung von PurrLock.
Prüfen Sie vor einer Überweisung sorgfältig Adresse und Netzwerk: ETH verwendet
ERC20, USDT verwendet TRC20.

**BTC**
```
bc1q259xvrs9gvnr7pzyfaswp73harxnl8hyvwwvqw
```

**ETH (ERC20)**
```
0x646378b62c3e32cb293b61ffb1c84244d8d61f69
```

**USDT (TRC20)**
```
TMkG5Y1yxgPLSEegyYeA8pYTmuagPnrxAJ
```

**Monero (XMR)**
```
4HR2jnRAwm3SFP4r8KzxBxESVHKLvZ29Pxz8Qm3uqHY5aD9Kj1De2Y1W8S18fYjh9acS9NkK4VNje5pC2gVq3aYVZzLEtjf8UnUfkuTri
```

</details>

<details>
<summary>🇪🇸 Español</summary>

## PurrLock — protección del teclado para macOS

PurrLock es una aplicación para macOS que bloquea temporalmente el teclado y
detecta pulsaciones rápidas accidentales. Usa el bloqueo al limpiar el teclado
o para evitar entradas involuntarias. PurrLock es compatible con Mac Intel y
Apple silicon, y su interfaz está disponible en ruso, inglés, alemán, español,
francés, chino y japonés.

### Requisitos

- macOS 13 o posterior.
- Mac con procesador Intel o Apple silicon.

### Instalación

Descarga [PurrLock-Installer.dmg](https://github.com/Panaix/PurrLock/releases/latest),
abre la imagen y arrastra PurrLock a la carpeta Aplicaciones. La primera vez,
concede acceso en **Ajustes del Sistema → Privacidad y seguridad →
Accesibilidad**. PurrLock necesita este permiso para procesar eventos del
teclado y suprimir pulsaciones mientras está bloqueado.

El instalador actual tiene firma ad hoc y Apple no lo ha notarizado. macOS
puede mostrar una advertencia de Gatekeeper.

### Privacidad y seguridad

PurrLock procesa los eventos del teclado localmente. Los códigos de tecla y la
hora de cada evento se mantienen temporalmente en la memoria del proceso para
detectar pulsaciones rápidas. La aplicación no registra el texto escrito, no
guarda un historial de teclas en disco ni envía eventos del teclado por
Internet. Los ajustes se guardan localmente en `UserDefaults`; macOS entrega
las notificaciones. No hay analítica ni telemetría.

Comunica las vulnerabilidades mediante el
[canal privado de seguridad de GitHub](https://github.com/Panaix/PurrLock/security/advisories/new),
no en un Issue público. No incluyas contraseñas, datos personales ni texto
introducido. Consulta la [política de seguridad](SECURITY.md).

### Compilar desde el código fuente

Instala Xcode Command Line Tools y ejecuta:

```sh
xcode-select --install
./scripts/build-release.sh
```

El script crea una aplicación Universal Binary y un instalador en `build/`.
Puedes definir la versión con `VERSION` y `BUILD_NUMBER`. La firma Developer ID
y la notarización de Apple requieren un certificado de Apple Developer y aún
no están configuradas.

### Atajos de teclado

- `Control + Option + L` — activar o desactivar el bloqueo.
- `Control + Option + Escape` — desbloqueo de emergencia.

### Colaborar

Usa los [formularios de Issues de GitHub](https://github.com/Panaix/PurrLock/issues/new/choose)
para informar de errores o proponer mejoras. Los pull requests deben explicar
el cambio y cómo se verificó. Consulta la
[guía de colaboración](CONTRIBUTING.md).

### Licencia

PurrLock se distribuye bajo la licencia MIT. El texto legalmente válido es el
archivo [LICENSE](LICENSE) en inglés.

## ☕ Apoyar al autor

[![Apoyar al autor en Boosty](https://img.shields.io/badge/Boosty-%E2%98%95%20Apoyar-ff5c8d?style=for-the-badge)](https://boosty.to/panaix/donate)

Las donaciones son voluntarias y ayudan a desarrollar PurrLock. Antes de enviar
criptomonedas, comprueba cuidadosamente la dirección y la red: ETH usa ERC20 y
USDT usa TRC20.

**BTC**
```
bc1q259xvrs9gvnr7pzyfaswp73harxnl8hyvwwvqw
```

**ETH (ERC20)**
```
0x646378b62c3e32cb293b61ffb1c84244d8d61f69
```

**USDT (TRC20)**
```
TMkG5Y1yxgPLSEegyYeA8pYTmuagPnrxAJ
```

**Monero (XMR)**
```
4HR2jnRAwm3SFP4r8KzxBxESVHKLvZ29Pxz8Qm3uqHY5aD9Kj1De2Y1W8S18fYjh9acS9NkK4VNje5pC2gVq3aYVZzLEtjf8UnUfkuTri
```

</details>

<details>
<summary>🇫🇷 Français</summary>

## PurrLock — protection du clavier pour macOS

PurrLock est une application macOS qui verrouille temporairement le clavier et
détecte les frappes rapides accidentelles. Utilisez le verrouillage pour
nettoyer le clavier ou éviter les saisies involontaires. PurrLock prend en
charge les Mac Intel et Apple silicon ; son interface est disponible en russe,
anglais, allemand, espagnol, français, chinois et japonais.

### Configuration requise

- macOS 13 ou version ultérieure.
- Mac avec processeur Intel ou Apple silicon.

### Installation

Téléchargez [PurrLock-Installer.dmg](https://github.com/Panaix/PurrLock/releases/latest),
ouvrez l’image et faites glisser PurrLock dans le dossier Applications. Au
premier lancement, autorisez l’accès dans **Réglages Système → Confidentialité
et sécurité → Accessibilité**. PurrLock a besoin de cette autorisation pour
traiter les événements clavier et bloquer les frappes pendant le verrouillage.

L’installateur actuel est signé ad hoc et n’est pas notarié par Apple. macOS
peut afficher un avertissement Gatekeeper.

### Confidentialité et sécurité

PurrLock traite les événements clavier localement. Les codes des touches et
leurs horaires sont conservés temporairement dans la mémoire du processus afin
de détecter les frappes rapides. L’application n’enregistre pas le texte saisi,
ne stocke pas l’historique des touches sur le disque et n’envoie pas
d’événements clavier sur le réseau. Les réglages sont conservés localement dans
`UserDefaults` ; macOS distribue les notifications. Il n’y a ni analyse ni
télémétrie.

Signalez les vulnérabilités via le
[canal privé de sécurité GitHub](https://github.com/Panaix/PurrLock/security/advisories/new),
et non dans une Issue publique. N’incluez ni mot de passe, ni donnée personnelle,
ni texte saisi. Consultez la [politique de sécurité](SECURITY.md).

### Compiler depuis les sources

Installez les outils de ligne de commande Xcode, puis exécutez :

```sh
xcode-select --install
./scripts/build-release.sh
```

Le script crée une application Universal Binary et un installateur dans `build/`.
Définissez la version avec `VERSION` et `BUILD_NUMBER`. La signature Developer
ID et la notarisation Apple nécessitent un certificat Apple Developer et ne sont
pas encore configurées.

### Raccourcis clavier

- `Control + Option + L` — activer ou désactiver le verrouillage.
- `Control + Option + Escape` — déverrouillage d’urgence.

### Contribution

Utilisez les [formulaires d’Issues GitHub](https://github.com/Panaix/PurrLock/issues/new/choose)
pour signaler un problème ou proposer une amélioration. Les pull requests
doivent décrire le changement et sa vérification. Consultez le
[guide de contribution](CONTRIBUTING.md).

### Licence

PurrLock est distribué sous licence MIT. Le texte juridiquement applicable est
le fichier [LICENSE](LICENSE) en anglais.

## ☕ Soutenir l’auteur

[![Soutenir l’auteur sur Boosty](https://img.shields.io/badge/Boosty-%E2%98%95%20Soutenir-ff5c8d?style=for-the-badge)](https://boosty.to/panaix/donate)

Les dons sont volontaires et contribuent au développement de PurrLock. Avant
tout envoi de cryptomonnaie, vérifiez soigneusement l’adresse et le réseau :
ETH utilise ERC20 et USDT utilise TRC20.

**BTC**
```
bc1q259xvrs9gvnr7pzyfaswp73harxnl8hyvwwvqw
```

**ETH (ERC20)**
```
0x646378b62c3e32cb293b61ffb1c84244d8d61f69
```

**USDT (TRC20)**
```
TMkG5Y1yxgPLSEegyYeA8pYTmuagPnrxAJ
```

**Monero (XMR)**
```
4HR2jnRAwm3SFP4r8KzxBxESVHKLvZ29Pxz8Qm3uqHY5aD9Kj1De2Y1W8S18fYjh9acS9NkK4VNje5pC2gVq3aYVZzLEtjf8UnUfkuTri
```

</details>

<details>
<summary>🇨🇳 简体中文</summary>

## PurrLock — macOS 键盘保护工具

PurrLock 是一款 macOS 应用，可暂时锁定键盘并检测意外的快速按键。清洁
键盘或防止意外输入时，可以启用键盘锁。PurrLock 支持 Intel 和 Apple
silicon Mac，应用界面支持俄语、英语、德语、西班牙语、法语、中文和日语。

### 系统要求

- macOS 13 或更高版本。
- Intel 或 Apple silicon Mac。

### 安装

下载 [PurrLock-Installer.dmg](https://github.com/Panaix/PurrLock/releases/latest)，
打开磁盘映像，然后将 PurrLock 拖到“应用程序”文件夹。首次启动时，请在
**系统设置 → 隐私与安全性 → 辅助功能**中授权。应用需要此权限来处理键盘
事件，并在锁定时暂时屏蔽按键。

当前安装包使用 ad hoc 签名，尚未经过 Apple 公证。macOS 可能显示
Gatekeeper 警告。

### 隐私与安全

PurrLock 在本地处理键盘事件。为了检测快速按键，按键代码和事件时间会
暂时保存在进程内存中。应用不会记录输入文本，不会将按键历史写入磁盘，
也不会通过网络发送键盘事件。设置保存在本地 `UserDefaults` 中；通知由
macOS 系统服务发送。应用不包含分析或遥测功能。

请通过
[GitHub 私密安全漏洞报告](https://github.com/Panaix/PurrLock/security/advisories/new)
报告漏洞，不要在公开 Issue 中披露。请勿附上密码、个人信息或键盘输入
内容。详情请查看[安全政策](SECURITY.md)。

### 从源代码构建

安装 Xcode Command Line Tools，然后运行：

```sh
xcode-select --install
./scripts/build-release.sh
```

脚本会在 `build/` 中生成 Universal Binary 应用和安装包。可通过 `VERSION`
和 `BUILD_NUMBER` 指定版本信息。Developer ID 签名和 Apple 公证需要 Apple
Developer 证书，目前尚未配置。

### 键盘快捷键

- `Control + Option + L` — 切换键盘锁定状态。
- `Control + Option + Escape` — 紧急解锁。

### 参与项目

使用 [GitHub Issue 表单](https://github.com/Panaix/PurrLock/issues/new/choose)
报告问题或提出改进建议。Pull Request 应说明改动内容和验证方式。请阅读
[贡献指南](CONTRIBUTING.md)。

### 许可证

PurrLock 使用 MIT 许可证发布。具有法律效力的许可证文本为英文
[LICENSE](LICENSE) 文件。

## ☕ 支持作者

[![在 Boosty 支持作者](https://img.shields.io/badge/Boosty-%E2%98%95%20%E6%94%AF%E6%8C%81-ff5c8d?style=for-the-badge)](https://boosty.to/panaix/donate)

捐赠完全自愿，可用于支持 PurrLock 的开发。发送加密货币前，请仔细核对
地址和网络：ETH 使用 ERC20，USDT 使用 TRC20。

**BTC**
```
bc1q259xvrs9gvnr7pzyfaswp73harxnl8hyvwwvqw
```

**ETH (ERC20)**
```
0x646378b62c3e32cb293b61ffb1c84244d8d61f69
```

**USDT (TRC20)**
```
TMkG5Y1yxgPLSEegyYeA8pYTmuagPnrxAJ
```

**Monero (XMR)**
```
4HR2jnRAwm3SFP4r8KzxBxESVHKLvZ29Pxz8Qm3uqHY5aD9Kj1De2Y1W8S18fYjh9acS9NkK4VNje5pC2gVq3aYVZzLEtjf8UnUfkuTri
```

</details>

<details>
<summary>🇯🇵 日本語</summary>

## PurrLock — macOS向けキーボード保護アプリ

PurrLock は、キーボードを一時的にロックし、誤った素早いキー入力を検出
する macOS アプリです。キーボードの清掃中や、意図しない入力を防ぎたい
ときにロックできます。Intel と Apple silicon の Mac に対応し、ロシア語、
英語、ドイツ語、スペイン語、フランス語、中国語、日本語のインター
フェースを利用できます。

### 動作要件

- macOS 13 以降。
- Intel または Apple silicon 搭載 Mac。

### インストール

[PurrLock-Installer.dmg](https://github.com/Panaix/PurrLock/releases/latest)
をダウンロードして開き、PurrLock を「アプリケーション」フォルダへ
ドラッグしてください。初回起動時に **システム設定 → プライバシーと
セキュリティ → アクセシビリティ** でアクセスを許可してください。
キーボードイベントの処理とロック中のキー入力の一時的な抑止に必要です。

現在のインストーラーは ad hoc 署名で、Apple の notarization は未実施
です。macOS が Gatekeeper の警告を表示する場合があります。

### プライバシーとセキュリティ

PurrLock はキーボードイベントをローカルで処理します。素早い入力の検出
に使うキーコードとイベント時刻は、プロセスのメモリに一時的に保持され
ます。入力した文章を記録したり、キー履歴をディスクに保存したり、キー
ボードイベントをネットワーク経由で送信したりしません。設定は
`UserDefaults` にローカル保存され、通知は macOS のシステムサービスが
配信します。分析機能やテレメトリーはありません。

脆弱性は公開 Issue ではなく、
[GitHub の非公開セキュリティ報告](https://github.com/Panaix/PurrLock/security/advisories/new)
から報告してください。パスワード、個人情報、入力内容は添付しないで
ください。詳しくは[セキュリティポリシー](SECURITY.md)をご覧ください。

### ソースからビルド

Xcode Command Line Tools をインストールして、次を実行します。

```sh
xcode-select --install
./scripts/build-release.sh
```

スクリプトは `build/` に Universal Binary アプリとインストーラーを作成
します。バージョン情報は `VERSION` と `BUILD_NUMBER` で指定できます。
Developer ID 署名と Apple notarization には Apple Developer 証明書が必要
ですが、現在は設定されていません。

### キーボードショートカット

- `Control + Option + L` — キーボードロックを切り替える。
- `Control + Option + Escape` — 緊急ロック解除。

### 開発への参加

[GitHub Issue フォーム](https://github.com/Panaix/PurrLock/issues/new/choose)
から不具合報告や改善案を送ってください。Pull Request には変更内容と
確認方法を記載してください。[コントリビューションガイド](CONTRIBUTING.md)
もご覧ください。

### ライセンス

PurrLock は MIT ライセンスで配布されています。法的に有効なライセンス
本文は英語の [LICENSE](LICENSE) です。

## ☕ 作者を支援

[![Boostyで作者を支援](https://img.shields.io/badge/Boosty-%E2%98%95%20%E6%94%AF%E6%8F%B4-ff5c8d?style=for-the-badge)](https://boosty.to/panaix/donate)

寄付は任意で、PurrLock の開発支援に役立てられます。暗号資産を送る前に、
アドレスとネットワークを必ず確認してください。ETH は ERC20、USDT は
TRC20 を使用します。

**BTC**
```
bc1q259xvrs9gvnr7pzyfaswp73harxnl8hyvwwvqw
```

**ETH (ERC20)**
```
0x646378b62c3e32cb293b61ffb1c84244d8d61f69
```

**USDT (TRC20)**
```
TMkG5Y1yxgPLSEegyYeA8pYTmuagPnrxAJ
```

**Monero (XMR)**
```
4HR2jnRAwm3SFP4r8KzxBxESVHKLvZ29Pxz8Qm3uqHY5aD9Kj1De2Y1W8S18fYjh9acS9NkK4VNje5pC2gVq3aYVZzLEtjf8UnUfkuTri
```

</details>
