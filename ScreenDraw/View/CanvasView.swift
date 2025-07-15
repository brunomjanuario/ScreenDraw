import Cocoa

class CanvasView: NSView {
    private var currentPath = NSBezierPath()
    private var paths: [(path: NSBezierPath, color: NSColor)] = []
    private var isCurrentlyDrawing = true
    var strokeColor = NSColor.systemYellow
    var lineWidth: CGFloat = 4.0

    override init(frame frameRect: NSRect) {
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
        paths.append((currentPath.copy() as! NSBezierPath, strokeColor))
        currentPath.removeAllPoints()
    }

    override func draw(_ dirtyRect: NSRect) {
        for (path, color) in paths {
            color.setStroke()
            path.stroke()
        }

        strokeColor.setStroke()
        currentPath.stroke()
    }
    
    override func rightMouseDown(with event: NSEvent) {
        if isCurrentlyDrawing {
            isCurrentlyDrawing = false
            currentPath.removeAllPoints()
            needsDisplay = true
            print("Right click: drawing cancelled")
            
            AppController.shared.ignoreMouseEvents()
        } else {
            
            startDrawing()
        }
    }
    
    func startDrawing(_ color: NSColor = .systemYellow) {
        strokeColor = color
        isCurrentlyDrawing = true
        AppController.shared.allowMouseEvents()
    }
    
    func setEraserMode() {
        
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
}
