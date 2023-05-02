
import SwiftUI

struct AstronautDetailsView: View {
    @StateObject var astronautDetails = AstronautDetailsViewModel()
    var astronauts: AstronautsList
    
    var body: some View {
        VStack {
            
                Text(astronautDetails.name)
                    .font(.title3)
                    .fontWeight(.heavy)
                AsyncImage(url: URL(string: astronautDetails.profile_image), content: {
                    image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 350.0, height: 350.0)
                        .cornerRadius(30)
                        .shadow(radius: 5)
                }, placeholder: {
                    Image(systemName: "photo.fill")
                        .foregroundColor(.gray)
                        .frame(width: 350.0, height: 350.0)
                })
            
            List {
                Text("Flights")
                    .font(.title3)
                    .fontWeight(.heavy)
                
                ForEach(astronautDetails.flightsArray, id: \.self) {
                    flight in
                    Text(flight.name)
                        .font(.body)
                }
            }
            
            Spacer()
        }
        .padding()
        .task {
            await astronautDetails.getAstronautDetails(id: astronauts.id)
        }
    }
}

struct AstronautDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AstronautDetailsView(astronauts: AstronautsList(
            id: 1,
            name: "Thomas Pesquet",
            age: 45,
            profile_image_thumbnail: "https://spacelaunchnow-prod-east.nyc3.digitaloceanspaces.com/media/astronaut_images/thomas_pesquet_thumbnail_20220911033657.jpeg"))
    }
}
