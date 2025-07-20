import AppKit

class AppController {
    static let shared = AppController()

    var windows: [NSWindow] = []
    
    func ignoreMouseEvents() {
        
        for window in windows {
            window.ignoresMouseEvents = true
        }
    }

    func allowMouseEvents() {
        
        for window in windows {
            window.ignoresMouseEvents = false
        }
    }

    func closeWindow() {
        for window in windows {
            window.close()
        }
    }
}
