
import SwiftUI
import FBSDKLoginKit

struct SocialLoginView: View {
    @StateObject var manager = SocialLoginManager()
    
    var body: some View {
        VStack(spacing: 25) {
            
            Button(action: {
                manager.loginWithUser()
            }, label: {
                Text("Continue with Facebook")
                    .fontWeight(.bold)
                    .padding(.vertical,10)
                    .padding(.horizontal,30)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(Capsule())
            })
        }
    }
}

struct SocialLoginView_Previews: PreviewProvider {
    static var previews: some View {
        SocialLoginView()
    }
}
