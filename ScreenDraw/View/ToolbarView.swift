import SwiftUI

struct ToolbarView: View {
    @ObservedObject var drawingController: DrawingController
    weak var appDelegate: AppDelegate?

    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 16) {
                Button(action: {
                    appDelegate?.startDrawing(.systemYellow)
                }) {
                    Circle()
                        .fill(Color(nsColor: .systemYellow))
                        .frame(width: 24, height: 24)
                        .overlay(Circle().stroke(Color.white, lineWidth: 1))
                }.buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    appDelegate?.startDrawing(.systemRed)
                }) {
                    Circle()
                        .fill(Color(nsColor: .systemRed))
                        .frame(width: 24, height: 24)
                        .overlay(Circle().stroke(Color.white, lineWidth: 1))
                }.buttonStyle(PlainButtonStyle())
            
                Button("Clear All") {
                    appDelegate?.clearAll()
                }

                Button("Back") {
                    appDelegate?.removeLast()
                }

                Button("Quit") {
                    NSApp.terminate(nil)
                }
            }

            if drawingController.isDrawing {
                Text("Draw mode ON - right-click to exit")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.top, 4)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.9))
        .cornerRadius(12)
    }
}
