
import SwiftUI
import FacebookLogin

struct AstronautsView: View {
    @StateObject var astronauts = AstronautsViewModel()
    @StateObject var manageLogin = SocialLoginManager()
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(entity: AstronautsDataModel.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \AstronautsDataModel.id, ascending: true)]) var results: FetchedResults<AstronautsDataModel>
    
    var body: some View {
        ZStack {
            
            if !manageLogin.logged {
                SocialLoginView()
            }
            else {
                if results.isEmpty {
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
                            await astronauts.getAstronauts(context: context)
                        }
                    }
                }
                else {
                    NavigationView {
                        
                        List(results, id: \.id) {
                            astronaut in
//                            NavigationLink(
////                                destination: AstronautDetailsView(astronaut),
//                                label: {
                                    HStack {
                                        AsyncImage(url: URL(string: astronaut.profile_image_thumbnail ?? "No Data"))
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 80, height: 80)
                                            .clipped()
                                            .cornerRadius(40)
                                        
                                        VStack(alignment: .leading) {
                                            Text(astronaut.name ?? "No name")
                                                .font(.title2)
                                            Text("Age: \(astronaut.age)")
                                                .font(.body)
                                        }.padding(4)
                                    }
//                                }
//                            )
                        }
                        .navigationTitle("Astronauts")
                        .toolbar{
                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                Button("Logout", action: {
                                    manageLogin.logoutFromUser()
                                })
                                
                            }
                        }
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
