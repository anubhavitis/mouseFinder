// The Swift Programming Language
// https://docs.swift.org/swift-book

import AppKit
import ObjectiveC

func printImage(_ image: NSImage) {
    // Create a temporary file path
    let name = UUID().uuidString
    let filePath = "./" + name + ".png"

    // Try tiffRepresentation first (most cursors)
    if let data = image.tiffRepresentation,
        let imageRep = NSBitmapImageRep(data: data),
        let pngData = imageRep.representation(using: .png, properties: [:])
    {
        try? pngData.write(to: URL(fileURLWithPath: filePath), options: .atomic)
        print("Image saved to: \(filePath)")
        return
    }

    // Fallback: render the image directly for cursors without tiffRepresentation
    let size = image.size
    guard size.width > 0 && size.height > 0 else {
        print("Image has invalid size")
        return
    }

    let bitmapRep = NSBitmapImageRep(
        bitmapDataPlanes: nil,
        pixelsWide: Int(size.width),
        pixelsHigh: Int(size.height),
        bitsPerSample: 8,
        samplesPerPixel: 4,
        hasAlpha: true,
        isPlanar: false,
        colorSpaceName: .deviceRGB,
        bytesPerRow: 0,
        bitsPerPixel: 0
    )

    guard let bitmapRep = bitmapRep else {
        print("Failed to create bitmap representation")
        return
    }

    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: bitmapRep)
    image.draw(at: .zero, from: NSRect(origin: .zero, size: size), operation: .copy, fraction: 1.0)
    NSGraphicsContext.restoreGraphicsState()

    if let pngData = bitmapRep.representation(using: .png, properties: [:]) {
        try? pngData.write(to: URL(fileURLWithPath: filePath), options: .atomic)
        print("Image saved to: \(filePath)")
    } else {
        print("Failed to generate PNG data")
    }
}

func getCursor(cursor: NSCursor) -> String {
    let size = cursor.image.size
    let hotSpot = cursor.hotSpot

    if size.width == 23 && size.height == 22 && hotSpot.x == 12 && hotSpot.y == 11 {
        return "ibeam"
    } else if size.width == 28 && size.height == 40 && hotSpot.x == 5 && hotSpot.y == 5 {
        return "arrow"
    } else if size.width == 32 && size.height == 32 && hotSpot.x == 13 && hotSpot.y == 8 {
        return "pointingHand"
    } else {
        return "unknown"
    }
}

func allCursors() async {
    // ibeam and arrow have no tiffRepresentation
    let allCursors = [
        NSCursor.iBeam,
        NSCursor.arrow,
        NSCursor.dragLink,  // 4372537072
        NSCursor.pointingHand,  // 4372537152
        NSCursor.closedHand,  // 4372537328
        NSCursor.openHand,  // 4372537376
        NSCursor.resizeLeft,  // 4372537424
        NSCursor.resizeRight,  // 4372537472
        NSCursor.resizeUp,  // 4372537520
        NSCursor.resizeDown,  // 4372537568
        NSCursor.crosshair,  // 4372537616
        NSCursor.resizeUpDown,  // 4372537664
        NSCursor.resizeLeftRight,  // 4372537712
        NSCursor.disappearingItem,  // 4372537760
        NSCursor.operationNotAllowed,  // 4372537808
        NSCursor.dragCopy,  // 4372537856
        NSCursor.contextualMenu,  // 4372537904
    ]

    for index in 0..<allCursors.count {
        let cursor = allCursors[index]
        let image = cursor.image

        print("image at \(index)")
        printImage(image)

        sleep(2)
    }
}

func cursorToString(_ cursor: NSCursor) -> String {
    var result = "NSCursor {\n"
    result += "  hotSpot: (\(cursor.hotSpot.x), \(cursor.hotSpot.y))\n"
    result += "  image.size: (\(cursor.image.size.width) x \(cursor.image.size.height))\n"
    result += "  cursor hash: \(cursor.hash)\n"

    if let tiffData = cursor.image.tiffRepresentation {
        result += "  tiffRepresentation.count: \(tiffData.count) bytes\n"
    } else {
        result += "  tiffRepresentation: nil\n"
    }

    result += "}"
    return result
}

func test() {
    let cursor = NSCursor.currentSystem!
    print(cursorToString(cursor))
    printImage(cursor.image)
}

func main() async {
    // add sleep for 2 sec
    // sleep(3)
    // test()
    // getCursorType()

    let cursor = NSCursor.currentSystem!
    print(cursorToString(cursor))
    let myCursor = getCursor(cursor: cursor)
    print(myCursor)
}

await main()
