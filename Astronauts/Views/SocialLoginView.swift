
import SwiftUI
import FBSDKLoginKit

struct SocialLoginView: View {
    @StateObject var manager = SocialLoginManager()
    
    var body: some View {
        ZStack() {
            AnimatedBackground().edgesIgnoringSafeArea(.all)
                        .blur(radius: 50)
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

struct AnimatedBackground: View {
    @State var start = UnitPoint(x: 0, y: -2)
    @State var end = UnitPoint(x: 4, y: 0)
    
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    let colors = [Color.blue, Color.white, Color.accentColor]
    
    var body: some View {
        
        LinearGradient(gradient: Gradient(colors: colors), startPoint: start, endPoint: end)
            .onReceive(timer, perform: { _ in
                
                self.start = UnitPoint(x: 4, y: 0)
                self.end = UnitPoint(x: 0, y: 2)
                self.start = UnitPoint(x: -4, y: 20)
                self.start = UnitPoint(x: 4, y: 0)
            })
    }
}

struct SocialLoginView_Previews: PreviewProvider {
    static var previews: some View {
        SocialLoginView()
    }
}
