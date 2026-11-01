import AppKit
import QuartzCore
import ApplicationServices
import UserNotifications



/// Получает CGColor динамического системного цвета в заданной теме macOS.
private func cgColor(_ color: NSColor, for appearance: NSAppearance) -> CGColor {
    var result = color.cgColor
    appearance.performAsCurrentDrawingAppearance {
        result = color.cgColor
    }
    return result
}

/// Обновляет сохранённые в CALayer цвета при переключении системной темы.
final class AdaptiveBackgroundView: NSView {
    override func viewDidChangeEffectiveAppearance() {
        super.viewDidChangeEffectiveAppearance()
        refreshAppearanceColors()
    }

    func refreshAppearanceColors() {
        if let layer = layer {
            layer.backgroundColor = cgColor(.windowBackgroundColor, for: effectiveAppearance)
        }
        refreshSubviews(self)
    }

    private func refreshSubviews(_ parent: NSView) {
        for child in parent.subviews {
            if let layer = child.layer {
                switch child.identifier?.rawValue {
                case "catslock.surface":
                    layer.backgroundColor = cgColor(.controlBackgroundColor, for: effectiveAppearance)
                case "catslock.card":
                    layer.backgroundColor = cgColor(.controlBackgroundColor, for: effectiveAppearance)
                default: break
                }
            }
            refreshSubviews(child)
        }
    }
}

final class FlippedView: NSView {
    override var isFlipped: Bool { true }
}

final class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {
    // Язык интерфейса: русский, английский, немецкий, испанский, французский, китайский, японский.
    private var interfaceLanguage: String = {
        if let saved = UserDefaults.standard.string(forKey: "catslock.language"), ["ru", "en", "de", "es", "fr", "zh", "ja"].contains(saved) { return saved }
        let preferred = Locale.preferredLanguages.first?.lowercased() ?? "ru"
        for code in ["en", "de", "es", "fr", "zh", "ja"] {
            if preferred.hasPrefix(code) { return code }
        }
        return "ru"
    }()

    private func L(_ russian: String) -> String {
        guard interfaceLanguage != "ru" else { return russian }
        return translations[russian]?[interfaceLanguage] ?? russian
    }

