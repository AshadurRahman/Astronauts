
import Foundation
import FBSDKLoginKit
import SwiftUI

class SocialLoginManager: ObservableObject {
    @AppStorage("logged") var logged = false
    @AppStorage("email") var email = ""
    @State var manager = LoginManager()
    
    func loginWithUser() {
        manager.logIn(permissions: ["public_profile", "email"], from: nil) {
            (result, error) in
            if error != nil{
                print(error!.localizedDescription)
                return
            }
            
            if !result!.isCancelled{
                self.logged = true
                
                let request = GraphRequest(graphPath: "me", parameters: ["fields" : "email"])
                
                request.start { [self](_, res, _) in
                    guard let profileData = res as? [String : Any] else {return}
                    
                    self.email = profileData["email"] as! String
                }
            }
        }
    }
    
    func logoutFromUser() {
        self.manager.logOut()
        self.email = ""
        self.logged = false
    }
}
