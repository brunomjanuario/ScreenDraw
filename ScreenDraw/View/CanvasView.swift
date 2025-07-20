import Cocoa

class CanvasView: NSView {
    private var currentPath = NSBezierPath()
    private var paths: [(path: NSBezierPath, color: NSColor, timestamp: Date)] = []
    private var drawingController: DrawingController
    var lineWidth: CGFloat = 4.0

    init(frame frameRect: NSRect, drawingController d: DrawingController) {
        drawingController = d
        super.init(frame: frameRect)
        wantsLayer = true
        layer?.backgroundColor = NSColor.clear.cgColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func mouseDown(with event: NSEvent) {
        currentPath = NSBezierPath()
        currentPath.lineWidth = lineWidth
        let point = convert(event.locationInWindow, from: nil)
        currentPath.move(to: point)
    }

    override func mouseDragged(with event: NSEvent) {
        let point = convert(event.locationInWindow, from: nil)
        currentPath.line(to: point)
        needsDisplay = true
    }

    override func mouseUp(with event: NSEvent) {
        paths.append((currentPath.copy() as! NSBezierPath, drawingController.strokeColor, Date()))
        currentPath.removeAllPoints()
    }

    override func draw(_ dirtyRect: NSRect) {
        for (path, color, date) in paths {
            color.setStroke()
            path.stroke()
        }

        drawingController.strokeColor.setStroke()
        currentPath.stroke()
    }
    
    override func rightMouseDown(with event: NSEvent) {
        if drawingController.isDrawing == true {
            drawingController.isDrawing = false
            currentPath.removeAllPoints()
            needsDisplay = true
            
            AppController.shared.ignoreMouseEvents()
        }
    }
    
    func removeLast() {
        
        if !paths.isEmpty {
            paths.removeLast()
            needsDisplay = true
        }
    }
    
    func clearCanvas() {
        paths.removeAll()
        currentPath.removeAllPoints()
        needsDisplay = true
    }
    
    func getLastDrawTimestamp() -> Date {
        
        return paths.last?.timestamp ?? Date.distantPast
    }
}
