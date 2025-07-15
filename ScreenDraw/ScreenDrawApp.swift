
import SwiftUI

@main
struct ScreenDrawApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        
        Settings {
            EmptyView()
        }
    }
}
