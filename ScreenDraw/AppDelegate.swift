import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    var toolbarWindow: NSWindow!
    var drawingController: DrawingController!
    var canvasList: [CanvasView] = []
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        drawingController = DrawingController()
        
        for screen in NSScreen.screens {
            
            let canvas = CanvasView(frame: screen.frame, drawingController: drawingController)
            
            window = NSWindow(
                contentRect: screen.frame,
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
            window.ignoresMouseEvents = true
            
            AppController.shared.windows.append(window)
            canvasList.append(canvas)
        }

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
        let toolbarView = NSHostingView(rootView: ToolbarView(drawingController: drawingController, appDelegate: self))

        toolbarWindow = NSWindow(
            contentRect: toolbarSize,
            styleMask: [.borderless], // No title bar, no close buttons
            backing: .buffered,
            defer: false
        )

        toolbarWindow?.isOpaque = false
        toolbarWindow?.backgroundColor = .clear
        toolbarWindow?.hasShadow = true
        toolbarWindow?.level = .floating // Always on top
        toolbarWindow?.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary] // Show on all desktops
        toolbarWindow?.contentView = toolbarView
        toolbarWindow?.isMovableByWindowBackground = true // Let user drag it
        toolbarWindow?.makeKeyAndOrderFront(nil)
    }
    
    func startDrawing(_ color: NSColor = .systemYellow) {
        drawingController.strokeColor = color
        drawingController.isDrawing = true
        AppController.shared.allowMouseEvents()
    }
    
    func clearAll() {
        
        for canvas in canvasList {
            
            canvas.clearCanvas()
        }
    }
    
    func removeLast() {
        
        for canvas in canvasList {
            
            canvas.removeLast()
        }
    }
}

