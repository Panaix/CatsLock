# PurrLock — Español

[Elegir otro idioma](../../README.md)

PurrLock es una aplicación para macOS que bloquea temporalmente el teclado y
detecta pulsaciones rápidas accidentales. La interfaz está disponible en ruso,
inglés, alemán, español, francés, chino y japonés.

## Requisitos

- macOS 13 o posterior.
- Mac con procesador Intel o Apple silicon.

## Instalación

Descarga [PurrLock-Installer.dmg](https://github.com/Panaix/PurrLock/releases/latest),
abre la imagen y arrastra PurrLock a la carpeta Aplicaciones. La primera vez,
concede acceso en **Ajustes del Sistema → Privacidad y seguridad →
Accesibilidad**. PurrLock necesita este permiso para procesar eventos del
teclado y suprimir pulsaciones mientras está bloqueado.

El instalador actual tiene firma ad hoc y Apple no lo ha notarizado. macOS
puede mostrar una advertencia de Gatekeeper.

## Privacidad y seguridad

PurrLock procesa los eventos del teclado localmente. Los códigos de tecla y la
hora de cada evento se mantienen temporalmente en la memoria del proceso para
detectar pulsaciones rápidas. La aplicación no registra el texto escrito, no
guarda un historial de teclas en disco ni envía eventos del teclado por
Internet. Los ajustes se guardan localmente en `UserDefaults`; macOS entrega
las notificaciones. No hay analítica ni telemetría.

Comunica las vulnerabilidades mediante el
[canal privado de seguridad de GitHub](https://github.com/Panaix/PurrLock/security/advisories/new),
no en un Issue público. No incluyas contraseñas, datos personales ni texto
introducido. Consulta la [política de seguridad](../../SECURITY.md).

## Compilar desde el código fuente

Instala Xcode Command Line Tools y ejecuta:

```sh
xcode-select --install
./scripts/build-release.sh
```

El script crea una aplicación Universal Binary y un instalador en `build/`.
Puedes definir la versión con `VERSION` y `BUILD_NUMBER`. La firma Developer ID
y la notarización de Apple requieren un certificado de Apple Developer y aún
no están configuradas.

## Atajos de teclado

- `Control + Option + L` — activar o desactivar el bloqueo.
- `Control + Option + Escape` — desbloqueo de emergencia.

## Colaborar

Usa los [formularios de Issues](https://github.com/Panaix/PurrLock/issues/new/choose)
para informar de errores o proponer mejoras. Los pull requests deben explicar
el cambio y cómo se verificó. Consulta la [guía de colaboración](../../CONTRIBUTING.md).

## Licencia

MIT. El texto legalmente válido es el archivo [LICENSE](../../LICENSE) en inglés.
