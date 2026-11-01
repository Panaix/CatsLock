# CatsLock — 日本語

[ほかの言語を選択](../../README.md)

CatsLock は、キーボードを一時的にロックし、誤った素早いキー入力を検出
する macOS アプリです。アプリのインターフェースはロシア語、英語、
ドイツ語、スペイン語、フランス語、中国語、日本語に対応しています。

## 動作要件

- macOS 13 以降。
- Intel または Apple silicon 搭載 Mac。

## インストール

[CatsLock-Installer.dmg](https://github.com/Panaix/CatsLock/releases/latest)
をダウンロードして開き、CatsLock を「アプリケーション」フォルダへ
ドラッグしてください。初回起動時に **システム設定 → プライバシーと
セキュリティ → アクセシビリティ** でアクセスを許可してください。
キーボードイベントの処理とロック中のキー入力の一時的な抑止に必要です。

現在のインストーラーは ad hoc 署名で、Apple の notarization は未実施
です。macOS が Gatekeeper の警告を表示する場合があります。

## プライバシーとセキュリティ

CatsLock はキーボードイベントをローカルで処理します。素早い入力の検出
に使うキーコードとイベント時刻は、プロセスのメモリに一時的に保持され
ます。入力した文章を記録したり、キー履歴をディスクに保存したり、キー
ボードイベントをネットワーク経由で送信したりしません。設定は
`UserDefaults` にローカル保存され、通知は macOS のシステムサービスが
配信します。分析機能やテレメトリーはありません。

脆弱性は公開 Issue ではなく、
[GitHub の非公開セキュリティ報告](https://github.com/Panaix/CatsLock/security/advisories/new)
から報告してください。パスワード、個人情報、入力内容は添付しないで
ください。詳しくは[セキュリティポリシー](../../SECURITY.md)をご覧ください。

## ソースからビルド

Xcode Command Line Tools をインストールして、次を実行します。

```sh
xcode-select --install
./scripts/build-release.sh
```

スクリプトは `build/` に Universal Binary アプリとインストーラーを作成
します。バージョン情報は `VERSION` と `BUILD_NUMBER` で指定できます。
Developer ID 署名と Apple notarization には Apple Developer 証明書が必要
ですが、現在は設定されていません。

## キーボードショートカット

- `Control + Option + L` — キーボードロックを切り替える。
- `Control + Option + Escape` — 緊急ロック解除。

## 開発への参加

[Issue フォーム](https://github.com/Panaix/CatsLock/issues/new/choose)から
不具合報告や改善案を送ってください。Pull Request には変更内容と確認方法
を記載してください。[コントリビューションガイド](../../CONTRIBUTING.md)
もご覧ください。

## ライセンス

MIT。法的に有効なライセンス本文は英語の [LICENSE](../../LICENSE) です。
