// The Swift Programming Language
// https://docs.swift.org/swift-book

import AppKit

func printImage(_ image: NSImage) async {
    // Create a temporary file path

    let name = UUID().uuidString
    let filePath = "./"+name+".png"

    // print name of image

    // Save the image to the temporary file
    if let data = image.tiffRepresentation,
       let imageRep = NSBitmapImageRep(data: data),
       let pngData = imageRep.representation(using: .png, properties: [:]) {
        try? pngData.write(to: URL(fileURLWithPath: filePath), options: .atomic)
    }

    // Print the file path
    print("Image saved to: \(filePath)")
}

func getCursor(cursor: NSCursor) -> String {
    let image = cursor.image.tiffRepresentation!
    let count = image.count

    if count == 7132 {
        return "dragLink"
    }

    if count == 20892 {
        let valAtIndex4703 = image[4703]
        if valAtIndex4703 == 18 {
            return "pointing hand"
        }
        else if valAtIndex4703 == 0 {
            return "closed hand"
        }
        else if valAtIndex4703 == 2 {
            return "open hand"
        }
        else {
            return "unknown"
        }
    }
    else if count == 11932 {
        let valAtIndex3587 = image[3587]
        if valAtIndex3587 == 16 {
            return "resizeLeft"
        }
        else if valAtIndex3587 == 242 {
            return "resizeRight"
        }
        else if valAtIndex3587 == 243 {
            return "resizeLeftRight"
        }
        else if valAtIndex3587 == 116 {
            return "resizeUp"
        }
        else if valAtIndex3587 == 5 {
            return "resizeDown"
        }
        else if valAtIndex3587 == 117 {
            return "resizeUpDown"
        }
        else if valAtIndex3587 == 0 {
            return "crosshair"
        }
        else {
            return "unknown"
        }
    }
    else if count == 22812 {
        let valAtIndex8164 = image[8164]
        if valAtIndex8164 == 237 {
            return "disappearingItem"
        }
        else if valAtIndex8164 == 183 {
            return "operationNotAllowed"
        }
        else if valAtIndex8164 == 81 {
            return "dragCopy"
        }
        else if valAtIndex8164 == 173 {
            return "contextualMenu"
        }
        else {
            return "unknown"
        }
    }
    else {
        return "unknown"
    }
}

/*
func allCursors() async {
    // arrow and ibeam not found.


    let _group20892 = [
        // found unique set at index 4703, 4707, 4711,
        NSCursor.pointingHand, // count: 20892 [4703]: 18
        NSCursor.closedHand, // count: 20892 [4703]: 0
        NSCursor.openHand, // count: 20892 [4703]: 2
    ]


    let _group11932 = [
        // found unique set at index 3587, 5839, 5891, etc
        NSCursor.resizeLeft, // count: 11932 [3587]: 16
        NSCursor.resizeRight, // count: 11932 [3587]: 242   
        NSCursor.resizeLeftRight, // count: 11932 [3587]: 243   
        NSCursor.resizeUp, // count: 11932 [3587]: 116      
        NSCursor.resizeDown, // count: 11932 [3587]: 5
        NSCursor.resizeUpDown, // count: 11932 [3587]: 117
        NSCursor.crosshair, // count: 11932 [3587]: 0
    ]


    let _group22812 = [
        // found unique set at index 8164, 8165, 8166 etc
        NSCursor.disappearingItem, // count: 22812 [8164]: 237
        NSCursor.operationNotAllowed, // count: 22812 [8164]: 183
        NSCursor.dragCopy, // count: 22812 [8164]: 81
        NSCursor.contextualMenu, // count: 22812 [8164]: 173
    ]

    let _group7132 = [
        NSCursor.dragLink.image.tiffRepresentation!, // count: 7132
    ]
}
*/

func getCursorType() async {
    let cursor = NSCursor.currentSystem!
    await printImage(cursor.image)

    print(getCursor(cursor: cursor))

}

await getCursorType()
