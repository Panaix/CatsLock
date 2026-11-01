import AppKit
import CoreGraphics
import Foundation

let root = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
let iconset = root.appendingPathComponent("PurrLock.iconset", isDirectory: true)
let fileManager = FileManager.default

try fileManager.createDirectory(at: iconset, withIntermediateDirectories: true)

let canvasSize = 1024
let bitmap = NSBitmapImageRep(
    bitmapDataPlanes: nil,
    pixelsWide: canvasSize,
    pixelsHigh: canvasSize,
    bitsPerSample: 8,
    samplesPerPixel: 4,
    hasAlpha: true,
    isPlanar: false,
    colorSpaceName: .deviceRGB,
    bytesPerRow: 0,
    bitsPerPixel: 0
)!

let graphics = NSGraphicsContext(bitmapImageRep: bitmap)!
NSGraphicsContext.saveGraphicsState()
NSGraphicsContext.current = graphics
let context = graphics.cgContext
context.setAllowsAntialiasing(true)
context.setShouldAntialias(true)
context.interpolationQuality = .high

func squirclePath(in rect: CGRect, exponent: CGFloat = 4) -> CGPath {
    let path = CGMutablePath()
    let center = CGPoint(x: rect.midX, y: rect.midY)
    let radiusX = rect.width / 2
    let radiusY = rect.height / 2
    let count = 512
    let power = 2 / exponent

    for step in 0...count {
        let angle = 2 * CGFloat.pi * CGFloat(step) / CGFloat(count)
        let cosine = cos(angle)
        let sine = sin(angle)
        let point = CGPoint(
            x: center.x + (cosine < 0 ? -1 : 1) * pow(abs(cosine), power) * radiusX,
            y: center.y + (sine < 0 ? -1 : 1) * pow(abs(sine), power) * radiusY
        )
        if step == 0 {
            path.move(to: point)
        } else {
            path.addLine(to: point)
        }
    }

    path.closeSubpath()
    return path
}

func fillEllipse(_ rect: CGRect, color: CGColor, shadow: CGSize, blur: CGFloat) {
    context.saveGState()
    context.setShadow(
        offset: shadow,
        blur: blur,
        color: CGColor(gray: 0.12, alpha: 0.25)
    )
    context.setFillColor(color)
    context.fillEllipse(in: rect)
    context.restoreGState()
}

let iconBounds = CGRect(x: 24, y: 24, width: 976, height: 976)
let backgroundPath = squirclePath(in: iconBounds)
context.addPath(backgroundPath)
context.clip()

let colorSpace = CGColorSpaceCreateDeviceRGB()
let backgroundColors = [
    CGColor(red: 0.91, green: 0.94, blue: 0.97, alpha: 1),
    CGColor(red: 0.66, green: 0.72, blue: 0.80, alpha: 1),
    CGColor(red: 0.36, green: 0.43, blue: 0.53, alpha: 1)
] as CFArray
let backgroundGradient = CGGradient(
    colorsSpace: colorSpace,
    colors: backgroundColors,
    locations: [0, 0.55, 1]
)!
context.drawLinearGradient(
    backgroundGradient,
    start: CGPoint(x: 210, y: 950),
    end: CGPoint(x: 820, y: 70),
    options: []
)

let highlight = CGGradient(
    colorsSpace: colorSpace,
    colors: [
        CGColor(red: 1, green: 1, blue: 1, alpha: 0.4),
        CGColor(red: 1, green: 1, blue: 1, alpha: 0)
    ] as CFArray,
    locations: [0, 1]
)!
context.saveGState()
context.addEllipse(in: CGRect(x: 90, y: 580, width: 900, height: 560))
context.clip()
context.drawLinearGradient(
    highlight,
    start: CGPoint(x: 500, y: 1030),
    end: CGPoint(x: 500, y: 580),
    options: []
)
context.restoreGState()

context.saveGState()
context.addPath(backgroundPath)
context.setStrokeColor(CGColor(red: 1, green: 1, blue: 1, alpha: 0.5))
context.setLineWidth(3)
context.strokePath()
context.restoreGState()

let pawColor = CGColor(red: 0.96, green: 0.97, blue: 0.99, alpha: 1)
fillEllipse(CGRect(x: 242, y: 574, width: 190, height: 222), color: pawColor, shadow: CGSize(width: 0, height: -12), blur: 20)
fillEllipse(CGRect(x: 414, y: 674, width: 190, height: 232), color: pawColor, shadow: CGSize(width: 0, height: -12), blur: 20)
fillEllipse(CGRect(x: 612, y: 652, width: 190, height: 232), color: pawColor, shadow: CGSize(width: 0, height: -12), blur: 20)
fillEllipse(CGRect(x: 770, y: 516, width: 166, height: 210), color: pawColor, shadow: CGSize(width: 0, height: -12), blur: 20)

