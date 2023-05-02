
import Foundation

@MainActor
class AstronautDetailsViewModel: ObservableObject {
    struct AstronautDetails: Codable {
        var name: String
        var profile_image: String
        var flights: [Flights]
    }
    
    struct Flights: Hashable, Codable {
        var name: String
    }
    
    private var urlString = "https://ll.thespacedevs.com/2.2.0/astronaut/"
    @Published var name = ""
    @Published var profile_image = ""
    @Published var flightsArray: [Flights] = []
    
    func getAstronautDetails(id: Int) async {
        print("We are accessing the data from \(urlString)")
        urlString = urlString + String("\(id)")
        
        guard let url = URL(string: urlString) else {
            print("Error: could not create an URL from \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let astronaut = try? JSONDecoder().decode(AstronautDetails.self, from: data) else {
                print("JSON Error: could not decode returned data")
                return
            }
            self.name = astronaut.name
            self.profile_image = astronaut.profile_image
            self.flightsArray = astronaut.flights
            
        } catch {
            print("Error: could not use url at \(urlString) to get data and response")
        }
    }
}