    private let translations: [String: [String: String]] = [
        "Настройки": ["en": "Settings", "de": "Einstellungen", "es": "Ajustes", "fr": "Réglages", "zh": "设置", "ja": "設定"],
        "☕ Поддержать автора": ["en": "☕ Support the Author", "de": "☕ Autor unterstützen", "es": "☕ Apoyar al autor", "fr": "☕ Soutenir l’auteur", "zh": "☕ 支持作者", "ja": "☕ 作者を支援"],
        "Поддержать проект": ["en": "Support the Project", "de": "Projekt unterstützen", "es": "Apoyar el proyecto", "fr": "Soutenir le projet", "zh": "支持项目", "ja": "プロジェクトを支援"],
        "Спасибо за поддержку CatsLock! Выберите удобный способ.": ["en": "Thank you for supporting CatsLock! Choose a convenient way.", "de": "Vielen Dank für Ihre Unterstützung von CatsLock! Wählen Sie eine passende Möglichkeit.", "es": "¡Gracias por apoyar CatsLock! Elige una forma conveniente.", "fr": "Merci de soutenir CatsLock ! Choisissez le moyen qui vous convient.", "zh": "感谢您支持 CatsLock！请选择方便的方式。", "ja": "CatsLockへのご支援ありがとうございます。お好きな方法をお選びください。"],
        "Поддержать на Boosty": ["en": "Support on Boosty", "de": "Auf Boosty unterstützen", "es": "Apoyar en Boosty", "fr": "Soutenir sur Boosty", "zh": "在 Boosty 支持", "ja": "Boostyで支援"],
        "Криптовалютные кошельки": ["en": "Cryptocurrency wallets", "de": "Krypto-Wallets", "es": "Carteras de criptomonedas", "fr": "Portefeuilles crypto", "zh": "加密货币钱包", "ja": "暗号資産ウォレット"],
        "Скопировать адрес": ["en": "Copy address", "de": "Adresse kopieren", "es": "Copiar dirección", "fr": "Copier l’adresse", "zh": "复制地址", "ja": "アドレスをコピー"],
        "Адрес скопирован": ["en": "Address copied", "de": "Adresse kopiert", "es": "Dirección copiada", "fr": "Adresse copiée", "zh": "地址已复制", "ja": "アドレスをコピーしました"],
        "Не удалось скопировать адрес.": ["en": "Could not copy the address.", "de": "Die Adresse konnte nicht kopiert werden.", "es": "No se pudo copiar la dirección.", "fr": "Impossible de copier l’adresse.", "zh": "无法复制地址。", "ja": "アドレスをコピーできませんでした。"],
        "Не удалось открыть Boosty в браузере.": ["en": "Could not open Boosty in your browser.", "de": "Boosty konnte nicht im Browser geöffnet werden.", "es": "No se pudo abrir Boosty en el navegador.", "fr": "Impossible d’ouvrir Boosty dans le navigateur.", "zh": "无法在浏览器中打开 Boosty。", "ja": "ブラウザでBoostyを開けませんでした。"],
        "Закрыть": ["en": "Close", "de": "Schließen", "es": "Cerrar", "fr": "Fermer", "zh": "关闭", "ja": "閉じる"],
        "Язык интерфейса": ["en": "Interface language", "de": "Oberflächensprache", "es": "Idioma de la interfaz", "fr": "Langue de l’interface", "zh": "界面语言", "ja": "インターフェース言語"],
        "Язык сохранён": ["en": "Language saved", "de": "Sprache gespeichert", "es": "Idioma guardado", "fr": "Langue enregistrée", "zh": "语言已保存", "ja": "言語を保存しました"],
        "Изменение языка полностью применится после перезапуска CatsLock.": ["en": "The language change will fully apply after restarting CatsLock.", "de": "Die Sprachänderung wird nach einem Neustart von CatsLock vollständig übernommen.", "es": "El cambio de idioma se aplicará completamente al reiniciar CatsLock.", "fr": "Le changement de langue sera entièrement appliqué après le redémarrage de CatsLock.", "zh": "重启 CatsLock 后将完全应用语言更改。", "ja": "CatsLockを再起動すると言語変更が完全に反映されます。"],
        "Понятно": ["en": "OK", "de": "Verstanden", "es": "Entendido", "fr": "Compris", "zh": "知道了", "ja": "了解"],
        "сек.": ["en": "sec.", "de": "Sek.", "es": "s", "fr": "s", "zh": "秒", "ja": "秒"],
        "Клавиатура заблокирована": [
            "en": "Keyboard locked",
            "de": "Tastatur gesperrt",
            "es": "Teclado bloqueado",
            "fr": "Clavier verrouillé",
            "zh": "键盘已锁定",
            "ja": "キーボードをロックしました",
        ],
        "Нажатия клавиш временно отключены": [
            "en": "Keyboard input is temporarily disabled",
            "de": "Tastatureingaben sind vorübergehend deaktiviert",
            "es": "Las teclas están desactivadas temporalmente",
            "fr": "La saisie au clavier est temporairement désactivée",
            "zh": "键盘输入已暂时禁用",
            "ja": "キーボード入力は一時的に無効です",
        ],
        "Аварийная разблокировка": [
            "en": "Emergency unlock",
            "de": "Notfall-Entsperrung",
            "es": "Desbloqueo de emergencia",
            "fr": "Déverrouillage d’urgence",
            "zh": "紧急解锁",
            "ja": "緊急ロック解除",
        ],
        "Разблокировать": [
            "en": "Unlock",
            "de": "Entsperren",
            "es": "Desbloquear",
            "fr": "Déverrouiller",
            "zh": "解锁",
            "ja": "ロック解除",
        ],
        "ЦЕНТР ЗАЩИТЫ": [
            "en": "PROTECTION CENTER",
            "de": "SCHUTZZENTRALE",
            "es": "CENTRO DE PROTECCIÓN",
            "fr": "CENTRE DE PROTECTION",
            "zh": "保护中心",
            "ja": "保護センター",
        ],
        "Защита клавиатуры от случайных нажатий.\nКонтролируйте блокировку и настройте обнаружение.": [
            "en": "Protect your keyboard from accidental presses.\nControl locking and configure detection.",
            "de": "Schützt die Tastatur vor versehentlichen Eingaben.\nSteuern Sie die Sperre und passen Sie die Erkennung an.",
            "es": "Protege el teclado de pulsaciones accidentales.\nControla el bloqueo y configura la detección.",
            "fr": "Protège le clavier contre les pressions accidentelles.\nGérez le verrouillage et configurez la détection.",
            "zh": "防止键盘被意外按下。\n管理锁定并配置检测。",
            "ja": "キーボードの誤入力を防ぎます。\nロックと検出設定を管理できます。",
        ],
        "Состояние защиты": [
            "en": "Protection status",
            "de": "Schutzstatus",
            "es": "Estado de protección",
            "fr": "État de la protection",
            "zh": "保护状态",
            "ja": "保護状態",
        ],
        "Клавиатура доступна": [
            "en": "Keyboard available",
            "de": "Tastatur verfügbar",
            "es": "Teclado disponible",
            "fr": "Clavier disponible",
            "zh": "键盘可用",
            "ja": "キーボードは使用可能です",
        ],
        "Автоматическое обнаружение работает в фоне.": [
            "en": "Automatic detection is running in the background.",
            "de": "Die automatische Erkennung läuft im Hintergrund.",
            "es": "La detección automática funciona en segundo plano.",
            "fr": "La détection automatique fonctionne en arrière-plan.",
            "zh": "自动检测正在后台运行。",
            "ja": "自動検出はバックグラウンドで動作しています。",
        ],
        "Заблокировать клавиатуру": [
            "en": "Lock keyboard",
            "de": "Tastatur sperren",
            "es": "Bloquear teclado",
            "fr": "Verrouiller le clavier",
            "zh": "锁定键盘",
            "ja": "キーボードをロック",
        ],
        "Быстрые действия": [
            "en": "Quick actions",
            "de": "Schnellaktionen",
            "es": "Acciones rápidas",
            "fr": "Actions rapides",
            "zh": "快捷操作",
            "ja": "クイックアクション",
        ],
        "Проверить защиту": [
            "en": "Test protection",
            "de": "Schutz testen",
            "es": "Probar protección",
            "fr": "Tester la protection",
            "zh": "测试保护",
            "ja": "保護をテスト",
        ],
        "Тестовая блокировка на 7 секунд": [
            "en": "Test lock for 7 seconds",
            "de": "Test-Sperre für 7 Sekunden",
            "es": "Bloqueo de prueba durante 7 segundos",
            "fr": "Verrouillage test pendant 7 secondes",
            "zh": "测试锁定 7 秒",
            "ja": "7秒間のテストロック",
        ],
        "Настроить чувствительность": [
            "en": "Adjust sensitivity",
            "de": "Empfindlichkeit einstellen",
            "es": "Ajustar sensibilidad",
            "fr": "Régler la sensibilité",
            "zh": "调整灵敏度",
            "ja": "感度を調整",
        ],
        "Изменить параметры обнаружения": [
            "en": "Change detection settings",
            "de": "Erkennungseinstellungen ändern",
            "es": "Cambiar parámetros de detección",
            "fr": "Modifier les paramètres de détection",
            "zh": "更改检测参数",
            "ja": "検出設定を変更",
        ],
        "Горячие клавиши": [
            "en": "Keyboard shortcuts",
            "de": "Tastenkürzel",
            "es": "Atajos de teclado",
            "fr": "Raccourcis clavier",
            "zh": "键盘快捷键",
            "ja": "キーボードショートカット",
        ],
        "Переключить блокировку": [
            "en": "Toggle lock",
            "de": "Sperre umschalten",
            "es": "Alternar bloqueo",
            "fr": "Basculer le verrouillage",
            "zh": "切换锁定",
            "ja": "ロック切り替え",
        ],
        "Открыть": [
            "en": "Open",
            "de": "Öffnen",
            "es": "Abrir",
            "fr": "Ouvrir",
            "zh": "打开",
            "ja": "開く",
        ],
        "← Назад": [
            "en": "← Back",
            "de": "← Zurück",
            "es": "← Atrás",
            "fr": "← Retour",
            "zh": "← 返回",
            "ja": "← 戻る",
        ],
        "Чувствительность защиты": [
            "en": "Protection sensitivity",
            "de": "Schutzempfindlichkeit",
            "es": "Sensibilidad de protección",
            "fr": "Sensibilité de la protection",
            "zh": "保护灵敏度",
            "ja": "保護感度",
        ],
        "Изменения сохраняются автоматически. Меньше нажатий и разных клавиш — выше чувствительность. Больший интервал даёт больше времени на набор.": [
            "en": "Changes are saved automatically. Fewer presses and distinct keys increase sensitivity. A longer interval gives more time to type.",
            "de": "Änderungen werden automatisch gespeichert. Weniger Tastenanschläge und unterschiedliche Tasten erhöhen die Empfindlichkeit. Ein längeres Zeitfenster gibt mehr Zeit zum Tippen.",
            "es": "Los cambios se guardan automáticamente. Menos pulsaciones y teclas distintas aumentan la sensibilidad. Un intervalo mayor da más tiempo para escribir.",
            "fr": "Les modifications sont enregistrées automatiquement. Moins de frappes et de touches différentes augmentent la sensibilité. Un intervalle plus long laisse davantage de temps pour taper.",
            "zh": "更改会自动保存。按键次数和不同按键越少，灵敏度越高。更长的时间间隔可提供更多输入时间。",
            "ja": "変更は自動保存されます。押下回数や異なるキー数を少なくすると感度が上がります。間隔を長くすると入力時間に余裕ができます。",
        ],
        "Окно анализа": [
            "en": "Analysis window",
            "de": "Analysefenster",
            "es": "Ventana de análisis",
            "fr": "Fenêtre d’analyse",
            "zh": "分析时间窗口",
            "ja": "分析ウィンドウ",
        ],
        "Количество нажатий": [
            "en": "Number of presses",
            "de": "Anzahl der Tastenanschläge",
            "es": "Número de pulsaciones",
            "fr": "Nombre de frappes",
            "zh": "按键次数",
            "ja": "キー押下回数",
        ],
        "Разных клавиш": [
            "en": "Distinct keys",
            "de": "Verschiedene Tasten",
            "es": "Teclas distintas",
            "fr": "Touches différentes",
            "zh": "不同按键数",
            "ja": "異なるキー数",
        ],
        "Состояние: разблокирована": [
            "en": "Status: unlocked",
            "de": "Status: entsperrt",
            "es": "Estado: desbloqueado",
            "fr": "État : déverrouillé",
            "zh": "状态：已解锁",
            "ja": "状態：ロック解除",
        ],
        "Открыть CatsLock": [
            "en": "Open CatsLock",
            "de": "CatsLock öffnen",
            "es": "Abrir CatsLock",
            "fr": "Ouvrir CatsLock",
            "zh": "打开 CatsLock",
            "ja": "CatsLock を開く",
        ],
        "Настройки чувствительности…": [
            "en": "Sensitivity settings…",
            "de": "Empfindlichkeit…",
            "es": "Ajustes de sensibilidad…",
            "fr": "Réglages de sensibilité…",
            "zh": "灵敏度设置…",
            "ja": "感度設定…",
        ],
        "Выход": [
            "en": "Quit",
            "de": "Beenden",
            "es": "Salir",
            "fr": "Quitter",
            "zh": "退出",
            "ja": "終了",
        ],
        "Разблокировать клавиатуру": [
            "en": "Unlock keyboard",
            "de": "Tastatur entsperren",
            "es": "Desbloquear teclado",
            "fr": "Déverrouiller le clavier",
            "zh": "解锁键盘",
            "ja": "キーボードのロック解除",
        ],
        "Состояние: тестовая блокировка": [
            "en": "Status: test lock",
            "de": "Status: Test-Sperre",
            "es": "Estado: bloqueo de prueba",
            "fr": "État : verrouillage test",
            "zh": "状态：测试锁定",
            "ja": "状態：テストロック",
        ],
        "Состояние: заблокирована": [
            "en": "Status: locked",
            "de": "Status: gesperrt",
            "es": "Estado: bloqueado",
            "fr": "État : verrouillé",
            "zh": "状态：已锁定",
            "ja": "状態：ロック中",
        ],
        "Тестовая блокировка": [
            "en": "Test lock",
            "de": "Test-Sperre",
            "es": "Bloqueo de prueba",
            "fr": "Verrouillage test",
            "zh": "测试锁定",
            "ja": "テストロック",
        ],
        "CatsLock — клавиатура заблокирована": [
            "en": "CatsLock — keyboard locked",
            "de": "CatsLock — Tastatur gesperrt",
            "es": "CatsLock — teclado bloqueado",
            "fr": "CatsLock — clavier verrouillé",
            "zh": "CatsLock — 键盘已锁定",
            "ja": "CatsLock — キーボードをロック中",
        ],
        "CatsLock — клавиатура разблокирована": [
            "en": "CatsLock — keyboard unlocked",
            "de": "CatsLock — Tastatur entsperrt",
            "es": "CatsLock — teclado desbloqueado",
            "fr": "CatsLock — clavier déverrouillé",
            "zh": "CatsLock — 键盘已解锁",
            "ja": "CatsLock — キーボードのロック解除中",
        ],
        "Клавиатура разблокирована 🔓": [
            "en": "Keyboard unlocked 🔓",
            "de": "Tastatur entsperrt 🔓",
            "es": "Teclado desbloqueado 🔓",
            "fr": "Clavier déverrouillé 🔓",
            "zh": "键盘已解锁 🔓",
            "ja": "キーボードのロックを解除しました 🔓",
        ],
        "Клавиатура заблокирована 🔒": [
            "en": "Keyboard locked 🔒",
            "de": "Tastatur gesperrt 🔒",
            "es": "Teclado bloqueado 🔒",
            "fr": "Clavier verrouillé 🔒",
            "zh": "键盘已锁定 🔒",
            "ja": "キーボードをロックしました 🔒",
        ],
    ]

