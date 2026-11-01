# PurrLock — Deutsch

[Andere Sprache wählen](../../README.md)

PurrLock ist eine macOS-App, die die Tastatur vorübergehend sperrt und
versehentlich schnelle Tastenanschläge erkennt. Die App-Oberfläche ist auf
Russisch, Englisch, Deutsch, Spanisch, Französisch, Chinesisch und Japanisch
verfügbar.
Die automatische Schutzfunktion zählt auch Tastenwiederholungen und Anschläge
mit Modifikatoren; bei hoher Empfindlichkeit kann die Sperre versehentlich
ausgelöst werden.

## Voraussetzungen

- macOS 13 oder neuer.
- Mac mit Intel- oder Apple-Silicon-Prozessor.

## Installation

Laden Sie [PurrLock-Installer.dmg](https://github.com/Panaix/PurrLock/releases/latest)
herunter, öffnen Sie das Image und ziehen Sie PurrLock in den Ordner Programme.
Erlauben Sie beim ersten Start den Zugriff unter **Systemeinstellungen →
Datenschutz & Sicherheit → Bedienungshilfen**. PurrLock benötigt diese
Berechtigung, um Tastaturereignisse zu verarbeiten und Tasten während der
Sperre zu unterdrücken.

Der aktuelle Installer ist ad hoc signiert und nicht von Apple notariell
beglaubigt. macOS kann eine Gatekeeper-Warnung anzeigen.

## Datenschutz und Sicherheit

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
[Sicherheitsrichtlinie](../../SECURITY.md).

## Aus dem Quellcode erstellen

Installieren Sie die Xcode Command Line Tools und führen Sie anschließend aus:

```sh
xcode-select --install
./scripts/build-release.sh
```

Das Skript erstellt eine Universal-Binary-App und einen Installer in `build/`.
Die Versionsdaten lassen sich mit `VERSION` und `BUILD_NUMBER` festlegen.
Developer-ID-Signierung und Apple-Notarisierung benötigen ein Apple-
Developer-Zertifikat und sind derzeit nicht eingerichtet.

## Tastenkürzel

- `Control + Option + L` — Tastatursperre umschalten.
- `Control + Option + Escape` — Notfall-Entsperrung.

## Mitwirken

Verwenden Sie die [Issue-Formulare](https://github.com/Panaix/PurrLock/issues/new/choose),
um Fehler zu melden oder Verbesserungen vorzuschlagen. Pull Requests sollten
die Änderung und ihre Prüfung beschreiben. Lesen Sie den
[Leitfaden für Mitwirkende](../../CONTRIBUTING.md).

## Lizenz

MIT. Rechtlich maßgeblich ist die englische Datei
[LICENSE](../../LICENSE).
