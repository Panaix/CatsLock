# PurrLock — 简体中文

[选择其他语言](../../README.md)

PurrLock 是一款 macOS 应用，可暂时锁定键盘并检测意外的快速按键。应用
界面支持俄语、英语、德语、西班牙语、法语、中文和日语。
自动保护也会统计长按重复和带修饰键的按键；灵敏度较高时可能会意外锁定。

## 系统要求

- macOS 13 或更高版本。
- Intel 或 Apple silicon Mac。

## 安装

下载 [PurrLock-Installer.dmg](https://github.com/Panaix/PurrLock/releases/latest)，
打开磁盘映像，然后将 PurrLock 拖到“应用程序”文件夹。首次启动时，请在
**系统设置 → 隐私与安全性 → 辅助功能**中授权。应用需要此权限来处理键盘
事件，并在锁定时暂时屏蔽按键。

当前安装包使用 ad hoc 签名，尚未经过 Apple 公证。macOS 可能显示
Gatekeeper 警告。

## 隐私与安全

PurrLock 在本地处理键盘事件。为了检测快速按键，按键代码和事件时间会
暂时保存在进程内存中。应用不会记录输入文本，不会将按键历史写入磁盘，
也不会通过网络发送键盘事件。设置保存在本地 `UserDefaults` 中；通知由
macOS 系统服务发送。应用不包含分析或遥测功能。

请通过
[GitHub 私密安全漏洞报告](https://github.com/Panaix/PurrLock/security/advisories/new)
报告漏洞，不要在公开 Issue 中披露。请勿附上密码、个人信息或键盘输入
内容。详情请查看[安全政策](../../SECURITY.md)。

## 从源代码构建

安装 Xcode Command Line Tools，然后运行：

```sh
xcode-select --install
./scripts/build-release.sh
```

脚本会在 `build/` 中生成 Universal Binary 应用和安装包。可通过 `VERSION`
和 `BUILD_NUMBER` 指定版本信息。Developer ID 签名和 Apple 公证需要 Apple
Developer 证书，目前尚未配置。

## 键盘快捷键

- `Control + Option + L` — 切换键盘锁定状态。
- `Control + Option + Escape` — 紧急解锁。

## 参与项目

使用 [Issue 表单](https://github.com/Panaix/PurrLock/issues/new/choose)
报告问题或提出改进建议。Pull Request 应说明改动内容和验证方式。请阅读
[贡献指南](../../CONTRIBUTING.md)。

## 许可证

MIT。具有法律效力的许可证文本为英文 [LICENSE](../../LICENSE) 文件。