    private var statusItem: NSStatusItem!
    private var lockMenuItem: NSMenuItem!
    private var statusMenuItem: NSMenuItem!

    private let lockStateMutex = NSLock()
private var lockedState = false

private var isLocked: Bool {
    get {
        lockStateMutex.lock()
        defer { lockStateMutex.unlock() }
        return lockedState
    }
    set {
        lockStateMutex.lock()
        lockedState = newValue
        lockStateMutex.unlock()
    }
}
    private var isTestLock = false
    private var testUnlockWorkItem: DispatchWorkItem?
    private var accessibilityRetryTimer: DispatchSourceTimer?

    // Настройки обнаружения быстрого набора.
    private var catDetectionWindow: Double = 1.3
    private var catDetectionThreshold = 24
    private var catDetectionDistinctKeys = 9

    private var recentKeyPresses: [(time: CFTimeInterval, keyCode: CGKeyCode)] = []

    private var eventTap: CFMachPort?
    private var runLoopSource: CFRunLoopSource?

    private var lockWindow: NSPanel?
    private var mainWindow: NSWindow?
    private var donationWindow: NSWindow?
    private var donationStatusLabel: NSTextField?
    private var mainDocumentView: FlippedView?
    private var dashboardPage: NSView?
    private var settingsPage: NSView?
    private var dashboardStatusLabel: NSTextField?
    private var dashboardToggleButton: NSButton?
    private var pendingLockAnimationOrigin: NSRect?
    private var activeLockAnimationOrigin: NSRect?
    private var lockWindowTargetFrame: NSRect?

    private var intervalSlider: NSSlider!
    private var intervalValueLabel: NSTextField!

    private var pressesSlider: NSSlider!
    private var pressesValueLabel: NSTextField!

    private var distinctSlider: NSSlider!
    private var distinctValueLabel: NSTextField!

    private let toggleKeyCode: CGKeyCode = 37       // L
    private let emergencyKeyCode: CGKeyCode = 32    // U
    private let escapeKeyCode: CGKeyCode = 53       // Escape

    func applicationDidFinishLaunching(_ notification: Notification) {
        loadSettings()
        setupMenuBar()
        setupMainWindow()
        setupLockWindow()
        setupSettingsWindow()
        setupNotifications()
        setupKeyboardTap()
        scheduleAccessibilityRetry()
        updateMenuTitle()
    }

    // MARK: - Settings storage

    private func loadSettings() {
        let defaults = UserDefaults.standard

        if defaults.object(forKey: "catDetectionWindow") != nil {
            catDetectionWindow = defaults.double(forKey: "catDetectionWindow")
        }

        if defaults.object(forKey: "catDetectionThreshold") != nil {
            catDetectionThreshold = defaults.integer(forKey: "catDetectionThreshold")
        }

        if defaults.object(forKey: "catDetectionDistinctKeys") != nil {
            catDetectionDistinctKeys = defaults.integer(forKey: "catDetectionDistinctKeys")
        }
    }

    private func saveSettings() {
        let defaults = UserDefaults.standard

        defaults.set(catDetectionWindow, forKey: "catDetectionWindow")
        defaults.set(catDetectionThreshold, forKey: "catDetectionThreshold")
        defaults.set(catDetectionDistinctKeys, forKey: "catDetectionDistinctKeys")
    }

    // MARK: - Lock window

