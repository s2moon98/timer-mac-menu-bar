import AppKit

let symbolName = "hourglass"
let outputDir = "timer/Assets.xcassets/AppIcon.appiconset"

let sizes: [(String, Int)] = [
    ("icon_16x16.png", 16),
    ("icon_16x16@2x.png", 32),
    ("icon_32x32.png", 32),
    ("icon_32x32@2x.png", 64),
    ("icon_128x128.png", 128),
    ("icon_128x128@2x.png", 256),
    ("icon_256x256.png", 256),
    ("icon_256x256@2x.png", 512),
    ("icon_512x512.png", 512),
    ("icon_512x512@2x.png", 1024),
]

func renderSymbol(name: String, size: Int) -> NSImage? {
    let config = NSImage.SymbolConfiguration(pointSize: CGFloat(size) * 0.6, weight: .regular)
    guard let symbol = NSImage(systemSymbolName: name, accessibilityDescription: nil)?
        .withSymbolConfiguration(config) else { return nil }

    let image = NSImage(size: NSSize(width: size, height: size))
    image.lockFocus()

    NSColor.white.withAlphaComponent(0).setFill()
    NSRect(x: 0, y: 0, width: size, height: size).fill()

    // Draw background circle
    let bgRect = NSRect(x: 0, y: 0, width: size, height: size)
    NSColor(red: 0.2, green: 0.5, blue: 1.0, alpha: 1.0).setFill()
    NSBezierPath(roundedRect: bgRect, xRadius: CGFloat(size) * 0.22, yRadius: CGFloat(size) * 0.22).fill()

    // Draw symbol centered
    let symbolSize = symbol.size
    let x = (CGFloat(size) - symbolSize.width) / 2
    let y = (CGFloat(size) - symbolSize.height) / 2
    NSColor.white.set()
    symbol.draw(in: NSRect(x: x, y: y, width: symbolSize.width, height: symbolSize.height))

    image.unlockFocus()
    return image
}

for (filename, size) in sizes {
    guard let image = renderSymbol(name: symbolName, size: size),
          let tiff = image.tiffRepresentation,
          let bitmap = NSBitmapImageRep(data: tiff),
          let png = bitmap.representation(using: .png, properties: [:]) else {
        print("Failed: \(filename)")
        continue
    }
    let path = "\(outputDir)/\(filename)"
    try? png.write(to: URL(fileURLWithPath: path))
    print("Generated: \(filename)")
}
