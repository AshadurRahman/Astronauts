
import SwiftUI
import FBSDKCoreKit

@main
struct AstronautsApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            AstronautsView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
