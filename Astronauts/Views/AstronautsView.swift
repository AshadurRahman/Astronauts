
import SwiftUI

struct AstronautsView: View {
    @StateObject var astronauts = AstronautsViewModel()
    
    var body: some View {
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
        }
        .task {
            await astronauts.getAstronauts()
        }
    }
}

struct AstronautsView_Previews: PreviewProvider {
    static var previews: some View {
        AstronautsView()
    }
}
