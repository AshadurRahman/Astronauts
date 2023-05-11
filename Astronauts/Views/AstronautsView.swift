
import SwiftUI
import FacebookLogin

struct AstronautsView: View {
    @StateObject var astronauts = AstronautsViewModel()
    @StateObject var manageLogin = SocialLoginManager()
    
    var body: some View {
        ZStack {
            if !manageLogin.logged {
                SocialLoginView()
            }
            else {
                NavigationView {
                    List(astronauts.astronautsArray, id: \.id) {
                        astronaut in
                        NavigationLink(
                            destination: AstronautDetailsView(astronauts: astronaut),
                            label: {
                                HStack {
                                    AsyncImage(url: URL(string: astronaut.profile_image_thumbnail))
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 80, height: 80)
                                        .clipped()
                                        .cornerRadius(40)
                                    
                                    VStack(alignment: .leading) {
                                        Text(astronaut.name)
                                            .font(.title2)
                                        Text("Age: \(astronaut.age)")
                                            .font(.body)
                                    }.padding(4)
                                }
                            }
                        )
                    }
                    .navigationTitle("Astronauts")
                    .toolbar{
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            Button("Logout", action: {
                                manageLogin.logoutFromUser()
                            })
                            
                        }
                    }
                    .task {
                        await astronauts.getAstronauts()
                    }
                }
            if astronauts.isLoading {
                ProgressView("Loading...")
                    .tint(.blue)
                    .scaleEffect(3)
                    .font(.system(size:5))
            }
            }
            
        }
    }
    
    struct AstronautsView_Previews: PreviewProvider {
        static var previews: some View {
            AstronautsView()
        }
    }
}
