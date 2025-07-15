import AppKit

class AppController {
    static let shared = AppController()

    var mainWindow: NSWindow?

    func setMainWindow(_ window: NSWindow) {
        self.mainWindow = window
    }

    func ignoreMouseEvents() {
        mainWindow?.ignoresMouseEvents = true
        print("✅ Window is now ignoring mouse events")
    }

    func allowMouseEvents() {
        mainWindow?.ignoresMouseEvents = false
        print("✅ Window is now accepting mouse events")
    }

    func closeWindow() {
        mainWindow?.close()
    }
}
