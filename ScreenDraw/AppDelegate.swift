import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    var toolbarWindow: NSWindow!
    var canvas: CanvasView!
    var screen: NSRect!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        screen = NSScreen.main?.frame ?? .zero

        canvas = CanvasView(frame: screen)

        window = NSWindow(
            contentRect: screen,
            styleMask: .borderless,
            backing: .buffered,
            defer: false
        )

        window.level = .screenSaver
        window.isOpaque = false
        window.backgroundColor = .clear
        window.hasShadow = false
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        window.contentView = canvas
        window.makeKeyAndOrderFront(nil)
        window.ignoresMouseEvents = false
        
        AppController.shared.setMainWindow(window)

        NSApp.setActivationPolicy(.regular)
        NSApp.activate(ignoringOtherApps: true)
        showToolbarWindow()
    }
    
    func showToolbarWindow() {
        let visibleFrame = NSScreen.main?.visibleFrame
        let visibleX = visibleFrame?.maxX ?? 0
        let visibleY = visibleFrame?.maxY ?? 0

        let toolbarWidth: CGFloat = 400
        let toolbarHeight: CGFloat = 50
        let x = visibleX / 2 - 100
        let y = visibleY

        let toolbarSize = NSRect(x: x, y: y, width: toolbarWidth, height: toolbarHeight)
        let toolbarView = NSHostingView(rootView: ToolbarView(appDelegate: self))

        toolbarWindow = NSWindow(
            contentRect: toolbarSize,
            styleMask: [.borderless], // ✅ No title bar, no close buttons
            backing: .buffered,
            defer: false
        )

        toolbarWindow?.isOpaque = false
        toolbarWindow?.backgroundColor = .clear
        toolbarWindow?.hasShadow = true
        toolbarWindow?.level = .floating // ✅ Always on top
        toolbarWindow?.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary] // ✅ Show on all desktops
        toolbarWindow?.contentView = toolbarView
        toolbarWindow?.isMovableByWindowBackground = true // ✅ Let user drag it
        toolbarWindow?.makeKeyAndOrderFront(nil)
    }
}