    private func setupLockWindow() {
        let panel = NSPanel(
            contentRect: NSRect(x: 0, y: 0, width: 460, height: 380),
            styleMask: [.titled, .closable],
            backing: .buffered,
            defer: false
        )

        panel.title = "CatsLock"
        panel.isReleasedWhenClosed = false
        panel.delegate = self
        panel.level = .normal
        panel.isMovableByWindowBackground = true
        panel.hidesOnDeactivate = false
        panel.appearance = NSAppearance(named: .darkAqua)
        panel.backgroundColor = NSColor(
            calibratedRed: 0.10,
            green: 0.11,
            blue: 0.13,
            alpha: 1
        )

        let content = NSView()
        content.wantsLayer = true
        content.layer?.backgroundColor = panel.backgroundColor?.cgColor
        panel.contentView = content

        let icon = NSTextField(labelWithString: "🔒")
        icon.font = .systemFont(ofSize: 48)

        let title = NSTextField(labelWithString: "CatsLock")
        title.font = .boldSystemFont(ofSize: 25)
        title.textColor = .white

        let status = NSTextField(labelWithString: L("Клавиатура заблокирована"))
        status.font = .boldSystemFont(ofSize: 19)
        status.textColor = NSColor(
            calibratedRed: 0.45,
            green: 0.82,
            blue: 0.62,
            alpha: 1
        )

        let description = NSTextField(
            labelWithString: L("Нажатия клавиш временно отключены")
        )
        description.font = .systemFont(ofSize: 13)
        description.textColor = NSColor(white: 0.72, alpha: 1)

        let shortcutTitle = NSTextField(
            labelWithString: L("Аварийная разблокировка")
        )
        shortcutTitle.font = .systemFont(ofSize: 13)
        shortcutTitle.textColor = NSColor(white: 0.62, alpha: 1)

        let shortcut = NSTextField(
            labelWithString: "Control + Option + Escape"
        )
        shortcut.font = .boldSystemFont(ofSize: 16)
        shortcut.textColor = .white

        for field in [icon, title, status, description, shortcutTitle, shortcut] {
            field.alignment = .center
        }

        let unlockButton = NSButton(
            title: L("Разблокировать"),
            target: self,
            action: #selector(unlockFromWindow)
        )

        unlockButton.bezelStyle = .rounded
        unlockButton.controlSize = .large
        unlockButton.font = .boldSystemFont(ofSize: 14)
        unlockButton.isBordered = true
        unlockButton.bezelColor = NSColor(
            calibratedRed: 0.20,
            green: 0.55,
            blue: 0.38,
            alpha: 1
        )
        unlockButton.contentTintColor = .white
        unlockButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            unlockButton.widthAnchor.constraint(equalToConstant: 190),
            unlockButton.heightAnchor.constraint(equalToConstant: 38)
        ])

        let stack = NSStackView(views: [
            icon,
            title,
            status,
            description,
            unlockButton,
            shortcutTitle,
            shortcut
        ])

        stack.orientation = .vertical
        stack.alignment = .centerX
        stack.spacing = 13
        stack.translatesAutoresizingMaskIntoConstraints = false

        content.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: content.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: content.centerYAnchor),
            stack.leadingAnchor.constraint(
                greaterThanOrEqualTo: content.leadingAnchor,
                constant: 20
            ),
            stack.trailingAnchor.constraint(
                lessThanOrEqualTo: content.trailingAnchor,
                constant: -20
            )
        ])

        lockWindow = panel
    }

    @objc private func unlockFromWindow() {
        forceUnlock()
    }

    private func forceUnlock() {
        isLocked = false
        isTestLock = false
        testUnlockWorkItem?.cancel()
        testUnlockWorkItem = nil
        recentKeyPresses.removeAll()

        if let eventTap = eventTap {
            CGEvent.tapEnable(tap: eventTap, enable: true)
        }

        DispatchQueue.main.async {
            self.updateMenuTitle()
            self.showNotification(locked: false)
            self.hideLockWindow()
        }

        print("CatsLock: принудительная разблокировка выполнена")
    }

    // MARK: - Main application window

    private func setupMainWindow() {
        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 1050, height: 740),
            styleMask: [.titled, .closable, .miniaturizable, .resizable],
            backing: .buffered,
            defer: false
        )
        window.title = "CatsLock"
        window.delegate = self
        window.minSize = NSSize(width: 680, height: 420)
        window.contentMinSize = NSSize(width: 680, height: 420)
        window.isReleasedWhenClosed = false
        window.center()

        let root = AdaptiveBackgroundView()
        root.wantsLayer = true
        root.layer?.backgroundColor = cgColor(.windowBackgroundColor, for: window.effectiveAppearance)
        window.contentView = root

        // Scroll view занимает всю ширину основного окна.
        let scrollView = NSScrollView()
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false
        scrollView.autohidesScrollers = true
        scrollView.borderType = .noBorder
        scrollView.drawsBackground = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        root.addSubview(scrollView)

        // FlippedView задаёт координаты сверху вниз: контент начинается сверху.
        let document = FlippedView()
        document.translatesAutoresizingMaskIntoConstraints = false
        scrollView.documentView = document

        let eyebrow = NSTextField(labelWithString: L("ЦЕНТР ЗАЩИТЫ"))
        eyebrow.font = .boldSystemFont(ofSize: 11)
        eyebrow.textColor = .secondaryLabelColor
        eyebrow.alignment = .center
        let heading = NSTextField(labelWithString: "CatsLock")
        heading.font = .boldSystemFont(ofSize: 30)
        heading.alignment = .center
        let intro = NSTextField(
            wrappingLabelWithString: L(
                "Защита клавиатуры от случайных нажатий.\nКонтролируйте блокировку и настройте обнаружение."
            )
        )
        intro.font = .systemFont(ofSize: 13)
        intro.textColor = .secondaryLabelColor
        intro.alignment = .center

        let headingStack = NSStackView(views: [eyebrow, heading, intro])
        headingStack.orientation = .vertical
        headingStack.alignment = .centerX
        headingStack.spacing = 7

        let statusCard = NSView()
        statusCard.wantsLayer = true
        statusCard.identifier = NSUserInterfaceItemIdentifier("catslock.card")
        statusCard.layer?.backgroundColor = cgColor(.controlBackgroundColor, for: window.effectiveAppearance)
        statusCard.layer?.cornerRadius = 16
        statusCard.translatesAutoresizingMaskIntoConstraints = false

        let statusIcon = NSTextField(labelWithString: "🛡️")
        statusIcon.font = .systemFont(ofSize: 34)
        let statusTitle = NSTextField(labelWithString: L("Состояние защиты"))
        statusTitle.font = .systemFont(ofSize: 13)
        statusTitle.textColor = .secondaryLabelColor
        statusTitle.alignment = .center
        let statusLabel = NSTextField(wrappingLabelWithString: L("Клавиатура доступна"))
        statusLabel.font = .boldSystemFont(ofSize: 22)
        statusLabel.alignment = .center
        dashboardStatusLabel = statusLabel
        let statusDescription = NSTextField(wrappingLabelWithString: L("Автоматическое обнаружение работает в фоне."))
        statusDescription.font = .systemFont(ofSize: 12)
        statusDescription.textColor = .secondaryLabelColor
        statusDescription.alignment = .center

        let statusTextStack = NSStackView(views: [statusTitle, statusLabel, statusDescription])
        statusTextStack.orientation = .vertical
        statusTextStack.alignment = .centerX
        statusTextStack.spacing = 6
        statusTextStack.translatesAutoresizingMaskIntoConstraints = false
        statusIcon.translatesAutoresizingMaskIntoConstraints = false
        statusCard.addSubview(statusIcon)
        statusCard.addSubview(statusTextStack)

        let toggleButton = NSButton(title: L("Заблокировать клавиатуру"), target: self, action: #selector(toggleLockFromDashboard(_:)))
        toggleButton.bezelStyle = .rounded
        toggleButton.controlSize = .large
        toggleButton.font = .boldSystemFont(ofSize: 13)
        toggleButton.translatesAutoresizingMaskIntoConstraints = false
        dashboardToggleButton = toggleButton
        statusCard.addSubview(toggleButton)

        let quickTitle = NSTextField(labelWithString: L("Быстрые действия"))
        quickTitle.font = .boldSystemFont(ofSize: 17)
        quickTitle.alignment = .center
        let quickTest = makeActionCard(title: L("Проверить защиту"), detail: L("Тестовая блокировка на 7 секунд"), symbol: "checkmark.shield", action: #selector(testProtectionFromDashboard(_:)))
        let quickStack = NSStackView(views: [quickTest])
        quickStack.orientation = .horizontal
        quickStack.alignment = .top
        quickStack.distribution = .fill
        quickStack.spacing = 14

        let shortcutCard = NSView()
        shortcutCard.wantsLayer = true
        shortcutCard.identifier = NSUserInterfaceItemIdentifier("catslock.card")
        shortcutCard.layer?.backgroundColor = cgColor(.controlBackgroundColor, for: window.effectiveAppearance)
        shortcutCard.layer?.cornerRadius = 12
        shortcutCard.translatesAutoresizingMaskIntoConstraints = false
        let shortcutHeading = NSTextField(labelWithString: L("Горячие клавиши"))
        shortcutHeading.font = .boldSystemFont(ofSize: 13)
        shortcutHeading.alignment = .center
        let shortcutMain = NSTextField(
            wrappingLabelWithString: "⌃  ⌥  L     \(L("Переключить блокировку"))"
        )
        shortcutMain.font = .systemFont(ofSize: 12)
        shortcutMain.alignment = .center
        let shortcutEmergency = NSTextField(
            wrappingLabelWithString: "⌃  ⌥  Esc     \(L("Аварийная разблокировка"))"
        )
        shortcutEmergency.font = .systemFont(ofSize: 12)
        shortcutEmergency.alignment = .center
        for view in [shortcutHeading, shortcutMain, shortcutEmergency] {
            view.translatesAutoresizingMaskIntoConstraints = false
            shortcutCard.addSubview(view)
        }

        let donationButton = NSButton(
            title: L("☕ Поддержать автора"),
            target: self,
            action: #selector(showDonationWindow)
        )
        donationButton.bezelStyle = .rounded
        donationButton.controlSize = .large
        donationButton.contentTintColor = .systemPink

        let pageStack = NSStackView(views: [
            headingStack, statusCard, quickTitle, quickStack, shortcutCard, donationButton
        ])
        pageStack.orientation = .vertical
        pageStack.alignment = .centerX
        pageStack.spacing = 18
        pageStack.translatesAutoresizingMaskIntoConstraints = false
        document.addSubview(pageStack)

        // Кнопка настроек находится внутри страницы, чтобы displayMainPage не удалял её.
        let settingsButton = NSButton(title: "", target: self, action: #selector(openSettingsFromDashboard(_:)))
        settingsButton.image = NSImage(systemSymbolName: "gearshape", accessibilityDescription: L("Настройки"))
        settingsButton.bezelStyle = .rounded
        settingsButton.isBordered = true
        settingsButton.toolTip = L("Настройки")
        settingsButton.setAccessibilityLabel(L("Настройки"))
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        pageStack.addSubview(settingsButton)
        NSLayoutConstraint.activate([
            settingsButton.topAnchor.constraint(equalTo: pageStack.topAnchor, constant: -12),
            settingsButton.trailingAnchor.constraint(equalTo: pageStack.trailingAnchor, constant: 0),
            settingsButton.widthAnchor.constraint(equalToConstant: 36),
            settingsButton.heightAnchor.constraint(equalToConstant: 36)
        ])
        mainDocumentView = document
        dashboardPage = pageStack

        NSLayoutConstraint.activate([
            // Scroll view должен занимать всю область основного окна.
            scrollView.leadingAnchor.constraint(equalTo: root.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: root.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: root.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: root.bottomAnchor),

            // Документ всегда равен видимой ширине, высота определяется контентом.
            document.widthAnchor.constraint(equalTo: scrollView.contentView.widthAnchor),
            headingStack.widthAnchor.constraint(equalTo: pageStack.widthAnchor),
            statusCard.widthAnchor.constraint(equalTo: pageStack.widthAnchor),
            statusCard.heightAnchor.constraint(greaterThanOrEqualToConstant: 112),
            statusIcon.leadingAnchor.constraint(equalTo: statusCard.leadingAnchor, constant: 22),
            statusIcon.centerYAnchor.constraint(equalTo: statusCard.centerYAnchor),
            statusTextStack.leadingAnchor.constraint(equalTo: statusIcon.trailingAnchor, constant: 18),
            statusTextStack.centerYAnchor.constraint(equalTo: statusCard.centerYAnchor),
            statusTextStack.widthAnchor.constraint(greaterThanOrEqualToConstant: 180),
            statusTextStack.trailingAnchor.constraint(lessThanOrEqualTo: toggleButton.leadingAnchor, constant: -14),
            toggleButton.trailingAnchor.constraint(equalTo: statusCard.trailingAnchor, constant: -20),
            toggleButton.centerYAnchor.constraint(equalTo: statusCard.centerYAnchor),
            toggleButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 145),

            quickTitle.widthAnchor.constraint(equalTo: pageStack.widthAnchor),
            quickStack.widthAnchor.constraint(equalTo: pageStack.widthAnchor),
            quickStack.heightAnchor.constraint(greaterThanOrEqualToConstant: 120),
            quickTest.widthAnchor.constraint(greaterThanOrEqualToConstant: 180),

            shortcutCard.widthAnchor.constraint(equalTo: pageStack.widthAnchor),
            shortcutCard.heightAnchor.constraint(equalToConstant: 100),
            shortcutHeading.topAnchor.constraint(equalTo: shortcutCard.topAnchor, constant: 14),
            shortcutHeading.centerXAnchor.constraint(equalTo: shortcutCard.centerXAnchor),
            shortcutHeading.widthAnchor.constraint(equalTo: shortcutCard.widthAnchor, constant: -32),
            shortcutMain.topAnchor.constraint(equalTo: shortcutHeading.bottomAnchor, constant: 8),
            shortcutMain.centerXAnchor.constraint(equalTo: shortcutCard.centerXAnchor),
            shortcutMain.widthAnchor.constraint(equalTo: shortcutCard.widthAnchor, constant: -32),
            shortcutEmergency.topAnchor.constraint(equalTo: shortcutMain.bottomAnchor, constant: 4),
            shortcutEmergency.centerXAnchor.constraint(equalTo: shortcutCard.centerXAnchor),
            shortcutEmergency.widthAnchor.constraint(equalTo: shortcutCard.widthAnchor, constant: -32)
        ])

        mainWindow = window
        displayMainPage(dashboardPage)
        root.refreshAppearanceColors()
        NSApp.setActivationPolicy(.regular)
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    private func displayMainPage(_ page: NSView?) {
        guard let document = mainDocumentView, let page = page else { return }

        // Сначала полностью убираем предыдущую страницу, затем добавляем новую.
        // Без анимационного слоя: AppKit сохраняет штатную обработку кликов.
        document.subviews.forEach { $0.removeFromSuperview() }
        page.translatesAutoresizingMaskIntoConstraints = false
        page.alphaValue = 1
        document.addSubview(page)
        NSLayoutConstraint.activate([
            page.topAnchor.constraint(equalTo: document.topAnchor, constant: 28),
            page.leadingAnchor.constraint(equalTo: document.leadingAnchor, constant: 32),
            page.trailingAnchor.constraint(equalTo: document.trailingAnchor, constant: -32),
            page.bottomAnchor.constraint(equalTo: document.bottomAnchor, constant: -28)
        ])
        mainWindow?.contentView?.layoutSubtreeIfNeeded()
    }

    private static let donationWallets: [(name: String, address: String)] = [
        ("BTC", "bc1q259xvrs9gvnr7pzyfaswp73harxnl8hyvwwvqw"),
        ("ETH (ERC20)", "0x646378b62c3e32cb293b61ffb1c84244d8d61f69"),
        ("USDT (TRC20)", "TMkG5Y1yxgPLSEegyYeA8pYTmuagPnrxAJ"),
        ("Monero (XMR)", "4HR2jnRAwm3SFP4r8KzxBxEKsVHKLvZ29Pxz8Qm3uqHY5aD9Kj1De2Y1W8S18fYjh9acS9NkK4VNje5pC2gVq3aYVZzLEtjf8UnUfkuTri")
    ]

    @objc private func showDonationWindow() {
        if let donationWindow {
            donationWindow.makeKeyAndOrderFront(nil)
            NSApp.activate(ignoringOtherApps: true)
            return
        }

        let window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 620, height: 610),
            styleMask: [.titled, .closable],
            backing: .buffered,
            defer: false
        )
        window.title = L("Поддержать проект")
        window.isReleasedWhenClosed = false
        window.delegate = self
        window.center()

        let heading = NSTextField(labelWithString: L("Поддержать проект"))
        heading.font = .boldSystemFont(ofSize: 22)
        heading.alignment = .center

        let explanation = NSTextField(wrappingLabelWithString: L("Спасибо за поддержку CatsLock! Выберите удобный способ."))
        explanation.font = .systemFont(ofSize: 13)
        explanation.textColor = .secondaryLabelColor
        explanation.alignment = .center

        let boostyButton = NSButton(
            title: "☕  \(L("Поддержать на Boosty"))",
            target: self,
            action: #selector(openBoostyDonationPage)
        )
        boostyButton.bezelStyle = .rounded
        boostyButton.controlSize = .large
        boostyButton.contentTintColor = .systemPink

        let walletHeading = NSTextField(labelWithString: L("Криптовалютные кошельки"))
        walletHeading.font = .boldSystemFont(ofSize: 14)

        let walletRows = Self.donationWallets.enumerated().map { index, wallet in
            makeDonationWalletRow(wallet, index: index)
        }
        let walletStack = NSStackView(views: walletRows)
        walletStack.orientation = .vertical
        walletStack.alignment = .leading
        walletStack.spacing = 10

        let statusLabel = NSTextField(labelWithString: "")
        statusLabel.font = .systemFont(ofSize: 12)
        statusLabel.textColor = .systemGreen
        statusLabel.alignment = .center
        statusLabel.isHidden = true
        donationStatusLabel = statusLabel

        let closeButton = NSButton(
            title: L("Закрыть"),
            target: self,
            action: #selector(closeDonationWindow)
        )
        closeButton.bezelStyle = .rounded

        let stack = NSStackView(views: [
            heading, explanation, boostyButton, walletHeading, walletStack,
            statusLabel, closeButton
        ])
        stack.orientation = .vertical
        stack.alignment = .centerX
        stack.spacing = 14
        stack.translatesAutoresizingMaskIntoConstraints = false

        let content = NSView()
        content.addSubview(stack)
        window.contentView = content
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -24),
            stack.topAnchor.constraint(equalTo: content.topAnchor, constant: 20),
            stack.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -20),
            walletStack.widthAnchor.constraint(equalTo: stack.widthAnchor),
            boostyButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 36)
        ])

        donationWindow = window
        window.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }

    private func makeDonationWalletRow(
        _ wallet: (name: String, address: String),
        index: Int
    ) -> NSView {
        let nameLabel = NSTextField(labelWithString: wallet.name)
        nameLabel.font = .boldSystemFont(ofSize: 12)

        let copyButton = NSButton(
            title: L("Скопировать адрес"),
            target: self,
            action: #selector(copyDonationAddress(_:))
        )
        copyButton.bezelStyle = .rounded
        copyButton.tag = index

        let header = NSStackView(views: [nameLabel, copyButton])
        header.orientation = .horizontal
        header.alignment = .centerY
        header.distribution = .equalSpacing

        let addressLabel = NSTextField(wrappingLabelWithString: wallet.address)
        addressLabel.font = .monospacedSystemFont(ofSize: 10, weight: .regular)
        addressLabel.textColor = .secondaryLabelColor
        addressLabel.isSelectable = true
        addressLabel.lineBreakMode = .byCharWrapping

        let row = NSStackView(views: [header, addressLabel])
        row.orientation = .vertical
        row.alignment = .leading
        row.spacing = 4
        row.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            header.widthAnchor.constraint(equalTo: row.widthAnchor),
            addressLabel.widthAnchor.constraint(equalTo: row.widthAnchor)
        ])
        return row
    }

    @objc private func copyDonationAddress(_ sender: NSButton) {
        guard Self.donationWallets.indices.contains(sender.tag) else {
            print("CatsLock: неизвестный индекс криптокошелька")
            NSSound.beep()
            return
        }

        let address = Self.donationWallets[sender.tag].address
        NSPasteboard.general.clearContents()
        guard NSPasteboard.general.setString(address, forType: .string) else {
            showDonationError(L("Не удалось скопировать адрес."))
            return
        }

        donationStatusLabel?.stringValue = L("Адрес скопирован")
        donationStatusLabel?.isHidden = false
    }

    @objc private func openBoostyDonationPage() {
        guard let url = URL(string: "https://boosty.to/panaix/donate"),
              NSWorkspace.shared.open(url) else {
            showDonationError(L("Не удалось открыть Boosty в браузере."))
            return
        }
    }

    @objc private func closeDonationWindow() {
        donationWindow?.close()
        donationWindow = nil
    }

    private func showDonationError(_ message: String) {
        let alert = NSAlert()
        alert.messageText = message
        alert.alertStyle = .warning
        alert.addButton(withTitle: L("Понятно"))
        alert.runModal()
    }

    private func makeActionCard(title: String, detail: String, symbol: String, action: Selector) -> NSView {
        let card = NSView()
        card.wantsLayer = true
        card.identifier = NSUserInterfaceItemIdentifier("catslock.card")
        card.layer?.backgroundColor = cgColor(.controlBackgroundColor, for: mainWindow?.effectiveAppearance ?? NSApp.effectiveAppearance)
        card.layer?.cornerRadius = 12
        let icon = NSTextField(labelWithString: symbol == "checkmark.shield" ? "🛡️" : "⚙️")
        icon.font = .systemFont(ofSize: 20)
        let heading = NSTextField(labelWithString: title)
        heading.font = .boldSystemFont(ofSize: 12)
        heading.alignment = .center
        let desc = NSTextField(wrappingLabelWithString: detail)
        desc.font = .systemFont(ofSize: 11)
        desc.textColor = .secondaryLabelColor
        desc.alignment = .center
        let button = NSButton(title: L("Открыть"), target: self, action: action)
        button.bezelStyle = .rounded
        let stack = NSStackView(views: [icon, heading, desc, button])
        stack.orientation = .vertical
        stack.alignment = .centerX
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 14),
            stack.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -10),
            stack.topAnchor.constraint(equalTo: card.topAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -8)
        ])
        return card
    }

    private func screenRect(for view: NSView) -> NSRect? {
        guard let hostWindow = view.window else { return nil }
        let rectInWindow = view.convert(view.bounds, to: nil)
        return hostWindow.convertToScreen(rectInWindow)
    }

    @objc private func toggleLockFromDashboard(_ sender: NSButton) {
        pendingLockAnimationOrigin = screenRect(for: sender)
        toggleLockFromMenu()
    }

    @objc private func testProtectionFromDashboard(_ sender: NSButton) {
        pendingLockAnimationOrigin = screenRect(for: sender)
        testProtection()
    }

    @objc private func openSettingsFromDashboard(_ sender: NSButton) {
        showSettingsWindow()
    }

    @objc private func showDashboard() {
        guard let window = mainWindow else { return }
        displayMainPage(dashboardPage)
        if let page = dashboardPage {
            page.wantsLayer = true
            let opacity = CABasicAnimation(keyPath: "opacity")
            opacity.fromValue = 0.35
            opacity.toValue = 1.0
            let scale = CABasicAnimation(keyPath: "transform.scale")
            scale.fromValue = 0.965
            scale.toValue = 1.0
            let group = CAAnimationGroup()
            group.animations = [opacity, scale]
            group.duration = 0.28
            group.timingFunction = CAMediaTimingFunction(name: .easeOut)
            page.layer?.add(group, forKey: "catslock.page.genie")
        }
        NSApp.activate(ignoringOtherApps: true)
        window.makeKeyAndOrderFront(nil)
        window.orderFrontRegardless()
    }

    // Повторное открытие приложения через Dock после закрытия окна.
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows: Bool) -> Bool {
        showDashboard()
        return true
    }

    private func showLockWindow() {
        guard let window = lockWindow else { return }
        window.center()
        let target = window.frame
        lockWindowTargetFrame = target
        activeLockAnimationOrigin = pendingLockAnimationOrigin
        NSApp.activate(ignoringOtherApps: true)

        if let origin = pendingLockAnimationOrigin {
            let center = NSPoint(x: origin.midX, y: origin.midY)
            let start = NSRect(x: center.x - 34, y: center.y - 24, width: 68, height: 48)
            window.setFrame(start, display: true)
            window.alphaValue = 0.92
            window.makeKeyAndOrderFront(nil)
            NSAnimationContext.runAnimationGroup { context in
                context.duration = 0.38
                context.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
                window.animator().setFrame(target, display: true)
                window.animator().alphaValue = 1.0
            }
        } else {
            window.setFrame(target, display: true)
            window.alphaValue = 1
            window.makeKeyAndOrderFront(nil)
        }
        window.orderFrontRegardless()
        pendingLockAnimationOrigin = nil
    }

    private func hideLockWindow() {
        guard let window = lockWindow, window.isVisible else { return }
        let finalFrame = lockWindowTargetFrame ?? window.frame
        let center: NSPoint
        if let origin = activeLockAnimationOrigin {
            center = NSPoint(x: origin.midX, y: origin.midY)
        } else {
            center = NSPoint(x: window.frame.midX, y: window.frame.midY)
        }
        let endFrame = NSRect(x: center.x - 34, y: center.y - 24, width: 68, height: 48)
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.28
            context.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            window.animator().setFrame(endFrame, display: true)
            window.animator().alphaValue = 0.75
        }, completionHandler: {
            window.orderOut(nil)
            window.setFrame(finalFrame, display: true)
            window.alphaValue = 1
            self.activeLockAnimationOrigin = nil
        })
        pendingLockAnimationOrigin = nil
    }

    func windowShouldClose(_ sender: NSWindow) -> Bool {
        if sender === lockWindow {
            if isLocked {
                forceUnlock()
            }
            hideLockWindow()
            return false
        }

        if sender === mainWindow {
            // Закрываем окно, но оставляем приложение работающим в Dock и меню.
            sender.orderOut(nil)
            return false
        }

        if sender === donationWindow {
            donationWindow = nil
        }

        return true
    }

    // MARK: - Sensitivity settings page (inside the main window)

    private func setupSettingsWindow() {
        let page = NSView()

        let backButton = NSButton(
            title: L("← Назад"),
            target: self,
            action: #selector(showDashboard)
        )
        backButton.bezelStyle = .rounded
        backButton.isBordered = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        page.addSubview(backButton)

        let heading = NSTextField(labelWithString: L("Чувствительность защиты"))
        heading.font = .boldSystemFont(ofSize: 26)
        heading.alignment = .center

        let explanation = NSTextField(
            wrappingLabelWithString:
                L("Изменения сохраняются автоматически. Меньше нажатий и разных клавиш — выше чувствительность. Больший интервал даёт больше времени на набор.")
        )
        explanation.font = .systemFont(ofSize: 13)
        explanation.textColor = NSColor.secondaryLabelColor
        explanation.alignment = .center

        let languageLabel = NSTextField(labelWithString: L("Язык интерфейса"))
        languageLabel.font = .systemFont(ofSize: 13)
        let languagePicker = NSPopUpButton()
        let languageOptions: [(String, String)] = [
            ("ru", "Русский"), ("en", "English"), ("de", "Deutsch"),
            ("es", "Español"), ("fr", "Français"), ("zh", "中文（简体）"), ("ja", "日本語")
        ]
        for option in languageOptions { languagePicker.addItem(withTitle: option.1); languagePicker.lastItem?.representedObject = option.0 }
        if let index = languageOptions.firstIndex(where: { $0.0 == interfaceLanguage }) { languagePicker.selectItem(at: index) }
        languagePicker.target = self
        languagePicker.action = #selector(interfaceLanguageChanged(_:))
        languagePicker.translatesAutoresizingMaskIntoConstraints = false
        let languageRow = NSStackView(views: [languageLabel, languagePicker])
        languageRow.orientation = .horizontal
        languageRow.alignment = .centerY
        languageRow.spacing = 12

        intervalSlider = makeSlider(
            tag: 1, min: 0.5, max: 3.0, value: catDetectionWindow
        )
        intervalValueLabel = makeValueLabel(
            String(format: "%.1f %@", catDetectionWindow, L("сек."))
        )

        pressesSlider = makeSlider(
            tag: 2, min: 10, max: 40, value: Double(catDetectionThreshold)
        )
        pressesValueLabel = makeValueLabel("\(catDetectionThreshold)")

        distinctSlider = makeSlider(
            tag: 3, min: 4, max: 15, value: Double(catDetectionDistinctKeys)
        )
        distinctValueLabel = makeValueLabel("\(catDetectionDistinctKeys)")

        let intervalRow = makeSettingsRow(
            title: L("Окно анализа"), slider: intervalSlider, valueLabel: intervalValueLabel
        )
        let pressesRow = makeSettingsRow(
            title: L("Количество нажатий"), slider: pressesSlider, valueLabel: pressesValueLabel
        )
        let distinctRow = makeSettingsRow(
            title: L("Разных клавиш"), slider: distinctSlider, valueLabel: distinctValueLabel
        )

        let testButton = NSButton(
            title: L("Проверить защиту"),
            target: self,
            action: #selector(testProtection)
        )
        testButton.bezelStyle = .rounded
        testButton.controlSize = .large

        let stack = NSStackView(views: [
            heading,
            explanation,
            languageRow,
            intervalRow,
            pressesRow,
            distinctRow,
            testButton
        ])
        stack.orientation = .vertical
        stack.alignment = .centerX
        stack.spacing = 18
        stack.translatesAutoresizingMaskIntoConstraints = false
        page.addSubview(stack)

        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(
                equalTo: page.leadingAnchor, constant: 20
            ),
            backButton.topAnchor.constraint(
                equalTo: page.topAnchor, constant: 12
            ),
            stack.topAnchor.constraint(equalTo: page.topAnchor, constant: 60),
            stack.leadingAnchor.constraint(equalTo: page.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: page.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: page.bottomAnchor),
            intervalRow.widthAnchor.constraint(equalTo: stack.widthAnchor),
            pressesRow.widthAnchor.constraint(equalTo: stack.widthAnchor),
            distinctRow.widthAnchor.constraint(equalTo: stack.widthAnchor),
            languageRow.widthAnchor.constraint(equalTo: stack.widthAnchor)
        ])

        settingsPage = page
    }

    @objc private func interfaceLanguageChanged(_ sender: NSPopUpButton) {
        guard let code = sender.selectedItem?.representedObject as? String else { return }
        UserDefaults.standard.set(code, forKey: "catslock.language")
        let alert = NSAlert()
        alert.messageText = L("Язык сохранён")
        alert.informativeText = L("Изменение языка полностью применится после перезапуска CatsLock.")
        alert.addButton(withTitle: L("Понятно"))
        alert.runModal()
    }

    private func makeSlider(
        tag: Int,
        min: Double,
        max: Double,
        value: Double
    ) -> NSSlider {
        let slider = NSSlider()
        slider.minValue = min
        slider.maxValue = max
        slider.doubleValue = value
        slider.tag = tag
        slider.target = self
        slider.action = #selector(sensitivityChanged(_:))
        slider.isContinuous = true
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }

    private func makeValueLabel(_ value: String) -> NSTextField {
        let label = NSTextField(labelWithString: value)
        label.font = .monospacedDigitSystemFont(ofSize: 12, weight: .medium)
        label.alignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.widthAnchor.constraint(equalToConstant: 65)
        ])

        return label
    }

    private func makeSettingsRow(
        title: String,
        slider: NSSlider,
        valueLabel: NSTextField
    ) -> NSView {
        let titleLabel = NSTextField(labelWithString: title)
        titleLabel.font = .systemFont(ofSize: 13)

        let row = NSStackView(views: [
            titleLabel,
            slider,
            valueLabel
        ])

        row.orientation = .horizontal
        row.alignment = .centerY
        row.spacing = 10
        row.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: 145),
            slider.widthAnchor.constraint(greaterThanOrEqualToConstant: 100)
        ])

        return row
    }

    @objc private func sensitivityChanged(_ sender: NSSlider) {
        switch sender.tag {
        case 1:
            catDetectionWindow = sender.doubleValue
            intervalValueLabel.stringValue =
                String(format: "%.1f %@", catDetectionWindow, L("сек."))

        case 2:
            catDetectionThreshold = Int(sender.doubleValue.rounded())
            sender.doubleValue = Double(catDetectionThreshold)
            pressesValueLabel.stringValue = "\(catDetectionThreshold)"

        case 3:
            catDetectionDistinctKeys = Int(sender.doubleValue.rounded())
            sender.doubleValue = Double(catDetectionDistinctKeys)
            distinctValueLabel.stringValue = "\(catDetectionDistinctKeys)"

        default:
            break
        }

        saveSettings()
        recentKeyPresses.removeAll()
    }

    private func showSettingsWindow() {
        guard let window = mainWindow, let page = settingsPage else { return }
        displayMainPage(page)
        page.wantsLayer = true
        let opacity = CABasicAnimation(keyPath: "opacity")
        opacity.fromValue = 0.35
        opacity.toValue = 1.0
        let scale = CABasicAnimation(keyPath: "transform.scale")
        scale.fromValue = 0.965
        scale.toValue = 1.0
        let group = CAAnimationGroup()
        group.animations = [opacity, scale]
        group.duration = 0.28
        group.timingFunction = CAMediaTimingFunction(name: .easeOut)
        page.layer?.add(group, forKey: "catslock.page.genie")
        NSApp.activate(ignoringOtherApps: true)
        window.makeKeyAndOrderFront(nil)
        window.orderFrontRegardless()
    }

    // MARK: - Protection test

    @objc private func testProtection() {
        guard !isLocked else {
            NSSound.beep()
            return
        }

        guard eventTap != nil else {
            print("CatsLock: невозможно запустить тестовую блокировку без Accessibility")
            NSSound.beep()
            return
        }

        isTestLock = true
        setLocked(true)

        let workItem = DispatchWorkItem { [weak self] in
            guard let self = self, self.isTestLock else { return }

            self.isTestLock = false
            self.setLocked(false)
        }

        testUnlockWorkItem?.cancel()
        testUnlockWorkItem = workItem

        DispatchQueue.main.asyncAfter(
            deadline: .now() + 7,
            execute: workItem
        )
    }

    // MARK: - Notifications

    private func setupNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound]
        ) { granted, error in
            if let error = error {
                print("CatsLock: ошибка уведомлений: \(error.localizedDescription)")
            } else if granted {
                print("CatsLock: разрешение на уведомления получено")
            }
        }
    }

    private func showNotification(locked: Bool) {
        let content = UNMutableNotificationContent()
        content.title = "CatsLock"
        content.body = locked
            ? L("Клавиатура заблокирована 🔒")
            : L("Клавиатура разблокирована 🔓")
        content.sound = .default

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: nil
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("CatsLock: ошибка уведомления: \(error.localizedDescription)")
            }
        }
    }

    // MARK: - Lock state

    private func setLocked(_ locked: Bool) {
        guard isLocked != locked else { return }

        isLocked = locked
        recentKeyPresses.removeAll()

        if !locked {
            isTestLock = false
            testUnlockWorkItem?.cancel()
            testUnlockWorkItem = nil
        }

        updateMenuTitle()
        showNotification(locked: locked)

        if locked {
            showLockWindow()
            print("CatsLock: клавиатура заблокирована")
        } else {
            hideLockWindow()
            print("CatsLock: клавиатура разблокирована")
        }
    }

    // MARK: - Menu bar

    private func setupMenuBar() {
        statusItem = NSStatusBar.system.statusItem(
            withLength: NSStatusItem.squareLength
        )

        if let button = statusItem.button {
            button.title = "🐱"
            button.toolTip = L("CatsLock — клавиатура разблокирована")
        }

        let menu = NSMenu()

        statusMenuItem = NSMenuItem(
            title: L("Состояние: разблокирована"),
            action: nil,
            keyEquivalent: ""
        )
        statusMenuItem.isEnabled = false
        menu.addItem(statusMenuItem)

        let dashboardItem = NSMenuItem(
            title: L("Открыть CatsLock"),
            action: #selector(showDashboard),
            keyEquivalent: ""
        )
        dashboardItem.target = self
        menu.addItem(dashboardItem)

        menu.addItem(NSMenuItem.separator())

        lockMenuItem = NSMenuItem(
            title: L("Заблокировать клавиатуру"),
            action: #selector(toggleLockFromMenu),
            keyEquivalent: ""
        )

        lockMenuItem.target = self
        menu.addItem(lockMenuItem)

        let settingsItem = NSMenuItem(
            title: L("Настройки чувствительности…"),
            action: #selector(openSettingsFromMenu),
            keyEquivalent: ""
        )

        settingsItem.target = self
        menu.addItem(settingsItem)

        let testItem = NSMenuItem(
            title: L("Проверить защиту"),
            action: #selector(testProtection),
            keyEquivalent: ""
        )

        testItem.target = self
        menu.addItem(testItem)

        menu.addItem(NSMenuItem.separator())

        let quitItem = NSMenuItem(
            title: L("Выход"),
            action: #selector(quitApp),
            keyEquivalent: "q"
        )

        quitItem.target = self
        menu.addItem(quitItem)

        statusItem.menu = menu
    }

    @objc private func openSettingsFromMenu() {
        showSettingsWindow()
    }

    @objc private func toggleLockFromMenu() {
        guard eventTap != nil else {
            print("CatsLock: блокировка недоступна")
            NSSound.beep()
            return
        }

        setLocked(!isLocked)
    }

    @objc private func quitApp() {
        setLocked(false)
        NSApp.terminate(nil)
    }

    private func updateMenuTitle() {
        lockMenuItem?.title = isLocked
            ? L("Разблокировать клавиатуру")
            : L("Заблокировать клавиатуру")

        statusMenuItem?.title = isLocked
            ? (isTestLock
                ? L("Состояние: тестовая блокировка")
                : L("Состояние: заблокирована"))
            : L("Состояние: разблокирована")

        dashboardStatusLabel?.stringValue = isLocked
            ? (isTestLock ? L("Тестовая блокировка") : L("Клавиатура заблокирована"))
            : L("Клавиатура доступна")
        dashboardToggleButton?.title = isLocked ? L("Разблокировать") : L("Заблокировать клавиатуру")

        if let button = statusItem?.button {
            button.title = isLocked ? "🔒" : "🐱"
            button.toolTip = isLocked
                ? L("CatsLock — клавиатура заблокирована")
                : L("CatsLock — клавиатура разблокирована")
        }
    }

    // MARK: - Accessibility / keyboard tap

    private func scheduleAccessibilityRetry() {
        accessibilityRetryTimer?.cancel()
        accessibilityRetryTimer = DispatchSource.makeTimerSource(queue: .main)
        accessibilityRetryTimer?.schedule(deadline: .now() + 2.0, repeating: 2.0)
        accessibilityRetryTimer?.setEventHandler { [weak self] in
            guard let self = self else { return }
            self.setupKeyboardTap()
        }
        accessibilityRetryTimer?.resume()
    }

    private func stopAccessibilityRetry() {
        accessibilityRetryTimer?.cancel()
        accessibilityRetryTimer = nil
    }

    private func setupKeyboardTap() {
        print("CatsLock: проверяю разрешение Accessibility")

        let options = [
            kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String: false
        ] as CFDictionary

        guard AXIsProcessTrustedWithOptions(options) else {
            print("ОШИБКА: нет разрешения Accessibility")
            updateMenuTitle()
            return
        }

        stopAccessibilityRetry()
        print("CatsLock: разрешение есть")

        if eventTap != nil {
            CGEvent.tapEnable(tap: eventTap!, enable: true)
            print("CatsLock: перехват уже существует; повторно активирован")
            return
        }

        let eventMask =
            (1 << CGEventType.keyDown.rawValue) |
            (1 << CGEventType.keyUp.rawValue)

        guard let newEventTap = CGEvent.tapCreate(
            tap: .cgSessionEventTap,
            place: .headInsertEventTap,
            options: .defaultTap,
            eventsOfInterest: CGEventMask(eventMask),
            callback: { proxy, type, event, refcon in
                guard let refcon = refcon else {
                    return Unmanaged.passUnretained(event)
                }

                let app = Unmanaged<AppDelegate>
                    .fromOpaque(refcon)
                    .takeUnretainedValue()

                return app.handleKeyboardEvent(
                    proxy: proxy,
                    type: type,
                    event: event
                )
            },
            userInfo: UnsafeMutableRawPointer(
                Unmanaged.passUnretained(self).toOpaque()
            )
        ) else {
            print("ОШИБКА: не удалось создать перехват клавиатуры")
            return
        }

        eventTap = newEventTap

        guard let source = CFMachPortCreateRunLoopSource(
            kCFAllocatorDefault,
            newEventTap,
            0
        ) else {
            print("ОШИБКА: не удалось создать RunLoop source")
            eventTap = nil
            return
        }

        runLoopSource = source

        CFRunLoopAddSource(
            CFRunLoopGetCurrent(),
            source,
            .commonModes
        )

        CGEvent.tapEnable(tap: newEventTap, enable: true)

        print("CatsLock: перехват создан и включён; готово")
    }

    // MARK: - Keyboard events

    private func handleKeyboardEvent(
        proxy: CGEventTapProxy,
        type: CGEventType,
        event: CGEvent
    ) -> Unmanaged<CGEvent>? {

        if type == .tapDisabledByTimeout ||
           type == .tapDisabledByUserInput {

            if let eventTap = eventTap {
                CGEvent.tapEnable(tap: eventTap, enable: true)
            }

            return Unmanaged.passUnretained(event)
        }

        if type == .keyUp {
            if isLocked {
                return nil
            }

            return Unmanaged.passUnretained(event)
        }

        guard type == .keyDown else {
            return Unmanaged.passUnretained(event)
        }

        let keyCode = CGKeyCode(
            event.getIntegerValueField(.keyboardEventKeycode)
        )

        let flags = event.flags
        let controlPressed = flags.contains(.maskControl)
        let optionPressed = flags.contains(.maskAlternate)
        let shiftPressed = flags.contains(.maskShift)
        let commandPressed = flags.contains(.maskCommand)

        let isAutorepeat =
            event.getIntegerValueField(.keyboardEventAutorepeat) != 0

        // Аварийная разблокировка:
        // Control + Option + Escape
        // либо Control + Option + Shift + U.
        let emergencyUnlock =
            controlPressed &&
            optionPressed &&
            (
                (keyCode == emergencyKeyCode && shiftPressed) ||
                keyCode == escapeKeyCode
            )

        if emergencyUnlock {
            setLocked(false)
            recentKeyPresses.removeAll()
            return nil
        }

        // Основное переключение: Control + Option + L.
        if keyCode == toggleKeyCode &&
           controlPressed &&
           optionPressed &&
           !shiftPressed {

            setLocked(!isLocked)
            return nil
        }

        if isLocked {
            return nil
        }

        let hasModifier =
            controlPressed ||
            optionPressed ||
            shiftPressed ||
            commandPressed

        guard !hasModifier else {
            return Unmanaged.passUnretained(event)
        }

        let now = CFAbsoluteTimeGetCurrent()

        // Анализируем только новые нажатия, без автоповтора.
        if !isAutorepeat {
            recentKeyPresses.append((time: now, keyCode: keyCode))

            recentKeyPresses.removeAll {
                now - $0.time > catDetectionWindow
            }

            let distinctKeyCount = Set(
                recentKeyPresses.map { $0.keyCode }
            ).count

            if recentKeyPresses.count >= catDetectionThreshold &&
               distinctKeyCount >= catDetectionDistinctKeys {

                print(
                    "CatsLock: обнаружена серия быстрых нажатий — включаю автозащиту"
                )

                setLocked(true)
                return nil
            }
        }

        return Unmanaged.passUnretained(event)
    }
}

let app = NSApplication.shared
let delegate = AppDelegate()

app.setActivationPolicy(.regular)
app.delegate = delegate
app.run()