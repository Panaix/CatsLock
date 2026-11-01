# CatsLock — English

[Choose another language](../../README.md)

CatsLock is a macOS app that temporarily locks the keyboard and detects
accidental rapid keystrokes. The app interface is available in Russian,
English, German, Spanish, French, Chinese, and Japanese.

## Requirements

- macOS 13 or later.
- Intel or Apple silicon Mac.

## Install

Download [CatsLock-Installer.dmg](https://github.com/Panaix/CatsLock/releases/latest),
open it, and drag CatsLock to Applications. On first launch, grant access under
**System Settings → Privacy & Security → Accessibility**. CatsLock needs this
permission to process keyboard events and suppress key presses while locked.

The current installer is ad hoc signed and not notarized by Apple. macOS may
show a Gatekeeper warning.

## Privacy and security

CatsLock processes keyboard events locally. Key codes and event times are held
temporarily in process memory to detect rapid keystrokes. The app does not
record typed text, store key history on disk, or send keyboard events over the
network. Settings are stored locally in `UserDefaults`; macOS delivers
notifications. There is no analytics or telemetry.

Report vulnerabilities through
[GitHub private vulnerability reporting](https://github.com/Panaix/CatsLock/security/advisories/new),
not a public Issue. Do not include passwords, personal data, or typed content.
See the [security policy](../../SECURITY.md).

## Build from source

Install Xcode Command Line Tools, then run:

```sh
xcode-select --install
./scripts/build-release.sh
```

The script creates a Universal Binary app and installer in `build/`. Set
`VERSION` and `BUILD_NUMBER` to customize version metadata. Developer ID signing
and Apple notarization require an Apple Developer certificate and are not
configured yet.

## Keyboard shortcuts

- `Control + Option + L` — toggle the keyboard lock.
- `Control + Option + Escape` — emergency unlock.

## Contributing

Use the [issue forms](https://github.com/Panaix/CatsLock/issues/new/choose) to
report a bug or suggest an improvement. Pull requests should explain the change
and how it was verified. Read the [contribution guide](../../CONTRIBUTING.md).

## License

MIT. The legally authoritative license text is the English
[LICENSE](../../LICENSE) file.
