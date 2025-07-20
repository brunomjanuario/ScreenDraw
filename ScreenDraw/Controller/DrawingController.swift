import Foundation
import Cocoa

class DrawingController: ObservableObject {
    @Published var isDrawing: Bool = false
    @Published var strokeColor = NSColor.systemYellow
}
