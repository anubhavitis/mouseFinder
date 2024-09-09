// The Swift Programming Language
// https://docs.swift.org/swift-book

import AppKit

func printImage(_ image: NSImage)  {
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

    switch count {
    case 7132:
        return "dragLink"
    case 85056:
        return "iBeam"
    case 204152:
        return "arrow"
    case 20892:
        switch image[4703] {
        case 18:
            return "pointing hand"
        case 0:
            return "closed hand"
        case 2:
            return "open hand"
        default:
            return "unknown"
        }
    case 11932:
        let valAtIndex3587 = image[3587]
        switch valAtIndex3587 {
        case 16:
            return "resizeLeft"
        case 242:
            return "resizeRight"
        case 243:
            return "resizeLeftRight"
        case 116:
            return "resizeUp"
        case 5:
            return "resizeDown"
        case 117:
            return "resizeUpDown"
        case 0:
            return "crosshair"
        default:
            return "unknown"
        }
    case 22812:
        let valAtIndex8164 = image[8164]
        switch valAtIndex8164 {
        case 237:
            return "disappearingItem"
        case 183:
            return "operationNotAllowed"
        case 81:
            return "dragCopy"
        case 173:
            return "contextualMenu"
        default:
            return "unknown"
        }
    default:
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

func getCursorType()  {
    let cursor = NSCursor.currentSystem!
     printImage(cursor.image)

    let myCursor = getCursor(cursor: cursor)
    print(myCursor)
}

getCursorType()
