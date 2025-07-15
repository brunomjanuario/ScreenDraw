import SwiftUI

struct ToolbarView: View {
    weak var appDelegate: AppDelegate?

    var body: some View {
        HStack {
            Button("Clear All") {
                appDelegate?.canvas.clearCanvas()
            }
            
            Button("Draw") {

                appDelegate?.canvas.startDrawing()
            }

            Button("Back") {
                appDelegate?.canvas.setEraserMode()
            }

            Button("Quit") {
                NSApp.terminate(nil)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.9))
        .cornerRadius(12)
    }
}