let palm = CGMutablePath()
palm.move(to: CGPoint(x: 512, y: 538))
palm.addCurve(to: CGPoint(x: 766, y: 320), control1: CGPoint(x: 720, y: 520), control2: CGPoint(x: 840, y: 430))
palm.addCurve(to: CGPoint(x: 685, y: 151), control1: CGPoint(x: 790, y: 230), control2: CGPoint(x: 745, y: 150))
palm.addCurve(to: CGPoint(x: 512, y: 219), control1: CGPoint(x: 625, y: 152), control2: CGPoint(x: 585, y: 211))
palm.addCurve(to: CGPoint(x: 339, y: 151), control1: CGPoint(x: 439, y: 211), control2: CGPoint(x: 399, y: 152))
palm.addCurve(to: CGPoint(x: 258, y: 320), control1: CGPoint(x: 279, y: 150), control2: CGPoint(x: 234, y: 230))
palm.addCurve(to: CGPoint(x: 512, y: 538), control1: CGPoint(x: 184, y: 430), control2: CGPoint(x: 304, y: 520))
palm.closeSubpath()
context.saveGState()
context.setShadow(
    offset: CGSize(width: 0, height: -14),
    blur: 24,
    color: CGColor(gray: 0.12, alpha: 0.28)
)
context.setFillColor(pawColor)
context.addPath(palm)
context.fillPath()
context.restoreGState()

let lockColor = CGColor(red: 0.27, green: 0.34, blue: 0.43, alpha: 1)
let shackle = CGMutablePath()
shackle.move(to: CGPoint(x: 464, y: 343))
shackle.addLine(to: CGPoint(x: 464, y: 380))
shackle.addCurve(
    to: CGPoint(x: 560, y: 380),
    control1: CGPoint(x: 464, y: 442),
    control2: CGPoint(x: 560, y: 442)
)
shackle.addLine(to: CGPoint(x: 560, y: 343))
context.addPath(shackle)
context.setStrokeColor(lockColor)
context.setLineWidth(20)
context.setLineCap(.round)
context.setLineJoin(.round)
context.strokePath()

let lockBody = CGPath(
    roundedRect: CGRect(x: 426, y: 256, width: 172, height: 126),
    cornerWidth: 27,
    cornerHeight: 27,
    transform: nil
)
context.saveGState()
context.setShadow(
    offset: CGSize(width: 0, height: -5),
    blur: 9,
    color: CGColor(gray: 0.1, alpha: 0.2)
)
context.setFillColor(lockColor)
context.addPath(lockBody)
context.fillPath()
context.restoreGState()

context.setFillColor(CGColor(red: 0.96, green: 0.97, blue: 0.99, alpha: 1))
context.fillEllipse(in: CGRect(x: 495, y: 303, width: 34, height: 34))
context.addPath(
    CGPath(
        roundedRect: CGRect(x: 506, y: 278, width: 12, height: 38),
        cornerWidth: 6,
        cornerHeight: 6,
        transform: nil
    )
)
context.fillPath()

NSGraphicsContext.restoreGraphicsState()

guard let sourceImage = bitmap.cgImage else {
    fatalError("Could not create the PurrLock icon image.")
}

func writePNG(size: Int, name: String) throws {
    let output = NSBitmapImageRep(
        bitmapDataPlanes: nil,
        pixelsWide: size,
        pixelsHigh: size,
        bitsPerSample: 8,
        samplesPerPixel: 4,
        hasAlpha: true,
        isPlanar: false,
        colorSpaceName: .deviceRGB,
        bytesPerRow: 0,
        bitsPerPixel: 0
    )!
    let outputContext = NSGraphicsContext(bitmapImageRep: output)!
    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = outputContext
    outputContext.cgContext.interpolationQuality = .high
    outputContext.cgContext.draw(
        sourceImage,
        in: CGRect(x: 0, y: 0, width: size, height: size)
    )
    NSGraphicsContext.restoreGraphicsState()

    guard let data = output.representation(using: .png, properties: [:]) else {
        fatalError("Could not encode \(name) as PNG.")
    }
    try data.write(to: iconset.appendingPathComponent(name))
}

let sizes = [
    (16, "icon_16x16.png"),
    (32, "icon_16x16@2x.png"),
    (32, "icon_32x32.png"),
    (64, "icon_32x32@2x.png"),
    (128, "icon_128x128.png"),
    (256, "icon_128x128@2x.png"),
    (256, "icon_256x256.png"),
    (512, "icon_256x256@2x.png"),
    (512, "icon_512x512.png"),
    (1024, "icon_512x512@2x.png")
]

for (size, name) in sizes {
    try writePNG(size: size, name: name)
}

let previewURL = root.appendingPathComponent("PurrLock-icon-preview.png")
let preview = bitmap.representation(using: .png, properties: [:])!
try preview.write(to: previewURL)

print("Created \(iconset.path) and \(previewURL.path)")
