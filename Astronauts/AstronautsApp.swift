
import SwiftUI
import FBSDKCoreKit

@main
struct AstronautsApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            AstronautsView()
        }
    }
}
