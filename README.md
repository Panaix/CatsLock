# CatsLock

CatsLock — приложение для macOS, которое временно блокирует клавиатуру и
обнаруживает случайные быстрые нажатия.

<details>
<summary>Описание на всех языках интерфейса / Descriptions in all supported UI languages</summary>

- **Русский:** CatsLock для macOS временно блокирует клавиатуру и обнаруживает случайные быстрые нажатия.
- **English:** CatsLock for macOS temporarily locks the keyboard and detects accidental rapid keystrokes.
- **Deutsch:** CatsLock für macOS sperrt die Tastatur vorübergehend und erkennt versehentlich schnelle Tastenanschläge.
- **Español:** CatsLock para macOS bloquea temporalmente el teclado y detecta pulsaciones rápidas accidentales.
- **Français:** CatsLock pour macOS verrouille temporairement le clavier et détecte les frappes rapides accidentelles.
- **中文：** CatsLock 是一款 macOS 应用，可暂时锁定键盘并检测意外的快速按键。
- **日本語：** CatsLock は macOS 用アプリです。キーボードを一時的にロックし、誤った素早いキー入力を検出します。

</details>

Поддерживаются macOS 13 и новее, а также компьютеры Intel и Apple silicon.

## Установка

Скачайте `CatsLock-Installer.dmg` из раздела **Releases** на GitHub, откройте
образ и перетащите CatsLock в папку **Applications**. При первом запуске
macOS попросит разрешить приложению доступ в разделе **Системные настройки →
Конфиденциальность и безопасность → Универсальный доступ**. Это разрешение
необходимо для перехвата и временной блокировки нажатий клавиатуры.

## Сборка

Требуются macOS 13 или новее и Swift, установленный вместе с Xcode Command
Line Tools. Release-сборка содержит архитектуры Intel (`x86_64`) и Apple
silicon (`arm64`).

```sh
xcode-select --install
./scripts/build-release.sh
```

Скрипт создаёт `build/CatsLock.app` и `build/CatsLock-Installer.dmg`. Версию
можно задать переменными `VERSION` и `BUILD_NUMBER`. По умолчанию приложение
подписывается ad hoc, поэтому macOS может показать предупреждение при запуске.
Для распространения без такого предупреждения нужны сертификат **Developer ID
Application** и нотарификация Apple. Сертификат можно указать через
переменную окружения `CODESIGN_IDENTITY`.

## Конфиденциальность

CatsLock обрабатывает события клавиатуры локально, чтобы переключать блокировку
и обнаруживать быстрые нажатия. Для обнаружения приложение временно держит в
памяти коды клавиш и время нажатий; оно не записывает текст, не сохраняет
историю нажатий на диск и не отправляет события клавиатуры по сети.
Пользовательские настройки хранятся локально в `UserDefaults`. Уведомления
доставляются системной службой уведомлений macOS. В приложении нет аналитики
или телеметрии.

Подробности: [политика безопасности и конфиденциальности](SECURITY.md).

## Горячие клавиши

- `Control + Option + L` — переключить блокировку.
- `Control + Option + Escape` — аварийная разблокировка.

## Лицензия

Проект распространяется по лицензии MIT. См. [LICENSE](LICENSE).
